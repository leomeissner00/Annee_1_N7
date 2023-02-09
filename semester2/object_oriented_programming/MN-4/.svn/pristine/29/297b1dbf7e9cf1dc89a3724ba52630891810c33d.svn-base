package tableur.action.elementaire;

import tableur.Tableur;
import tableur.action.Action;
import tableur.composant.Position;

public class ActionSelectionnerCellule implements Action {
    
    private Position pos;


    public ActionSelectionnerCellule(Position pos) {
        this.pos = pos;
    }




	@Override
	public void appliquer(Tableur tab) {
		tab.addHistorique(this);
	}




	@Override
	public void annuler(Tableur tab) {
		//do nothing
		return ;
	}
	
	public Position getPositionSelectionnee() {
		return this.pos;
	}


}
