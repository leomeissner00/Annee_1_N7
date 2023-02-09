package tableur.math.formule;

import java.util.HashSet;
import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.composant.Position;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class FormuleSomme extends Formule {

    private Position position1;
    private Position position2;


    public FormuleSomme(Position pos1, Position pos2) {
        super();
        this.position1 = pos1;
        this.position2 = pos2;
        System.out.println(this);
    }


    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) throws NoMeasurableException {
        int startX = Math.min(position1.getX(), position2.getX());
        int endX = Math.max(position1.getX(), position2.getY());
        int startY = Math.min(position1.getY(), position2.getY());
        int endY = Math.max(position1.getY(), position2.getY());
        double s = 0;
        try {
            for (int i = startY; i <= endY; i++) {
                for (int j = startX; j <= endX; j++){
                    s += tableur.getValeur(new Position(i, j), new HashSet<Cellule>(parcouru));
                }
            }
            return s;
        } catch (IndexOutOfBoundsException e) {
            throw new NoMeasurableException("[" + e.getMessage() + "]" + " - Invalid position");
        }
        
    }

    public String toString() {
        return "SOMME(" + position1.toString() + "," + position2.toString() + ")";
    }
    
}
