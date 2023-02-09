package tableur.math;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.exception.NoMeasurableException;
import java.io.Serializable;

public interface Formule extends Serializable {


    public abstract double evaluer(Tableur tab, Set<Cellule> parcouru) throws NoMeasurableException ;

    public abstract String toString();

}
