package test.TestSauvegarde;

import org.junit.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;



public class TestSauvegarde {
	
	//ObjetTest
	private ObjetTest Justin, JustinRestaure;
	
	//Nom du fichier
	private String name;
	
	@Before public void setUp() {
		Justin = new ObjetTest("Justin",21,"le foot");
		name = "FichierJustinTest";
	}
	
	@Test public void TesterSauvegarde() {
		Sauvegarde save = new Sauvegarde(name);
		save.Enregistrer(Justin, System.getProperty("user.dir"));
		JustinRestaure = (ObjetTest) save.Ouvrir();
		assertTrue(JustinRestaure.nom.equals(Justin.nom));
		assertEquals(JustinRestaure.age, Justin.age);
		assertTrue(JustinRestaure.hobby.equals(Justin.hobby));
		Justin.Afficher();
		
	}

}
