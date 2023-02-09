#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>


void num_signal(int sign) {
    printf("Reception %d\n", sign);
}

int main(int argc, char* argv[]) {

    //Creation du handler
    struct sigaction signal;
    signal.sa_handler = &num_signal;
    sigemptyset(&signal.sa_mask);

    //Set de masquage
    sigset_t masque;
    sigemptyset(&masque);
    sigaddset(&masque, SIGINT);
    sigaddset(&masque, SIGUSR1);

    //Association du handler
    sigaction(SIGUSR1, &signal, NULL );
    sigaction(SIGUSR2, &signal, NULL );

    //Masquage des signaux
    sigprocmask(SIG_BLOCK, &masque, NULL);

    //Attente de 10s 
    sleep(10);

    //S'envoie 2 signaux SIGUSR1
    kill(getpid(), SIGUSR1); 
    kill(getpid(), SIGUSR1);

    //Attente de 5s
    sleep(5);

    //S'envoie 2 signaux SIGUSR2
    kill(getpid(), SIGUSR2);
    kill(getpid(), SIGUSR2);

    //Demasquage de SIGUSR1
    sigdelset(&masque, SIGINT);
    sigprocmask(SIG_UNBLOCK, &masque, NULL);
    sigaddset(&masque, SIGINT);
    //Attente de 10s
    sleep(10);

    //Demasquage de SIGINT
    sigdelset(&masque, SIGUSR1);
    sigprocmask(SIG_UNBLOCK, &masque, NULL);

    //Affichage de Salut
    printf("\nSalut");    
}