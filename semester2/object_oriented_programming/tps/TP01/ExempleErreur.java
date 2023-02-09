/** Une erreur à la compilation !
  * Pourquoi ?
  * @author	Xavier Crégut
  * @version	1.3
  */
public class ExempleErreur {

	/** Méthode principale */
	public static void main(String[] args) {
		Point p1 = new Point(0.0, 0.0);
		p1.setX(1);
		p1.setY(2);
		p1.afficher();
		System.out.println();
	}

}
/* Le programme ne compilait pas car on utilisait le constructeur Point() qui est le constructeur par défaut lorsqu'il n'en existe pas d'autre mais comme nous avons crée un constructeur Point dans la classe Point, le constructeur par défaut à été supprimer. Cela permet d'éviter les mauvaises initialisations */

