package test.TestMath.TestFormule;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.formule.FormuleSoustraction;
public class TestSoustraction extends TestSetupFormule{

    @Test
    public void testConstante() throws NoMeasurableException {
        Formule soustraction = new FormuleSoustraction(const5, const2);
        assertEquals(3, soustraction.evaluer(null), DELTA);
    }

}
