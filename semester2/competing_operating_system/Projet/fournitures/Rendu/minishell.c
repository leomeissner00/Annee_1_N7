#define NBMAXPROC 20
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include "readcmd.h"

enum activite {actif, suspendu};
typedef enum activite activite;

typedef struct proc {
    int id;
    pid_t pid;
    activite etat;
    char *lacommande;
} proc ;

proc tabProc[NBMAXPROC];
int indEnCours = 0;
int pidCourant = 0;

void listerProc(proc processus){
    tabProc[indEnCours] = processus;
    indEnCours++;  
}

/*renvoyer un identifiant libre*/
int idLibre(){
    int compteur=0;
    int k;
    int checkbgfg=0;
    while(compteur<=indEnCours){
       for(k=0; k<=indEnCours; k++){
           if(tabProc[k].id==compteur){
               checkbgfg = 1;
               break;
           } else {
               checkbgfg = 0;
           }
        }
        if (checkbgfg == 1){
            compteur++;
        } else {
            return compteur;
        }
    }
    return 0;
}

/*afficher les processus en cours*/
void afficherProc(){
    int compteur;
    printf("Id : PID :  Etat :   Commande : \n");
    for (compteur = 0; compteur < indEnCours; compteur++){
        if (tabProc[compteur].etat == actif){
            printf("%d    %d  %s %s \n", tabProc[compteur].id, tabProc[compteur].pid, "actif   ", tabProc[compteur].lacommande);
        } else {
            printf("%d    %d  %s %s \n", tabProc[compteur].id, tabProc[compteur].pid, "suspendu", tabProc[compteur].lacommande);
        }
    }
}

/*supprimer un processus à partir de son id*/
void enleverProc(int idSuppr){
    int compteur = 0;
    while(tabProc[compteur].id != idSuppr && compteur <= indEnCours){
        compteur = compteur+1;
    }
    if(compteur > indEnCours){
        printf("ID inexistant");
    } else if(compteur == indEnCours) {
        indEnCours--;
    } else {
        while(compteur < indEnCours){
            tabProc[compteur] = tabProc[compteur+1];
            compteur++;
        }
        indEnCours--;
    }
}

/*renvoyer l'identifiant d'un processus à partir de son pid*/
pid_t checkerPID(int ID){
    int compteur = 0;
    while(tabProc[compteur].id != ID && compteur <= indEnCours){
        compteur = compteur+1;
    }
    if(compteur <= indEnCours){
        return tabProc[compteur].pid;
    } else {
        printf("ID inexistant");
    }
    return -1;
}

/*arrêter un processus à partir de son id*/
void enleverProcPID(pid_t pidSuppr){
    int compteur = 0;
    while(tabProc[compteur].pid != pidSuppr && compteur <= indEnCours){
        compteur = compteur+1;
    }
    if(compteur > indEnCours){
        printf("PID inexistant");
    } else if(compteur == indEnCours) {
        indEnCours--;
    } else {
        while(compteur < indEnCours){
            tabProc[compteur] = tabProc[compteur+1];
            compteur++;
        }
        indEnCours--;
    }
}

/*arrêter un processus à partir de son pid*/
void arreterProc(pid_t PID){
    int compteur = 0;
    while(tabProc[compteur].pid != PID && compteur <= indEnCours){
        compteur = compteur+1;
    }
    if(compteur <= indEnCours){
        
        tabProc[compteur].etat = suspendu;
        kill(PID, SIGSTOP);
    } else {
        printf("PID inexistant");
    }
}

/*rallumerProc permet de traiter les commandes bg et fg*/
void rallumerProc(pid_t PID, int checkbgfg){
    int compteur = 0;
    while(tabProc[compteur].pid != PID && compteur <= indEnCours){
        compteur = compteur+1;
    }
    if(compteur <= indEnCours){

        tabProc[compteur].etat = actif;
    } else {
        printf("PID inexistant");
    }
    if (checkbgfg == 1) {
        int status;
        pidCourant = PID;
        kill(PID, SIGCONT);
        waitpid(PID, &status, WUNTRACED);
        
    } else {

        kill(PID, SIGCONT);
    }
}

void background_handler(int sig, siginfo_t *info, void *ucontext) {
    if (info->si_status == EXIT_FAILURE || info->si_status == EXIT_SUCCESS || info->si_status == SIGKILL) {
        enleverProcPID(info->si_pid);
    }  else if (info->si_status == SIGCONT) {
        rallumerProc(info->si_pid, 0);
    } else if (info->si_status == SIGSTOP || info->si_status == SIGTSTP) {
 
        arreterProc(info->si_pid);
    } else {
        printf("erreur de statut : %d", info->si_status);
    }

}

void interruption_handler(int sig) {
    if (pidCourant > 0) {
        kill(pidCourant, SIGKILL);
        pidCourant = 0;
    } 
}

void stop_handler(int sig) {
    if (pidCourant > 0) {
        kill(pidCourant, SIGSTOP);
        pidCourant = 0;
    } 
}

