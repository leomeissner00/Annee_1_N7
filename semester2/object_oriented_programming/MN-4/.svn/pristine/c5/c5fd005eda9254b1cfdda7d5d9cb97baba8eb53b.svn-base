package tableur.math.traitement;

import tableur.Tableur;
import tableur.composant.*;
import tableur.composant.cellule.CelluleFormule;
import tableur.exception.NoFormuleException;
import tableur.math.*;
import tableur.math.formule.*;

public class TraitementPuissance implements Traitement{

	private Tableur tab;
	
	private double exposant;

	public TraitementPuissance(Tableur tableur, double nb) {
		this.tab = tableur;
		this.exposant = nb;
	}

	public void traiter(Position pos1, Position pos2) throws NoFormuleException{
		Position actif = new Position(pos1.x, pos1.y);
		int x_arrivee = pos2.x;
		int y_arrivee = pos2.y;
		for (int i = pos1.x; i <= x_arrivee; i++) {
			for (int j = pos1.y; j <= y_arrivee; j++) {
				actif.x = i;
				actif.x = j;
				Cellule cellactif = this.tab.getCellule(actif);
				if (cellactif.getClass() != CelluleFormule.class) {
					throw new NoFormuleException();
				}
				Formule form1 = ((CelluleFormule) cellactif).getFormule();
				((CelluleFormule) cellactif).setFormule(new FormulePuissance(form1, this.exposant));		
			}
		}
	}

}
