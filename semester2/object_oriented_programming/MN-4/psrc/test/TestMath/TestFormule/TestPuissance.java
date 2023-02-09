package test.TestMath.TestFormule;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.formule.FormulePuissance;

public class TestPuissance extends TestSetupFormule{

    @Test
    public void testPuissance() throws NoMeasurableException {
        Formule puissance1 = new FormulePuissance(const5, const2);
        Formule puissance2 = new FormulePuissance(const2, const5);
        assertEquals(25, puissance1.evaluer(null), DELTA);
        assertEquals(32, puissance2.evaluer(null), DELTA);
    }

}
