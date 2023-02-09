package test.TestMath.TestFormule;

import static org.junit.Assert.assertEquals;

import org.junit.*;

import tableur.exception.NoMeasurableException;
import tableur.math.Formule;
import tableur.math.formule.FormuleDivision;

public class TestDivision extends TestSetupFormule{

    @Test
    public void testConstante() throws NoMeasurableException {
        Formule division = new FormuleDivision(const5, const2);
        assertEquals(2.5, division.evaluer(null), DELTA);
    }

}
