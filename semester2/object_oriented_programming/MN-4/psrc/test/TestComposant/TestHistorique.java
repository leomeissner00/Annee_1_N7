package test.TestComposant;

import org.junit.*;

import tableur.Tableur;
import tableur.action.elementaire.ActionDefinirCellule;
import tableur.action.Action;
import tableur.composant.*;
import tableur.exception.NoFormuleException;
import tableur.math.*;
import tableur.math.formule.*;

public class TestHistorique {
    Action a1;
    Tableur tab;
    Position pos1;
    Formule f1;

    @Before
    public void setup() {
    	tab = new Tableur();
    	pos1 = new Position(1,1);
    	f1 = new FormuleVide();
    	a1 = new ActionDefinirCellule(pos1,f1);
    }

    @Test
    public void testAjoutAction() throws NoFormuleException {
        Historique hist = tab.getHistorique();
    	assert(hist.estVideHistorique());
    	assert(hist.estVideReverseHistorique());
    	a1.appliquer(this.tab);
    	assert(!hist.estVideHistorique());
    	assert(hist.estVideReverseHistorique());
    }

    @Test
    public void testHistoriqueAnnuler() throws NoFormuleException {
        Historique hist = tab.getHistorique();

        a1.appliquer(tab);
    	hist.annuler();
    	assert(hist.estVideHistorique());
    	assert(!hist.estVideReverseHistorique());
    }

    @Test
    public void testHistoriqueRefaire() throws NoFormuleException {
        Historique hist = tab.getHistorique();

        a1.appliquer(tab);
        hist.annuler();
    	hist.refaire();
    	assert(!hist.estVideHistorique());
    	assert(hist.estVideReverseHistorique());
    }

    @Test
    public void testHistoriqueVider() throws NoFormuleException {
        Historique hist = tab.getHistorique();

        a1.appliquer(tab);
        hist.annuler();
        a1.appliquer(tab);
        hist.refaire();
    	hist.vider();
    	assert(hist.estVideHistorique());
    	assert(hist.estVideReverseHistorique());
    }
}