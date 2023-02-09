package tableur.math;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.composant.Position;
import tableur.exception.FormatFormuleException;
import tableur.exception.NoMeasurableException;
import java.io.Serializable;

public abstract class Formule implements Serializable {

    static Formule toFormule(String stringFormule, Position pos) throws FormatFormuleException {
        return Lecteur.convertir(stringFormule, pos);
    }

    public abstract double evaluer(Tableur tab, Set<Cellule> parcouru) throws NoMeasurableException ;

    public abstract String toString();

}
