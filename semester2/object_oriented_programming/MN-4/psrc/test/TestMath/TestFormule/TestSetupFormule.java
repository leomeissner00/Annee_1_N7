package test.TestMath.TestFormule;

import org.junit.*;

import tableur.math.Formule;
import tableur.math.formule.FormuleConstante;
import test.TestMath.TestValue;

public class TestSetupFormule extends TestValue {
    Formule const5;
    Formule const2;

    @Before
    public void setup() {
        this.const5 = new FormuleConstante(5);
        this.const2 = new FormuleConstante(2);
    }
}
