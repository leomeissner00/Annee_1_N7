package test;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.Tableur;
import tableur.composant.Position;
import tableur.exception.FormatFormuleException;
import tableur.exception.NoMeasurableException;
import tableur.math.Lecteur;

public class TestTableur{
    Tableur tab;



    @Before
    public void setup() throws FormatFormuleException {
        tab = new Tableur();tab.setCellule(new Position(1, 1), Lecteur.convertir("5+5"));
    }

    @Test
    public void testValeur() throws NoMeasurableException {
        assertEquals(10, tab.getValeur(new Position(1, 1)),0.01);
    }
}
