package test.TestSauvegarde;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class Sauvegarde {
	
	private String nomFichier;
	
	public Sauvegarde(String nom) {
		this.nomFichier = nom;
	}
	
	public void Enregistrer(Object tab, String path) {
		try {
			File fichier = new File(path, this.nomFichier);
			boolean creation = fichier.createNewFile();
			FileOutputStream fluxFichierSortie = new FileOutputStream(fichier);
			ObjectOutputStream fluxObjetSortie = new ObjectOutputStream(fluxFichierSortie);
			fluxObjetSortie.writeObject(tab);
			fluxObjetSortie.close();
			fluxFichierSortie.close();
			if (creation) {
				System.out.println("Fichier créé");
			} else {
				System.out.println("Fichier existant modifié");
			}
		} catch (FileNotFoundException e) {
			System.out.println("Fichier introuvable");
		} catch (IOException e) {
			System.out.println("Erreur initialisation flux");
		}
	}
	

	public Object Ouvrir() {
		Object tab = null;
		try {
			String dir = System.getProperty("user.dir");
			System.out.println(dir);
			File fichier = new File(dir,this.nomFichier);
			FileInputStream fluxFichierEntrant = new FileInputStream(fichier);
			ObjectInputStream fluxObjetEntrant = new ObjectInputStream(fluxFichierEntrant);
			tab = fluxObjetEntrant.readObject();
			fluxObjetEntrant.close();
			fluxFichierEntrant.close();
			return tab;
		} catch (FileNotFoundException e) {
			System.out.println("Fichier Introuvable");
		} catch (IOException e) {
			System.out.println("Erreur initialisation flux");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return tab;
	}

}

