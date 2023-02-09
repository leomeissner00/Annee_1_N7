import afficheur.Ecran;
import afficheur.AfficheurSVG;

/** Construire le schéma proposé dans le sujet de TP avec des points,
  * et des segments.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.7 $
  */
public class ExempleSchema1 {

	/** Construire le schéma et le manipuler.
	  * Le schéma est affiché.
	  * @param args les arguments de la ligne de commande
	  */
	public static void main(String[] args)
	{
		// Construire les écrans
		Ecran E1 = new Ecran("E1", 600, 400, 20);
		AfficheurSVG AfficheurSVG1 = new AfficheurSVG("Afficheur svg", "blabla", 600, 400);
		
		// Créer les trois segments
		Point p1 = new Point(3, 2);
		Point p2 = new Point(6, 9);
		Point p3 = new Point(11, 4);
		Segment s12 = new Segment(p1, p2);
		Segment s23 = new Segment(p2, p3);
		Segment s31 = new Segment(p3, p1);

		// Créer le barycentre
		double sx = p1.getX() + p2.getX() + p3.getX();
		double sy = p1.getY() + p2.getY() + p3.getY();
		Point barycentre = new Point(sx / 3, sy / 3);

		//Affichage des éléments sur l'écran E1
		p1.dessiner(E1);
		p2.dessiner(E1);
		p3.dessiner(E1);
		barycentre.dessiner(E1);
		s12.dessiner(E1);
		s23.dessiner(E1);
		s31.dessiner(E1);
		
		//Affichage des éléments sur l'AfficheurSVG
		p1.dessinerSVG(AfficheurSVG1);
		p2.dessinerSVG(AfficheurSVG1);
		p3.dessinerSVG(AfficheurSVG1);
		barycentre.dessinerSVG(AfficheurSVG1);
		s12.dessinerSVG(AfficheurSVG1);
		s23.dessinerSVG(AfficheurSVG1);
		s31.dessinerSVG(AfficheurSVG1);
		AfficheurSVG1.ecrire();
		//Translation du schéma
		p1.translater(4, -3);
		p2.translater(4, -3);
		p3.translater(4, -3);
		s12.translater(4, -3);
		s23.translater(4, -3);
		s31.translater(4, -3);
		
		// Créer le barycentre
		sx = p1.getX() + p2.getX() + p3.getX();
		sy = p1.getY() + p2.getY() + p3.getY();
		barycentre = new Point(sx / 3, sy / 3);

		
		//Affichage de l'écran
		p1.dessiner(E1);
		p2.dessiner(E1);
		p3.dessiner(E1);
		barycentre.dessiner(E1);
		s12.dessiner(E1);
		s23.dessiner(E1);
		s31.dessiner(E1);
		
		// Afficher le schéma
		System.out.println("Le schéma est composé de : ");
		s12.afficher();		System.out.println();
		s23.afficher();		System.out.println();
		s31.afficher();		System.out.println();
		barycentre.afficher();	System.out.println();
	}

}
