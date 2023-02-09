package allumettes;

import org.junit.Before;
import org.junit.Test;

/**
 * Classe de test pour la strategie Rapide.
 * @author lmeissne
 *
 */
public class TestRapide {

	protected Joueur Joueur1;
	protected Joueur Joueur2;
	protected Arbitre Arbitre1;
	protected Jeu jeu;
	
	
	@Before public void setUp() {
		Joueur1 = new Joueur("Ordinateur2", "rapide");
		Joueur2 = new Joueur("Ordinateur1", "rapide");
		Arbitre1 = new Arbitre(Joueur1, Joueur2);
		jeu = new JeuAllumettes(13);
	}
	
	@Test public void tester_le_jeu() {
		Arbitre1.arbitrer(jeu);
	}
}
