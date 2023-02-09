#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define Taille 5

// Definition du type monnaie
// 
struct t_monnaie {
    float valeur;
    char devise;
};
typedef struct t_monnaie t_monnaie;

/**
 * \brief Initialiser une monnaie 
 * \param[t_monnaie monnaie, int valeur, char devise]
 * \pre 
 * // valeur > 0
 */ 
void initialiser(t_monnaie *monnaie, float val, char dev){
    monnaie->valeur = val;
    monnaie->devise = dev;
}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[t_monnaie m1, t_monnaie m2]
 * // TODO
 */ 
bool ajouter(t_monnaie *m1, t_monnaie *m2){
    bool correct = false;
    if (m1->devise == m2->devise){
        m2->valeur = m1->valeur+m2->valeur;
        correct = true;
    }
}


/**
 * \brief Tester Initialiser 
 * \param[]
 * // TODO
 */ 
void tester_initialiser(t_monnaie *monnaie, float val, char dev){
    
    assert(val == monnaie->valeur);
    assert(dev == monnaie->devise);
}

/**
 * \brief Tester Ajouter 
 * \param[]
 * // TODO
 */ 
void tester_ajouter(){
    t_monnaie m1;
    float  val = 5;
    char dev = 'e';
    initialiser(&m1, val, dev);
    t_monnaie m2;
    val = 3;
    dev = 'e';
    initialiser(&m2, val, dev);
    ajouter (&m1,&m2);

    t_monnaie m3;
    val = 3;
    dev = '$';
    ajouter(&m3, &m2);

    assert(8 == m2.valeur);
    assert('e' == m2.devise);
}

void viderBuffer()
{
    int c = 0;
    while (c != '\n' && c != EOF)
    {
        c = getchar();
    }
}

int main(void){
    // Un tableau de 5 monnaies
    // TODO
    t_monnaie porte_monnaie[Taille-1];
    //Initialiser les monnaies
    // TODO
    float mavaleur;
    char madevise;
    tester_ajouter();
    printf("Rentrer votre 1 ère Monnaie (Valeur + Devise) \n");
    scanf("%f %c", &mavaleur, &madevise);
    initialiser(&porte_monnaie[0], mavaleur, madevise);
    tester_initialiser(&porte_monnaie[0], mavaleur, madevise);
    viderBuffer();
    

    for (int i = 1; i <= Taille-1; i++) {
       printf("Rentrer votre  %i ème Monnaie (Valeur + Devise) \n", i+1 );
       scanf("%f %c", &mavaleur, &madevise); 
       printf("\n");
       initialiser(&porte_monnaie[i], mavaleur, madevise);
       tester_initialiser(&porte_monnaie[i], mavaleur, madevise);
       viderBuffer();
    }
    // Afficher la somme des toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
    // TODO
    printf("Avec quelle devise voulez-vous faire votre somme?\n");
    scanf("%c", &madevise);
    printf("\n");
    t_monnaie somme;
    mavaleur = 0;
    initialiser(&somme, mavaleur, madevise);

    for (int i = 0; i <= Taille-1; i++) {
       ajouter(&porte_monnaie[i], &somme);
    }
    printf("La somme est de %1.2f %c\n", somme.valeur, madevise);


    return EXIT_SUCCESS;
}
