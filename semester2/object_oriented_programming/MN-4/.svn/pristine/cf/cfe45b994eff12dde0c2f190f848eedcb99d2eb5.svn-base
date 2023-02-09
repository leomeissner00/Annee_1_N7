package test.TestMath;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.FormatFormuleException;
import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.Lecteur;

public class TestLecteur extends TestValue{
    Formule f1;
    Formule f2;
    Formule f3;
    Formule f4;
    Formule f5;
    Formule f6;
    Formule f7;

    @Before
    public void setup() throws FormatFormuleException {
        f1 = Lecteur.convertir(" 5 + 2  - 1    ");
        f2 = Lecteur.convertir("5*2+3*4-1");
        f3 = Lecteur.convertir("3*(4+2*(1+1))-(2^2+1)");
        f4 = Lecteur.convertir("3*(4+2*(1+1))");
        f5 = Lecteur.convertir("(2 ^2-1)");
        f6 = Lecteur.convertir("(2+2)*(4+4 )");
        f7 = Lecteur.convertir("1.5");
    }

    @Test
    public void testValeur() throws NoMeasurableException {
        assertEquals(6, f1.evaluer(null), DELTA);
        assertEquals(21, f2.evaluer(null), DELTA);
        assertEquals(19, f3.evaluer(null), DELTA);
        assertEquals(24, f4.evaluer(null), DELTA);
        assertEquals(3, f5.evaluer(null), DELTA);
        assertEquals(32, f6.evaluer(null), DELTA);
    }
}
