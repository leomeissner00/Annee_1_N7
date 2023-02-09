package tableur.math.formule;

import java.util.HashSet;
import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class FormuleAddition  implements Formule {
    private Formule formule1;
    private Formule formule2;
    
    public FormuleAddition(Formule f1, Formule f2) {
        super();
        this.formule1 = f1;
        this.formule2 = f2;
    }

    public FormuleAddition(double c1, double c2) {
        super();
        this.formule1 = new FormuleConstante(c1);
        this.formule2 = new FormuleConstante(c2);
    }

    public FormuleAddition(Formule f1, double c2) {
        super();
        this.formule1 = f1;
        this.formule2 = new FormuleConstante(c2);
    }

    public FormuleAddition(double c1, Formule f2) {
        super();
        this.formule1 = new FormuleConstante(c1);
        this.formule2 = f2;
    }

    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) throws NoMeasurableException {
        return this.formule1.evaluer(tableur, new HashSet<Cellule>(parcouru)) + this.formule2.evaluer(tableur, parcouru);
    }


    public String toString() {
        return formule1.toString() + "+" + formule2.toString();
    }
    
}
