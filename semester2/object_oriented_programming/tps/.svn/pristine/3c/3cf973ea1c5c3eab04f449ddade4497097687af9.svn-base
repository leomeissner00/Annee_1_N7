/**
 * Définition d'un agenda individuel.
 */
public class AgendaIndividuel extends AgendaAbstrait {

	private String[] rendezVous;	// le texte des rendezVous


	/**
	 * Créer un agenda vide (avec aucun rendez-vous).
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom nul ou vide
	 */
	public AgendaIndividuel(String nom) {
		super(nom);
		this.rendezVous = new String[Agenda.CRENEAU_MAX + 1];
			// On gaspille une case (la première qui ne sera jamais utilisée)
			// mais on évite de nombreux « creneau - 1 »
	}


	@Override
	public void enregistrer(int creneau, String rdv) {
		super.verifierCreneauValide(creneau);
		
		if (rdv == null | rdv == ""){
			throw new IllegalArgumentException("Le nom doit au moins avoir un caractère!");
		} 
		
		try{
			if (this.getRendezVous(creneau)!= null){
				throw new OccupeException("Ce créneau est déjà occupé");
			}
		}
		catch(OccupeException e){
			System.out.println("Il y a surment une erreur, voici le rendez_vous booker à ce créneau :");
			this.getRendezVous(creneau);
		}
		finally {
			this.rendezVous[creneau] = rdv;
		}
	}


	@Override
	public boolean annuler(int creneau) {
		super.verifierCreneauValide(creneau);
		boolean modifie = this.rendezVous[creneau] != null;
		this.rendezVous[creneau] = null;
		return modifie;
	}


	@Override
	public String getRendezVous(int creneau) {
		super.verifierCreneauValide(creneau);
		return this.rendezVous[creneau];
	}


}
