package allumettes;

import java.util.Random;

public class Generateur {
	static Random generator = new Random();

	static int nbAleatoire(Jeu jeu) {
		int val = (generator.nextInt(Jeu.PRISE_MAX) + 1);
		if (val > jeu.getNombreAllumettes()) {
			return jeu.getNombreAllumettes();
		} else {
			return val;
		}

	}
}
