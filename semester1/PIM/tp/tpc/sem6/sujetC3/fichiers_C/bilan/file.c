/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file file.c
 *
 *  Objectif :
 *	Implantation des op�rations de la file
*/

#include <malloc.h>
#include <assert.h>
#include "file.h"

void initialiser(File *f)
{
    f->tete = NULL;
    f->queue = NULL;
    assert(est_vide(*f));
}

void couperLaTeteDuSerpent(Cellule *c){
    if (c->suivante != NULL){
        couperLaTeteDuSerpent(c->suivante);
    }
    free(c);
}


void detruire(File *f)
{
    if (! est_vide(*f)){
        couperLaTeteDuSerpent(f->tete);
        f->tete = NULL;
        f->queue = NULL;
    }
}


char tete(File f)
{
    assert(! est_vide(f));
    return f.tete->valeur;

}


bool est_vide(File f)
{
    return f.tete == NULL && f.queue == NULL;
}

/**
 * Obtenir une cellule cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis� en param�tre.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
    Cellule *nouvelle = malloc(sizeof(Cellule));
    nouvelle->valeur = valeur;
    nouvelle->suivante = suivante;
    return nouvelle;
}


void inserer(File *f, char v)
{
    assert(f != NULL);
    Cellule* aInserer = cellule(v, NULL);
    if(est_vide(*f)){
        f->queue = aInserer; 
        f->tete = aInserer;

    } else {
        f->queue->suivante = aInserer;
        f->queue = aInserer;

    }
}

void extraire(File *f, char *v)
{
    assert(f != NULL);
    assert(! est_vide(*f));

    Cellule* aExtraire = f->tete;
    f->tete = f->tete->suivante;
    *v = aExtraire->valeur;
    aExtraire->suivante = NULL;

    free(aExtraire);
    aExtraire = NULL;
    
    if(f->tete == NULL){
        f->queue = NULL;

    }
}


int longueur(File f)
{
    int l = 0;
    Cellule* pointeur = f.tete;
    while (pointeur != NULL){
        pointeur = pointeur->suivante;
        l++;

    }
    return l;
}
