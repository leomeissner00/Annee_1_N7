package tableur.math.formule;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.composant.Position;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class FormuleCellule implements Formule{
    
    private Position positionCellule;



    public FormuleCellule(int posX, int posY) {
        super();
        this.positionCellule = new Position(posX, posY);
    }

    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) throws NoMeasurableException {
        try {
            return tableur.getValeur(this.positionCellule, parcouru);
        } catch (IndexOutOfBoundsException e) {
            throw new NoMeasurableException("[" + e.getMessage() + "]" + " - Invalid position");
        }
    }


    public String toString() {
        return "[" + this.positionCellule.toString() + "]";
    }
    
}
