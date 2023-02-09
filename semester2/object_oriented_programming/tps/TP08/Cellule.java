
public class Cellule {
	private int element;
	private Cellule suivant;
	
	/** Construire une cellule à partir d'un élement
	 * @param un entier
	 */
	public Cellule(int elt) {
		this.element = elt;
		this.suivant = null;
	}
	
	/** Récupérer l'élement de la cellule
	 * 
	 */
	public int getElement() {
		return this.element;
	}

	/** Récupérer l'élement de la cellule
	 * 
	 */
	public Cellule getSuivant() {
		return this.suivant;
	}
	
	/** Modifier l'élement d'une cellule
	 * @param elt la variable qui remplace l'élément de la cellule
	 */
	public void setElement(int elt) {
		this.element = elt;
	}
	
	/** Modifier l'élement d'une cellule
	 * @param cel la variable qui remplace l'élément de la cellule
	 */
	public void setSuivant(Cellule cel) {
		this.suivant = cel;
	}
}
