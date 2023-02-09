package editeur.commande;

import editeur.Ligne;

public class CommandeSupprimerCaractere extends CommandeLigne{
	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeSupprimerCaractere(Ligne l) {
		super(l);
	}

	public void executer() {
		ligne.supprimer();
	}

	public boolean estExecutable() {
		return ligne.getCurseur() != 0;
	}
}
