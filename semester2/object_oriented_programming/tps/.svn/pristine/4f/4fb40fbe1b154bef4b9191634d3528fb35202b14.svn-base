package editeur.commande;
import editeur.Ligne;
import menu.Menu;

public class CommandeAccesSousMenu extends CommandeLigne{
	private Menu sousMenu;
	
	/** Accède au sous menu 1
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeAccesSousMenu(Ligne l, Menu vsousMenu) {
		super(l);
		this.sousMenu = vsousMenu;
	}

	public void executer() {
		
		// Afficher la ligne
		System.out.println();
		ligne.afficher();
		System.out.println();
		
		// Afficher le menu
		this.sousMenu.afficher();

		// Sélectionner une entrée dans le menu
		this.sousMenu.selectionner();

	    // Valider l'entrée sélectionnée
		this.sousMenu.valider();
	}

	public boolean estExecutable() {
		return ligne.getCurseur() > 1;
	}
}
