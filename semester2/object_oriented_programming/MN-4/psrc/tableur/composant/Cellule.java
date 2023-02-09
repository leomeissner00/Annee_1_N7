package tableur.composant;

import java.util.Set;

import javax.swing.JTextField;
import tableur.exception.NoMeasurableException;

public class Cellule extends JTextField {

    protected Position pos;
    
    public Cellule(Position pos) {
        super();
        this.pos = pos.clone();
    }
    
    public Cellule(Position position, String text) {
        super(text);
        this.pos = new Position(position.x, position.y);
    }


    public double getValeur(Set<Cellule> parcouru) throws NoMeasurableException {
        try {
            return Double.parseDouble(this.getText());
        } catch (NumberFormatException e) {
            if (this.getText().equals("")) {
                return 0;
            } else {
                throw new NoMeasurableException("[" + this.pos + "]" + " unmeasurable");
            }
        } catch (NullPointerException e) {
            return 0;
        }
    }

    public Cellule clone() {
        return new Cellule(this.pos, this.getText());
    }

    public Position getPosition() {
        return this.pos.clone();
    }

    public String toString() {
        return this.getText();
    }

}
