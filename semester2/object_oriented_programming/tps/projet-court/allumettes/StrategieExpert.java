package allumettes;

public class StrategieExpert implements Strategie {

	@Override
	public int getPrise(Jeu jeu, String nom) {
		int allumettesRestantes = jeu.getNombreAllumettes();
		if (allumettesRestantes == 1) {
			return 1;
		}
		if ((allumettesRestantes - 1) % (Jeu.PRISE_MAX + 1) == 0) {
			return Jeu.PRISE_MAX;
		} else {
			return (allumettesRestantes - 1) % (Jeu.PRISE_MAX + 1);
		}
	}

}
