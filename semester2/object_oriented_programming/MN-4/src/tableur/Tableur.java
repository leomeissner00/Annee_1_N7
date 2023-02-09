package tableur;

import java.io.Serializable;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.swing.JMenuItem;

import tableur.action.Action;
import tableur.composant.Cellule;
import tableur.composant.Historique;
import tableur.composant.Position;
import tableur.composant.cellule.CelluleFormule;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class Tableur implements Serializable{
    
    public final int WIDTH = 10;
    public final int HEIGHT = 30;

    public TableurVisuel visuel;
    private Historique historique;

    private Position cursor;

    public Map<String, Cellule> cells;

    JMenuItem itemNouveau = new JMenuItem("Nouveau");
    JMenuItem itemOuvrir = new JMenuItem("Ouvrir");
    JMenuItem itemEnregistrer = new JMenuItem("Enregistrer");
    JMenuItem itemEnregistrerSous = new JMenuItem("Enregistrer sous...");

    JMenuItem itemAnnuler = new JMenuItem("Annuler");
    JMenuItem itemRetablir = new JMenuItem("Retablir");
    JMenuItem itemCopier = new JMenuItem("Copier");
    JMenuItem itemCouper = new JMenuItem("Couper");
    JMenuItem itemColler = new JMenuItem("Coller");
    JMenuItem itemRAZ = new JMenuItem("RAZ");

    JMenuItem itemApparence = new JMenuItem("Apparence");
    JMenuItem itemFormat = new JMenuItem("Format");
    JMenuItem itemDimension = new JMenuItem("Dimensions");

    JMenuItem itemNouveauGraph = new JMenuItem("Nouveau graphique");

    

    public Tableur() { 
        cells = new HashMap<String, Cellule>();
        this.cursor = new Position(0, 0);
        this.historique = new Historique(this);
        
        this.visuel = new TableurVisuel("Tableur", this);

        new TableurControleur(this);
    }


    public Position getPosCursor() {
        return this.cursor.clone();
    }

    private void verifierIndice(Position pos) {
        if ( pos.x < 1 || pos.y < 1) {
            throw new IndexOutOfBoundsException(pos.x + ":" + pos.y);
        }
    }

    public Historique getHistorique() {
        return this.historique;
    }

    public void addHistorique(Action action) {
        this.historique.ajouterAction(action);
    }

    public void delCellule(Position pos) {
        verifierIndice(pos);
        cells.remove(pos.toString());
        this.update();
    }

    public void setCellule(Position pos, Formule formule) {
        verifierIndice(pos);
        cells.put(pos.toString(), new CelluleFormule(pos, formule, this));
        this.update();
    }

    public void setCellule(Position pos, String text) {
        verifierIndice(pos);
        cells.put(pos.toString(), new Cellule(pos, text));
        this.update();
    }

    public double getValeur(Position pos) throws NoMeasurableException {
        verifierIndice(pos);
        Set<Cellule> parcouru = new HashSet<Cellule>();
        parcouru.add(this.getCellule(pos));
        return this.getCellule(pos).getValeur(parcouru);
    }

    public double getValeur(Position pos, Set<Cellule> parcouru) throws NoMeasurableException {
        verifierIndice(pos);
        
        Cellule cell = this.getCellule(pos);
        if (parcouru.contains(this.getCellule(pos))) {
            throw new NoMeasurableException("[" + pos.x + ":" + pos.y + "]" + " - Invalid loop");
        }
        parcouru.add(cell);
        return this.getCellule(pos).getValeur(parcouru);
    }


    public Cellule getCellule(Position pos) {
        verifierIndice(pos);
        Cellule cell = this.cells.get(pos.toString());
    	if (cell != null) {
    		return cell;
    	} else {
    		return new Cellule(pos);
        }
    }

    private void update() {
        this.visuel.update();
    }
    
    public void  moveCursor(int dx, int dy) {
        this.cursor.x += dx;
        this.cursor.y += dy;
        this.visuel.update();
    }

    public void reset() {
        this.cells.clear();
        this.update();
   }

    
}