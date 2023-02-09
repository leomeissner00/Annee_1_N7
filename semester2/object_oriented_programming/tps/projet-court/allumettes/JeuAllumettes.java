package allumettes;

public class JeuAllumettes implements Jeu {


    /**Nombres d'allumettes encore en jeu. */
    private int nbAllumettes;

    /**Construit un JeuAllumettes.
     * @param nbInitiale : nombre d'allumettes initialement dans le jeu.
     */
    JeuAllumettes(int nbInitiale) {
    	this.nbAllumettes = nbInitiale;
    }

	/** Obtenir le nombre d'allumettes encore en jeu.
	 * @return nombre d'allumettes encore en jeu
	 */
	public int getNombreAllumettes() {
        return this.nbAllumettes;
    }

	/** Retirer des allumettes.  Le nombre d'allumettes doit être compris
	 * entre 1 et PRISE_MAX, dans la limite du nombre d'allumettes encore
	 * en jeu.
	 * @param nbPrises nombre d'allumettes prises.
	 * @throws CoupInvalideException tentative de prendre un nombre invalide d'allumettes
	 */
	public void retirer(int nbPrises) throws CoupInvalideException {
			if ((nbAllumettes - nbPrises) < 0) {
				throw new CoupInvalideException(nbPrises,
						"Impossible ! Nombre invalide : "
			+ nbPrises + " (> " + this.nbAllumettes + ")");
			}
	        if (nbPrises < 1) {
	            throw new CoupInvalideException(nbPrises,
	            		"Impossible ! Nombre invalide : "
	        + nbPrises + " (< 1)");
	        }
	        if (nbPrises > PRISE_MAX) {
	            throw new CoupInvalideException(nbPrises,
	            		"Impossible ! Nombre invalide : "
	        + nbPrises + " (> " + PRISE_MAX + ")");
	        }

        this.nbAllumettes -= nbPrises;
    }
}
