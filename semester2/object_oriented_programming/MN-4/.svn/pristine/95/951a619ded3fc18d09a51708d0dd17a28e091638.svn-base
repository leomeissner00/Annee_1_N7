package test.TestMath.TestFormule;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.formule.FormuleAddition;

public class TestAddition extends TestSetupFormule{

    @Test
    public void testAddition() throws NoMeasurableException {
        Formule addition = new FormuleAddition(const5, const2);
        assertEquals(7, addition.evaluer(null), DELTA);
    }

}
