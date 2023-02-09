package tableur.action;

import tableur.Tableur;
import tableur.exception.NoFormuleException;

public interface Action {
    void appliquer(Tableur tab) throws NoFormuleException;
    void annuler(Tableur tab);
}
