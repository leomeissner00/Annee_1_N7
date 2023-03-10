/* version 0.2.2 (PM, 16/5/22) :
	Le serveur de conversation
	- crée un tube (fifo) d'écoute (avec un nom fixe : ./ecoute)
	- gère un maximum de maxParticipants conversations : attente (select) sur
		* tube d'écoute : accepter le(s) nouveau(x) participant(s) si possible
			-> initialiser et ouvrir les tubes de service (entrée/sortie) fournis
		* tubes (fifo) de service en entrée -> diffuser sur les tubes de service en sortie
	- détecte les déconnexions lors du select
	- se termine lorsqu'un client de pseudo "fin" se connecte
	Protocole
	- suppose que les clients ont créé les tubes d'entrée/sortie avant la demande de connexion,
		et que ces tubes sont nommés par le nom du client, suffixé par _C2S/_S2C.
	- les échanges par les tubes se font par blocs de taille fixe, dans l'idée d'éviter
	  le mode non bloquant
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#include <stdbool.h>
#include <sys/stat.h>

#define MAXPARTICIPANTS 5		/* seuil au delà duquel la prise en compte de nouvelles
								 						 	   connexions sera différée */
#define TAILLE_MSG 128			/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25			/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */

typedef struct ptp { 			/* descripteur de participant */
    bool actif; /* indique si le descripteur correspond à un client effectivement connecté */
    char nom [TAILLE_NOM];
    int in;		/* tube d'entrée (C2S) */
    int out;	/* tube de sortie (S2C) */
} participant;


participant participants [MAXPARTICIPANTS];

char buf[TAILLE_RECEPTION]; 	/* tampon de messages reçus/à rediffuser */
int nbactifs = 0;				/* nombre de clients effectivement connectés */

void effacer(int i) { /* efface le descripteur pour le participant i */
    participants[i].actif = false;
    bzero(participants[i].nom, TAILLE_NOM*sizeof(char));
    participants[i].in = -1;
    participants[i].out = -1;
}


void ajouter(char *dep) { // traite la demande de connexion du pseudo référencé par dep
/*  (**** à faire ****) 
	Si le participant est "fin", termine le serveur (et gère la terminaison proprement)
	Sinon, ajoute un participant actif, de pseudo référencé par dep
*/
	int i;
	nbactifs ++;

	if (!strcmp(dep,"fin")){
		int i;
		for (i=0; i< MAXPARTICIPANTS; i++){
			if (participants[i].actif == true){
				desactiver(i);
			}
		}
	}

	while ((participants[i].actif == true) && (i< MAXPARTICIPANTS)){
		i ++;
	}
	participants[i].actif = true;


	char dep2 [TAILLE_NOM];
	strcpy(dep2, dep);
	strcpy(participants[i].nom, dep);
	if ((participants[i].in = open(strcat(dep2, "_C2S"), O_RDONLY))==-1){
		perror("open in ");
		exit(10);
	}
	strcpy(dep2, dep);
	participants[i].out = open(strcat(dep2, "_S2C"), O_WRONLY);
}

void desactiver (int p) {
/*  (**** à faire ****) traitement d'un participant déconnecté */
	close(participants[p].in); 
	close(participants[p].out);
	effacer(p);
}

void diffuser(char *dep) { 
/* (**** à faire ****) envoi du message référencé par dep à tous les actifs */
	int i;
	for (i=0; i< MAXPARTICIPANTS; i++){
		if (participants[i].actif == true){
			write(participants[i].in, dep, TAILLE_RECEPTION);
		}
	}
}

int main (int argc, char *argv[]) {
    int i,nlus,necrits,res;
    int ecoute;				/* descripteur d'écoute */
    fd_set readfds; 		/* ensemble de descripteurs écoutés par le select */
    char * prochainMessage; /* pour parcourir le contenu du tampon de réception */
	char bufDemandes [TAILLE_NOM*sizeof(char)*MAXPARTICIPANTS]; 
	/* tampon requêtes de connexion. Inutile de lire plus de MAXPARTICIPANTS requêtes */

    /* création (puis ouverture) du tube d'écoute */
    mkfifo("./ecoute",S_IRUSR|S_IWUSR); // mmnémoniques sys/stat.h: S_IRUSR|S_IWUSR = 0600
    ecoute=open("./ecoute",O_RDONLY);
	int ecoute2 = open("./ecoute",O_WRONLY);

    for (i=0; i< MAXPARTICIPANTS; i++) {
        effacer(i);
    }
	
	/* (**** à faire [éventuellement] ****) : autres initialisations */
    while (true) {
        printf("participants actifs : %d\n",nbactifs);
	/* (**** à faire ****) : boucle du serveur : traiter les requêtes en attente 
				 * 	sur le tube d'écoute : ajouter de nouveaux participants 
				 	(tant qu'il y a moins de MAXPARTICIPANTS actifs)
				 * 	sur les tubes d'entrée : lire les messages, et les diffuser.
		   			Note : 
		   			- tous les messages comportent TAILLE_MSG caractères, et les tailles sont
		   			  fixées pour qu'il n'y ait pas de message tronqué, pour simplifier la gestion. 
		   			- un tampon peut contenir plusieurs messages (et prochainMessage est destiné
				  	  à repérer le prochain message du tampon du tube c2s à diffuser)
					- Enfin, on ne traite pas plus de TAILLE_RECEPTION/TAILLE_MSG*sizeof(char)
					  à chaque itération.
    				- dans le cas où la terminaison d'un participant est détectée, gérer sa déconnexion
    				- Attention : le serveur doit fonctionner même lorsqu'aucun client n'est
    				 connecté (de nouveaux clients peuvent se connecter à tout moment)
	*/
		FD_ZERO(&readfds);
		FD_SET(ecoute, &readfds);
		for (i=0; i< MAXPARTICIPANTS; i++) {
			if (participants[i].actif){
				FD_SET(participants[i].in, &readfds);
			}
        
    	}

		

		int retour = select(NBDESC, &readfds, NULL, NULL, NULL);
		switch(retour) {
                case -1 :
                    perror("select client");
                case 0 :
                    break;
                default :
					if (FD_ISSET(ecoute, &readfds)) {
						bzero(bufDemandes, TAILLE_NOM); // nettoyage
                        if ((necrits = read(ecoute,&bufDemandes,TAILLE_NOM))>0){
							ajouter(&bufDemandes);
                        }  
                    }

					for (i=0; i< MAXPARTICIPANTS; i++) {
						if (participants[i].actif){
							if (FD_ISSET(participants[i].in, &readfds)) {
								if ((nlus = read(participants[i].in,&prochainMessage,TAILLE_RECEPTION))>0){
									if (strcmp(&prochainMessage,"au revoir")==0){
										desactiver(i);
									} else {
										diffuser(&prochainMessage);
									}
									
								} 
							}
						}
					}
        
    	}
		
    }
}