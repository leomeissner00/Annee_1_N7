package tableur.math.formule;

import java.util.Set;

import tableur.Tableur;
import tableur.composant.Cellule;
import tableur.math.Formule;

public class FormuleConstante implements Formule {
    private double valeur;
    
    public FormuleConstante(double constante) {
        super();
        this.valeur = constante;
    }

    @Override
    public double evaluer(Tableur tableur, Set<Cellule> parcouru) {
        return this.valeur;
    }

    @Override
    public String toString() {
        return String.valueOf(this.valeur);
    }
}
