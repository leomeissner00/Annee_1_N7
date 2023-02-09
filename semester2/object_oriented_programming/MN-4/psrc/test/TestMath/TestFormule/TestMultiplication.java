package test.TestMath.TestFormule;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.formule.FormuleMultiplication;

public class TestMultiplication extends TestSetupFormule{

    @Test
    public void testMultiplication() throws NoMeasurableException {
        Formule multiplication = new FormuleMultiplication(const5, const2);
        assertEquals(10, multiplication.evaluer(null), DELTA);
    }

}
