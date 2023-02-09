package tableur.math.formule;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class FormuleParenthese extends Formule {

    private Formule formule1;

    public FormuleParenthese(Formule f) {
        super();
        this.formule1 = f;
    }

    public FormuleParenthese(double c) {
        super();
        this.formule1 = new FormuleConstante(c);
    }

    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) throws NoMeasurableException {
        return this.formule1.evaluer(tableur, parcouru);
    }
    

    public String toString() {
        return "(" + this.formule1.toString() + ")";
    }
}
