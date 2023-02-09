package tableur.graph;

import javax.swing.JFrame;
import javax.swing.*;
import javax.swing.plaf.DimensionUIResource;

import tableur.Tableur; 



public class FenetreGraphique extends JFrame {
    
    private enum GraphiqueType {
        Courbe,
        Histogramme,
    }

    public FenetreGraphique(Tableur tab) {
        super();
        setupJFrame();
        setupGraphique();
        this.pack();
    }

    private void setupJFrame() {
        this.setLocation(100, 100);
        
        DimensionUIResource dim = new DimensionUIResource(100, 100);

        this.setMinimumSize(dim);
        this.setVisible(true);
        this.setSize(1920/2, 1080/2);
    }

    private void setupGraphique() {
        GraphiqueType[] options = GraphiqueType.values();
        int numberChoice = JOptionPane.showOptionDialog(this, "Choisissez le type de graphe :", "Graphique", JOptionPane.DEFAULT_OPTION , JOptionPane.QUESTION_MESSAGE, null, options, options[0]);
        if (numberChoice == JOptionPane.CLOSED_OPTION) {
            this.dispose();
        } else {
            switch (GraphiqueType.values()[numberChoice]) {
                case Courbe :
                    courbe();
                    break;
                default:
                    histogramme();
                    break;
            }
        }
        
    }

    private void courbe() {
        
        System.out.println("Courbe!");
    }

    private void histogramme() {
        //TODO
        System.out.println("Histogramme!");
    }




}