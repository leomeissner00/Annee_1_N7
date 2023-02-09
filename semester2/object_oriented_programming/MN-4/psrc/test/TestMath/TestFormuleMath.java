package test.TestMath;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.formule.*;

public class TestFormuleMath extends TestValue {
    Formule f1;
    Formule f2;
    Formule f3;

    @Before
    public void setup() {
        f1 = new FormuleAddition(new FormuleMultiplication( 3, 6), -1);
        f2 = new FormuleDivision(new FormuleMultiplication(f1, f1), 2);
        f3 = new FormulePuissance(f2, 3);
    }

    @Test
    public void testValeur() throws NoMeasurableException {
        assertEquals(17, f1.evaluer(null), DELTA);
        assertEquals(144.5, f2.evaluer(null), DELTA);
        assertEquals(3017196.125, f3.evaluer(null), DELTA);
    }
    
}
