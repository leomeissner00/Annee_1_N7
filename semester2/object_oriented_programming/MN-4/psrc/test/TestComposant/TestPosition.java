package test.TestComposant;

import java.util.HashMap;
import java.util.Map;

import org.junit.*;

import tableur.composant.*;

public class TestPosition {
    Position p1;
    Position p2;
    Position p3;

    @Before
    public void setup() {
    	p1 = new Position(1, 1);
        p2 = new Position(2,1);
        p3 = new Position(1, 1);
    }

    @Test
    public void testAjoutAction() {
        assert(p1.equals(p3));
        assert(!p1.equals(p2));
    }

    @Test
    public void testHashMap() {
        Map<String, Integer> map = new HashMap<String, Integer>();
        map.put(p1.toString(), 1);
        assert( map.get(p1.toString()) == 1);
        assert( map.get(p3.toString())!= null);
        assert( map.get(p3.toString()) == 1);
    }
}