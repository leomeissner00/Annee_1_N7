package tableur;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.Serializable;

import javax.swing.JColorChooser;
import javax.swing.JFileChooser;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.KeyStroke;
import javax.swing.filechooser.FileSystemView;

import tableur.graph.FenetreGraphique;

import java.awt.event.KeyEvent;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;


public class TableurControleur implements ActionListener, Serializable {

    public Tableur tableur;
	private String path = "";
	private String nom = "";
    
    public TableurControleur(Tableur tableur) {
        this.tableur = tableur;
		
		//Action listener
		tableur.itemNouveau.addActionListener(this);
		tableur.itemOuvrir.addActionListener(this);
		tableur.itemEnregistrer.addActionListener(this);
		tableur.itemEnregistrerSous.addActionListener(this);

		tableur.itemAnnuler.addActionListener(this);
		tableur.itemRetablir.addActionListener(this);
		tableur.itemCopier.addActionListener(this);
		tableur.itemCouper.addActionListener(this);
		tableur.itemColler.addActionListener(this);
		tableur.itemRAZ.addActionListener(this);

		tableur.itemApparence.addActionListener(this);
		tableur.itemFormat.addActionListener(this);
		tableur.itemDimension.addActionListener(this);

		tableur.itemNouveauGraph.addActionListener(this);

		//Raccourci clavier
		tableur.itemNouveau.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_N, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemOuvrir.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_O, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemEnregistrer.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemEnregistrerSous.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S, java.awt.Event.CTRL_MASK | java.awt.Event.SHIFT_MASK));

        tableur.itemAnnuler.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Z, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemRetablir.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Z, java.awt.Event.CTRL_MASK | java.awt.Event.SHIFT_MASK));
        tableur.itemCopier.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemCouper.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_X, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemColler.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_V, KeyEvent.CTRL_DOWN_MASK));
        tableur.itemDimension.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F3, 0));
        tableur.itemApparence.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F1, 0));
        tableur.itemFormat.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F2, 0));


    }

    @Override
    public void actionPerformed(ActionEvent e) {
		System.out.print("-1");
        if (e.getSource().getClass() == JMenuItem.class) {
        	
			if (e.getSource() == tableur.itemNouveau ) {
            	this.nouveau();
            }
			if (e.getSource() == tableur.itemDimension ) {
				this.changeDim();
            }
			if (e.getSource() == tableur.itemApparence ) {
				this.changeSelectColor();
            }
            if (e.getSource() == tableur.itemOuvrir ) {
            	this.ouvrir();	
            }
            if (e.getSource() == tableur.itemEnregistrerSous ) {
				this.enregistrerSous();
            }
            if (e.getSource() == tableur.itemEnregistrer ) {
				this.enregistrer();
            }

			if (e.getSource() == tableur.itemRAZ ) {
            	this.tableur.reset();
            }
			if (e.getSource() == tableur.itemNouveauGraph) {
				 new FenetreGraphique(tableur);
			}
        }
    }


	
    
    public void changeDim(){
		try {
		     int largeur = Integer.parseInt(JOptionPane.showInputDialog(null,"Largeur: "));
		     int longueur = Integer.parseInt(JOptionPane.showInputDialog(null,"Longueur: "));
			 tableur.visuel.setSize(largeur, longueur);
		} catch(NumberFormatException e){
		}
		
	}
    
    public void changeSelectColor(){
    	Color newColor = JColorChooser.showDialog(null, "Choose a color", tableur.visuel.getColorSelect());
		if (newColor != null) {
			tableur.visuel.setColorSelect(newColor);
		}
	}

	public void nouveau(){
		new TableurSwing();
	}

	public void ouvrir(){
		JFileChooser j = new JFileChooser(FileSystemView.getFileSystemView());
		j.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int res = j.showSaveDialog(null);
		if(res == JFileChooser.APPROVE_OPTION) {
			File fs = j.getSelectedFile();
			String path = fs.getAbsolutePath();
			try {
				System.out.println(path);
				File fichier = new File(path);
				FileInputStream fluxFichierEntrant = new FileInputStream(fichier);
				ObjectInputStream fluxObjetEntrant = new ObjectInputStream(fluxFichierEntrant);
				this.tableur.cells = ((Tableur) fluxObjetEntrant.readObject()).cells;
				this.tableur.visuel.update();
				this.tableur.visuel.setTitle(path);
				fluxObjetEntrant.close();
				fluxFichierEntrant.close();
			} catch (FileNotFoundException e) {
				System.out.println("Fichier Introuvable");
			} catch (IOException e) {
				System.out.println("Erreur initialisation flux");
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}

		} else {System.out.print("Annulage d'ouverture de fichier tableur.");}
	}

	public void enregistrerSous(){
		JFileChooser j = new JFileChooser(FileSystemView.getFileSystemView());
		j.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		int res = j.showSaveDialog(null);
		if(res == JFileChooser.APPROVE_OPTION) {
			File fs = j.getSelectedFile();
			this.path = fs.getAbsolutePath();
			String nom = JOptionPane.showInputDialog("Entrer nom du fichier :");
			if (nom != null) {
				this.nom = nom;
				this.tableur.visuel.setTitle(this.path + "\\" + nom);
				try {
					File fichier = new File(path, nom);
					boolean creation = fichier.createNewFile();
					FileOutputStream fluxFichierSortie = new FileOutputStream(fichier);
					ObjectOutputStream fluxObjetSortie = new ObjectOutputStream(fluxFichierSortie);
					fluxObjetSortie.writeObject(this.tableur);
					fluxObjetSortie.close();
					fluxFichierSortie.close();
					if (creation) {
						System.out.println("Fichier créé");
					} else {
						System.out.println("Fichier existant modifié");
					}
				} catch (FileNotFoundException e) {
					System.out.println("Fichier introuvable");
					e.printStackTrace();
				} catch (IOException e) {
					System.out.println("Erreur initialisation flux");
					e.printStackTrace();
				}
			} else {
				System.out.println("Sauvegarde annule");
			}
			

		} else {System.out.print("Annulage d'enregistrement de fichier tableur.");}
	}

	public void enregistrer(){
		if( !this.path.equals("")) {
			try {
				File fichier = new File(path, nom);
				boolean creation = fichier.createNewFile();
				FileOutputStream fluxFichierSortie = new FileOutputStream(fichier);
				ObjectOutputStream fluxObjetSortie = new ObjectOutputStream(fluxFichierSortie);
				fluxObjetSortie.writeObject(this.tableur);
				fluxObjetSortie.close();
				fluxFichierSortie.close();
				if (creation) {
					System.out.println("Fichier créé");
				} else {
					System.out.println("Fichier existant modifié");
				}
			} catch (FileNotFoundException e) {
				System.out.println("Fichier introuvable");
				e.printStackTrace();
			} catch (IOException e) {
				System.out.println("Erreur initialisation flux");
				e.printStackTrace();
			}
		} else {
			this.enregistrerSous();
		}
	}

	
}
