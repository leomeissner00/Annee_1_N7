package tableur.math.traitement;

import tableur.Tableur;
import tableur.composant.*;
import tableur.composant.cellule.CelluleFormule;
import tableur.math.*;
import tableur.math.formule.*;
import tableur.exception.*;

public class TraitementProduit implements Traitement{

	private Tableur tab;
	
	private double facteur;

	public TraitementProduit(Tableur tableur, double nb) {
		this.tab = tableur;
		this.facteur = nb;
	}

	public void traiter(Position pos1, Position pos2) throws NoFormuleException {
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
				((CelluleFormule) cellactif).setFormule(new FormuleMultiplication(form1, this.facteur));			
				
			}
		}
	}

}
