
public class EnsembleChaine implements Ensemble {

	private Cellule cel;
	
	/**Renvoie le cardinal de l'ensemble
	 * 
	 */
	public int cardinal() {
		Cellule curseur = this.cel;
		int somme = 0;
		while (curseur!= null) {
			somme ++;
			curseur = curseur.getSuivant();
		}
		return somme;
	}

	/**
	 * Renvoie si l'ensemble est vide ou non.
	 * @return true si ensemble vide
	 */
	public boolean estVide() {
		return this.cel == null;
	}

	/**Vérifie si un élement appartient à l'ensemble
	 * @parma int x l'élement à rechercher
	 * @return boolean true si x est dans l'ensemble 
	 */
	public boolean contient(int x) {
		Cellule curseur = this.cel;
		boolean contenir = false;
		while (curseur!= null & !contenir) {
			contenir = (curseur.getElement() == x);
			curseur = curseur.getSuivant();
		}
		return contenir;
	}

	/**
	 * Ajoute un élément à l'ensemble
	 * @parma int x l'élement à ajouter
	 */
	public void ajouter(int x) {
		if (this.cel == null) {
			this.cel = new Cellule(x);
		}
		else {
			if (this.contient(x) == false) {
				Cellule add = new Cellule(x);
				add.setSuivant(this.cel);
				this.cel = add;
			}
		}
		
	}

	/**
	 * Supprime un élément ciblé de l'ensemble
	 * @parma int x l'élément a supprimer
	 */
	public void supprimer(int x) {
		if (this.contient(x)) {
			Cellule curseur = this.cel;
			Cellule prec = this.cel;
			while (curseur.getElement() != x) {
				prec = curseur;
				curseur = curseur.getSuivant();
			}
			prec.setSuivant(curseur);
			this.cel = prec;
		}
		
	}

}
