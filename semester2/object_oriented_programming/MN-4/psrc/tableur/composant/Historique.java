package tableur.composant;

import tableur.action.Action;
import tableur.exception.NoFormuleException;

import java.util.*;

import tableur.Tableur;
import java.io.Serializable;

public class Historique implements Iterable<Action>, Serializable{

	private Tableur tab;

	private List<Action> historique;
	private List<Action> reverseHistorique ;
	
	public Historique(Tableur tab) {
		this.tab = tab;
		historique = new ArrayList<Action>();
		reverseHistorique = new ArrayList<Action>();
	}

	public void ajouterAction(Action action) {
		this.historique.add(action);
	}

	public void annuler() { 
		int last = this.historique.size();
		if (!this.estVideHistorique()) {
			Action actionAnnuler = this.historique.remove(last-1);
			actionAnnuler.annuler(this.tab);
			this.reverseHistorique.add(actionAnnuler);
		}
	}
	
	public void refaire() throws NoFormuleException {
		int last = this.reverseHistorique.size();
		if (!this.estVideReverseHistorique()) {
			Action toDo = this.reverseHistorique.remove(last-1);
			toDo.appliquer(this.tab);
		}
	}
	
	public void vider() {
		this.historique.clear();
		this.reverseHistorique.clear();
	}
	
	public boolean estVideHistorique() {
		return (this.historique.size() == 0);
	}
	
	public boolean estVideReverseHistorique() {
		return (this.reverseHistorique.size() == 0);
	}
	
	@Override
	public Iterator<Action> iterator() {
		return this.historique.iterator();
	}
	
	//public Action getDernierElement() {
	//	return this.historique.get(this.historique.size() - 1);
	//}

}
