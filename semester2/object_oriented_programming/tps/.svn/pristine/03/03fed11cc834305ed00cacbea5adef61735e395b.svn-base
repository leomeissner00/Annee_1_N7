package editeur.commande;

import editeur.Ligne;

public class CommandeCurseurDebut extends CommandeLigne {
	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeCurseurDebut(Ligne l) {
		super(l);
	}

	public void executer() {
		while(ligne.getCurseur() != 1) {
			ligne.reculer();
		}
		
	}

	public boolean estExecutable() {
		return ligne.getCurseur() > 1;
	}
}