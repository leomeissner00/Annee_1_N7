package tableur.composant.cellule;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.composant.Position;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;


public class CelluleFormule extends Cellule {
    
    private Formule formule;
    private Tableur tab;
    private boolean isCliked;


    public CelluleFormule(Position pos, Formule form, Tableur tab) {
        super(pos);
        this.tab = tab;
        this.formule = form;
        this.isCliked = false;
    }
    

    public double getValeur(Set<Cellule> parcouru) throws NoMeasurableException {
        return this.formule.evaluer(this.tab, parcouru);
    }

    @Override
    public CelluleFormule clone() {
        return new CelluleFormule(this.pos, this.formule, this.tab);
    }


    public Formule getFormule() {
        return this.formule;
    }

    public void setFormule(Formule formule) {
        this.formule = formule;
    }

    @Override
    public String toString() {
        if (isCliked) {
            return "="+this.formule.toString();
        } else {
            try {
                return Double.toString(tab.getValeur(this.pos));
            } catch (NoMeasurableException e) {
                return "#! " + e.getMessage();
            }
        }
        
    }

    public void setIsCliked(boolean bool) {
        this.isCliked = bool;
    }

}
