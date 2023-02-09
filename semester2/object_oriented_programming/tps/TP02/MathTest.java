import static org.junit.Assert.*;
import org.junit.Test;
import static java.lang.Math.sqrt;

public class MathTest {

	@Test
	public void testSqrt() {
		assertEquals(2.0, sqrt(4.0), 0.0000001);
	}


}
