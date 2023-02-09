package allumettes;

public class StrategieRapide implements Strategie {

	@Override
	public int getPrise(Jeu jeu, String nom) {
		if (jeu.getNombreAllumettes() < Jeu.PRISE_MAX) {
			return jeu.getNombreAllumettes();
		} else {
			return Jeu.PRISE_MAX;
		}
	}
}
