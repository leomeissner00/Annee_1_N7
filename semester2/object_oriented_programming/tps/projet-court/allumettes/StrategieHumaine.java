package allumettes;

import java.util.Scanner;

public class StrategieHumaine implements Strategie {

	static Scanner sc = new Scanner(System.in);

	@Override
	public int getPrise(Jeu jeu, String nom) throws EntreeInvalideException {
		System.out.print(nom + ", combien d'allumettes ? ");
		String valString = sc.nextLine();
		if (valString.equals("triche")) {
			try {
				jeu.retirer(1);
			} catch (CoupInvalideException e) {
				System.out.println(e.getProbleme());
			}
			throw new EntreeInvalideException(jeu.getNombreAllumettes(),
					"[Une allumette en moins, plus que " + jeu.getNombreAllumettes()
					+ ". Chut !]");
		} try {
			int val = Integer.parseInt(valString);
			return val;
		} catch (NumberFormatException e) {
			throw new EntreeInvalideException(jeu.getNombreAllumettes(),
					"Vous devez donner un entier.");
		}
	}

}
