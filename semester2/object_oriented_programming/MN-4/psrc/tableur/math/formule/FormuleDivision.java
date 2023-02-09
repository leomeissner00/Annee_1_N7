package tableur.math.formule;

import java.util.HashSet;
import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;

public class FormuleDivision implements Formule{

    Formule formule1;
    Formule formule2;

    public FormuleDivision(Formule formule1, Formule formule2) {
        super();
        this.formule1 = formule1;
        this.formule2 = formule2;
    }

    public FormuleDivision(double c1, double c2) {
        super();
        this.formule1 = new FormuleConstante(c1);
        this.formule2 = new FormuleConstante(c2);
    }

    public FormuleDivision(Formule f1, double c2) {
        super();
        this.formule1 = f1;
        this.formule2 = new FormuleConstante(c2);
    }

    public FormuleDivision(double c1, Formule f2) {
        super();
        this.formule1 = new FormuleConstante(c1);
        this.formule2 = f2;
    }
    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) throws NoMeasurableException {
        return formule1.evaluer(tableur, new HashSet<Cellule>(parcouru))/formule2.evaluer(tableur, parcouru);
    }
    

    public String toString() {
        return this.formule1.toString() + "/" + this.formule2.toString();
    }
}
