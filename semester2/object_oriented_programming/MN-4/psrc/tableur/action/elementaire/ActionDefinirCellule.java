package tableur.action.elementaire;

import tableur.Tableur;
import tableur.action.Action;
import tableur.composant.Position;
import tableur.exception.NoFormuleException;
import tableur.math.Formule;
import tableur.math.formule.FormuleVide;

public class ActionDefinirCellule implements Action {
    
    private Position pos;

    private Formule nouvelleFormule;
    private Formule ancienneFormule;

    public ActionDefinirCellule(Position pos, Formule formule) {
        this.nouvelleFormule = formule;
        this.ancienneFormule = new FormuleVide();
        this.pos = pos;
    }

    @Override
    public void appliquer(Tableur tab) throws NoFormuleException {
        /*this.ancienneFormule = tab.getFormule(this.pos);*/
        if ( this.nouvelleFormule.getClass() != FormuleVide.class) {
            tab.setCellule(this.pos, this.nouvelleFormule);
        } else {
            tab.delCellule(this.pos);
        }
        tab.addHistorique(this);
    }

    @Override
    public void annuler(Tableur tab) {
        Formule formuleTransi = this.ancienneFormule;
        this.ancienneFormule = nouvelleFormule;
        this.nouvelleFormule = formuleTransi;
        if ( this.nouvelleFormule.getClass() != FormuleVide.class) {
            tab.setCellule(this.pos, this.nouvelleFormule);
        } else {
            tab.delCellule(this.pos);
        }
    }
}
