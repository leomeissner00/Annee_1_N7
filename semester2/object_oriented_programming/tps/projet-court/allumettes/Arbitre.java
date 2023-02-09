package allumettes;

public class Arbitre {

    /** Joueur numéro 1. */
    private Joueur j1;

    /** Joueur numéro 2. */
    private Joueur j2;

    /**Nombre de tour de la partie. */
    private int nbTour;
    /**Montre si l'arbitre est confiant ou non.*/
    private boolean confiant;

    /**
     * Construit un arbitre à partir de ses joueurs, j1 et j2.
     * @param newJ1
     * @param newJ2
     */
    public Arbitre(Joueur newJ1, Joueur newJ2) {
        this.j1 = newJ1;
        this.j2 = newJ2;
        this.nbTour = 0;
        this.confiant = false;
    }

	/**Vérifie la validité d'une stratégie.
	 *
	 * @param : le type de stratégie qu'un joueur joue
	 * @throws : Configuration Exception
	 * @return boolean indiquant si la strategie existe ou non
	 */
	public static Strategie getStrategie(String type) throws ConfigurationException {
		switch (type) {
		case "humain":
			return new StrategieHumaine();
		case "naif":
			return new StrategieNaive();
		case "rapide":
			return new StrategieRapide();
		case "expert":
			return new StrategieExpert();
		case "tricheur":
			return new StrategieTricheur();
		default:
			throw new ConfigurationException("Cette stratégie n'existe pas.");

		}
	}

    /**
     * Détermine si la partie est terminée.
     * @param jeu
     * @return
     */
    boolean finDePartie(Jeu jeu) {
    	return (jeu.getNombreAllumettes() != 0);
    }

    public int getNbTour() {
    	return nbTour;
    }

    /**Incrémente le nombre de tour de 1.
	 *
	 */
	public void incNbTour() {
		this.nbTour++;
	}

    /**
     * Détermine le joueur qui doit jouer au prochain tour.
     * @return Joueur : le prochain joueur à jouer
     */
    Joueur auTourDe() {
    	if (getNbTour() % 2 == 0) {
    		return j1;
    	} else {
    		return j2;
    	}
    }

    /**Permet de modifier l'attribut confiant de l'arbitre.
     *
     * @param vconfiant : nouveau confiant de l'arbitre
     */
    void setConfiant(boolean vconfiant) {
    	this.confiant = vconfiant;
    }

    public void arbitrer(Jeu jeu) {
    	boolean jouer = true;
    	boolean aBienJouer = true;
		Joueur jEnCours;
		Jeu jeuArbitre = jeu;

		int aRetirer;

		do {
			if (aBienJouer) {
				System.out.println("Allumettes restantes : " + jeu.getNombreAllumettes());
			}
			jEnCours = auTourDe();

			try {
				aBienJouer = true;
		    	if (!this.confiant) {
		    		jeu = new Procuration(jeu);
		    	}
				aRetirer = jEnCours.getPrise(jeu);

				if (aRetirer == 1 | aRetirer == 0 | aRetirer == -1) {
					System.out.println(jEnCours.getNom() + " prend "
				+ aRetirer + " allumette.");
				} else {
					System.out.println(jEnCours.getNom() + " prend "
				+ aRetirer + " allumettes.");
				}
				jeuArbitre.retirer(aRetirer);
				incNbTour();

			} catch (OperationInterditeException e) {
				System.out.println("Abandon de la partie car "
			+ jEnCours.getNom() + " triche!");
				System.out.println();
				break;
			} catch (EntreeInvalideException e) {
				aBienJouer = false;
				System.out.println(e.getProbleme());
			} catch (CoupInvalideException e) {
				System.out.println(e.getProbleme());
			}
			if (aBienJouer) {
				System.out.println("");
				jouer = finDePartie(jeuArbitre);
			}

		} while (jouer);
		if (jeuArbitre.getNombreAllumettes() == 0) {
			System.out.println(jEnCours.getNom() + " perd !");
			System.out.println(auTourDe().getNom() + " gagne !");
		}
    }
}
