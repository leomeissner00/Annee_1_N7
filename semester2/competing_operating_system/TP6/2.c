#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>

void garnir(char zone[], int lg, char motif) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		zone[ind] = motif ;
	}
}

void lister(char zone[], int lg) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		printf("%c",zone[ind]);
	}
	printf("\n");
}

int main(int argc,char *argv[]) {
	int taillepage = sysconf(_SC_PAGESIZE);
	int taillezone = 3*taillepage;
    
    int d;
    if( (d = open ("fichier.txt", O_WRONLY | O_CREAT | O_TRUNC, NULL)) == -1) {
        perror("Erreur de création du fichier");
    }
    
    char tampon[taillezone];
    garnir(tampon, taillezone, 'a');
    if (write(d, tampon, taillezone) ==-1) {
        perror("Erreur d'écriture dans le fichier");
    }
    
    close(d);
    
    if( (d = open ("fichier.txt", O_RDWR , NULL)) == -1) {
        perror("Erreur de ouverture du fichier");
    }
    
	char* zone = mmap(NULL, taillezone, PROT_READ | PROT_WRITE, MAP_SHARED, d, 0);
	if (zone == MAP_FAILED) {
	    perror("PB map");
	}
	
    int fils = fork();
    if (fils < 0 ){
        perror("Erreur");
        exit(EXIT_FAILURE);
    } else if (fils == 0){
        zone = mmap(NULL, taillezone, PROT_READ | PROT_WRITE, MAP_PRIVATE, d, 0);
    
        lister( zone, 10);
        sleep(4);
        lister( zone, 10);
        lister( zone+taillepage, 10);
        lister( zone+2*taillepage, 10);
        garnir(zone+taillepage,  taillepage, 'd');
        sleep(8);
        lister( zone, 10);
        lister( zone+taillepage, 10);
        lister( zone+2*taillepage, 10);
        
    } else {
        sleep(1);
        garnir(zone, taillepage,'b');
        garnir(zone+taillepage, taillepage,'b');
        
        sleep(6);
        
        wait(&fils);
        lister( zone, 10);
        lister( zone+taillepage, 10);
        lister( zone+2*taillepage, 10);
    }
    return EXIT_SUCCESS; 
}
