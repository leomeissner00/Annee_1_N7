package tableur.action.elementaire;

import tableur.Tableur;
import tableur.action.Action;
import tableur.composant.Position;
import tableur.exception.NoFormuleException;
import tableur.math.Formule;
import tableur.math.formule.FormuleVide;

public class ActionCopier implements Action{

    private Position anciennePos;
    private Position nouvellePos;

    private Formule nouvelleFormule;
    private Formule ancienneFormule;

    public ActionCopier(Position anciennePos, Position nouvellePos, Tableur tab) throws NoFormuleException {
    	this.anciennePos = anciennePos;
    	this.nouvellePos = nouvellePos;
    	this.nouvelleFormule = tab.getFormule(anciennePos);
    	this.ancienneFormule = new FormuleVide();
    }

	@Override
	public void appliquer(Tableur tab) throws NoFormuleException {
		this.ancienneFormule = tab.getFormule(this.nouvellePos);
		if (this.nouvelleFormule.getClass() != FormuleVide.class) {
			tab.setCellule(this.nouvellePos, nouvelleFormule);
		} else {
			tab.delCellule(this.nouvellePos);
		}
		tab.addHistorique(this);
	}

	@Override
	public void annuler(Tableur tab) {
		Formule formuleTransi = this.ancienneFormule;
		this.ancienneFormule = this.nouvelleFormule;
		this.nouvelleFormule = formuleTransi;
		if (this.nouvelleFormule.getClass() != FormuleVide.class) {
			tab.setCellule(this.anciennePos, this.nouvelleFormule);
		} else {
			tab.delCellule(this.anciennePos);
		}
	}

}
