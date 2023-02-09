/** Programme d'illustration de la figure 1 du TP01.
  * @author Léo Meissner
  * @version 1.4
  */
public class Exercice5 {

        public static void main(String[] args) {
                // Creation des trois points
                Point p1 = new Point(3.0, 2.0);
                Point p2 = new Point(6.0, 9.0);
                Point p3 = new Point(11.0, 4.0);

                // Creation des 3 segments composants le triangle
                Segment s1 = new Segment(p1, p2);
                Segment s2 = new Segment(p2, p3);
                Segment s3 = new Segment(p3, p1);

                Point Barycentre = new Point(7.0, 5.0);
         }
}
