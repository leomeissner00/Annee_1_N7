package allumettes;

public class Joueur {

    /**Nom du joueur.
     * Nom est un String
     */
    private String nom;

    /**Stratégie du joueur.
     * Type est une strategie
     */
    private Strategie type;

    Joueur(String vnom, String vtype) throws ConfigurationException {
    	if (vnom.length() == 0) {
    		throw new ConfigurationException("Le nom doit être composé"
    				+ " d'au moins 1 caractère.");
    	}
        this.nom = vnom;
        this.type = Arbitre.getStrategie(vtype);
    }

    /**Renvoie le nom du joueur.
     * @return String : le nom du joueur
     */
    public String getNom() {
        String temp = this.nom;
        return temp;
    }

    /**Recupere le nombre d'allumettes que le joueur veut prendre.
     * @param Jeu jeu : le jeu dans lequelles les allumettes sont prises.
     * @throws : CoupInvalideException, EntreeInvalideException
     * @return int : le nombre d'allumettes que le joueur veut récupérer.
     */
    public int getPrise(Jeu jeu) throws CoupInvalideException, EntreeInvalideException {
        return this.type.getPrise(jeu, this.nom);
    }
}
