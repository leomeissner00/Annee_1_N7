package tableur.composant;

import java.io.Serializable;

public class Position implements Serializable {
    public int x;
    public int y;

    public Position(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public int getX() {
        return this.x;
    }

    public int getY() {
        return this.y;
    }

    public boolean equals(Position pos) {
        return (this.x == pos.x && this.y == pos.y);
    }
    
    public Position clone() {
        return new Position(this.x, this.y);
    }
    public String toString() {
        return this.x + ":" +this.y;
    }

    public static Position add(Position pos1, Position pos2) {
        return new Position(pos1.x+pos2.x, pos1.y+pos2.y);
    }
}
