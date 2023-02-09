import java.util.List;

/** Quelques outils (méthodes) sur les listes.  */
public class Outils {

	/** Retourne vrai ssi tous les éléments de la collection respectent le critère. */
	public static <E> boolean tous(
			List<? extends E> elements,
			Critere<E> critere)
	{
		for (E x : elements) {
			if (! critere.satisfaitSur(x)) {
				return false;
			}
		}
		return true;
	}


	/** Ajouter dans resultat tous les éléments de la source
	 * qui satisfont le critère aGarder.
	 */
	public static <E> void filtrer(
			List<? extends E> source,
			Critere<E> aGarder,
			List<? super E> resultat)
	{
		for (E x : source) {
			if ( aGarder.satisfaitSur(x)) {
				resultat.add(x);
			}
		}
	}

}
