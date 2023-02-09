package tableur.math;

import tableur.composant.Position;
import tableur.exception.NoFormuleException;

public interface Traitement {
	
	public void traiter(Position pos1, Position pos2) throws NoFormuleException;
	
}
