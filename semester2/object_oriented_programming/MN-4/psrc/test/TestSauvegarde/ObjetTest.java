package test.TestSauvegarde;

import java.io.Serializable;

public class ObjetTest implements Serializable{
	
	private static final long serialVersionUID = 1L;
	public String nom;
	public int age;
	public String hobby;
	
	public ObjetTest(String n, int a, String h) {
		this.age = a;
		this.nom = n;
		this.hobby = h;
	}
	
	public void Afficher() {
		System.out.println("il/elle s'appelle " + this.nom);
		System.out.println("il/elle a " + this.age + " an(s)");
		System.out.println("son hobby est " + this.hobby);
	}

}
