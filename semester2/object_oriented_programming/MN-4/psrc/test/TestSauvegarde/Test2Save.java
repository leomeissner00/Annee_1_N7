package test.TestSauvegarde;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class Test2Save {
		
		public static void main(String[] args) {
			ObjetTest Justin = new ObjetTest("Justin",21,"le foot");
			ObjetTest JustinRestaure;
			String name = "FichierJustin";
			try {
				// Path à modifier !!
				String dir = System.getProperty("user.dir");
				System.out.println(dir);
				File chemin = new File(dir);
				File fichier = new File(chemin,name);
				boolean creation = fichier.createNewFile();
				FileOutputStream fluxFichierSortie = new FileOutputStream(fichier);
				ObjectOutputStream fluxObjetSortie = new ObjectOutputStream(fluxFichierSortie);
				fluxObjetSortie.writeObject(Justin);
				fluxObjetSortie.close();
				fluxFichierSortie.close();
				if (creation) {
					System.out.println("Fichier créé");
				} else {
					System.out.println("Fichier existant modifié");
				}
				
				FileInputStream fluxFichierEntrant = new FileInputStream(fichier);
				ObjectInputStream fluxObjetEntrant = new ObjectInputStream(fluxFichierEntrant);
				JustinRestaure = (ObjetTest) fluxObjetEntrant.readObject();
				fluxObjetEntrant.close();
				fluxFichierEntrant.close();
				
				JustinRestaure.Afficher();
				System.out.println("relatif " + fichier.getPath());
				System.out.println("absolu " + fichier.getAbsolutePath());
				
				
			} catch (FileNotFoundException e) {
				System.out.println("Fichier introuvable");
			} catch (IOException e) {
				System.out.println("Erreur initialisation flux");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			
			
		}

}