int main(int argc, char *argv[]) {

    //creation handler background
    struct sigaction monsig;
    monsig.sa_sigaction = &background_handler;
    monsig.sa_flags = SA_SIGINFO|SA_RESTART;
    sigemptyset(&monsig.sa_mask);
    
    sigaction(SIGCHLD, &monsig, NULL);

    //creation handler interruption
    struct sigaction intsig;
    intsig.sa_handler = &interruption_handler;
    intsig.sa_flags = SA_RESTART;
    sigemptyset(&intsig.sa_mask);
    
    sigaction(SIGINT, &intsig, NULL);

    //creation handler stop
    struct sigaction stopsig;
    stopsig.sa_handler = &stop_handler;
    stopsig.sa_flags = SA_RESTART;
    sigemptyset(&stopsig.sa_mask);
    
    sigaction(SIGTSTP, &stopsig, NULL);

    struct cmdline *commande; /*structure de commande saisie par l'utilisateur */
    pid_t Fils ; /* pid du fils */
    int resultat;
    while(1){
        printf(">>>");
        commande = readcmd(); /* commande entrée par l'utilisateur */
        if(commande == NULL || (commande->seq[0] == NULL) || strcmp(commande->seq[0][0], "exit") == 0){
            break; /* arret lorsque  exit est entre ou ctrl + D*/}
        if((strcmp(commande->seq[0][0], "cd") == 0) && (commande->seq[0][1]== NULL)){
            chdir("/home/");
        } else if((strcmp(commande->seq[0][0], "cd") == 0) && (commande->seq[0][1]!= NULL)){ 
            chdir(commande->seq[0][1]);
        } else if (strcmp(commande->seq[0][0], "lj") == 0){
            afficherProc();
        } else if (strcmp(commande->seq[0][0], "sj") == 0){
            int idProc = strtol(commande->seq[0][1], NULL, 10);
            arreterProc(checkerPID(idProc));
        } else if (strcmp(commande->seq[0][0], "fg") == 0){
            int idProc = strtol(commande->seq[0][1], NULL, 10);
            rallumerProc(checkerPID(idProc),1);
        } else if (strcmp(commande->seq[0][0], "bg") == 0){
            int idProc = strtol(commande->seq[0][1], NULL, 10);
            rallumerProc(checkerPID(idProc),0);
        } else {
            Fils = fork();
            if (Fils == -1) {
                perror("fork\n"); /* lorsque erreur avec le fork */
                exit(1);
            } else if (Fils == 0) {
                /* execution du fils */ 
                sigset_t mask_set;
                sigemptyset(&mask_set);
                sigaddset(&mask_set, SIGINT);
                sigaddset(&mask_set, SIGTSTP);
                sigprocmask(SIG_BLOCK, &mask_set, NULL);

                /*Redirection*/
                int in;
                int out;
                if ((commande->in != NULL) || (commande->in != NULL)){
                    if (commande->in != NULL) {
                        if ((in = open(commande->in, O_RDWR | O_CREAT, 0666)) == -1){
                            perror("Erreur d'ouverture du fichier en entrer");
                            exit(1);
                        }
                        dup2(in,0);
                        close(in);
                    }
                    if (commande->out != NULL) {
                        if ((out = open(commande->out, O_RDWR | O_CREAT, 0666)) == -1){
                            perror("Erreur d'ouverture du fichier en sortie");
                            exit(1);
                        }
                        dup2(out, 1);
                        close(out);
                    }
                } else if (commande->seq[1] != NULL) { /* Réalisation d'un tube simple*/
                    int tuyau[2];
                    pipe(tuyau);
                    int petitFils = fork();
                    switch (petitFils) {
                        case -1 :
                            perror("Erreur création fils");
                            exit(3);
                        case 0 :
                            
                            close(tuyau[0]);
                            dup2(tuyau[1], 1);
                            close(tuyau[1]);
                            execvp(commande->seq[0][0], commande->seq[0]);
                        default :
                            close(tuyau[1]);
                            dup2(tuyau[0], 0);
                            close(tuyau[0]);
                            execvp(commande->seq[1][0], commande->seq[1]);
                            
                    }
                } else {
                    execvp(commande->seq[0][0],commande->seq[0]); 
                    perror("Erreur execution");
                    exit(1);
                }
            } else {
                /* ajout du processus aux processus en cours*/
                proc processus;
                processus.lacommande = malloc(8*strlen(commande->seq[0][0]));
                processus.id = idLibre();
                processus.etat = actif;
                processus.pid = Fils;
                
                strcpy(processus.lacommande, commande->seq[0][0]);
                listerProc(processus);
                pidCourant = Fils;
                /* attente du fils lorsqu'il est en premier plan*/
                if(commande->backgrounded == NULL) {
                    
                    waitpid(Fils,&resultat,WUNTRACED);
                } 
            }
        }
    }
}
