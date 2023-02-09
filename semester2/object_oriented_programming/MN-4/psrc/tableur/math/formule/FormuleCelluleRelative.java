package tableur.math.formule;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.composant.Position;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class FormuleCelluleRelative implements Formule{
    
    private Position relative;
    private Position myPos;



    public FormuleCelluleRelative(int posX, int posY, Position myPos) {
        super();
        this.relative = new Position(posX, posY);
        this.myPos = myPos;
    }

    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) throws NoMeasurableException {
        try {
            return tableur.getValeur(Position.add(myPos, relative), parcouru);
        } catch (IndexOutOfBoundsException e) {
            throw new NoMeasurableException("[" + e.getMessage() + "]" + " - Invalid position");
        }
    }


    public String toString() {
        return "[&" + this.relative.toString() + "]";
    }
    
}
