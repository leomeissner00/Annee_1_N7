with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;
with arbre_bin_projet;

procedure Test_arbre_bin is
	
	Package Arbre_string is
			new arbre_bin_projet (T_Donnee => Unbounded_String);
	use Arbre_string;

	Arbre_1, Arbre_2 : T_Abr;

begin
		
	Initialiser(Arbre_1);
	Initialiser(Arbre_2);
	pragma Assert (Est_Vide(Arbre_1));
	Enregistrer_noeud(Arbre_1, 5, To_Unbounded_String("010101"));
	Enregistrer_noeud(Arbre_2, 6, To_Unbounded_String("0101"));
	pragma Assert (Donnee(Arbre_1) = "010101");
	pragma Assert (Valeur(Arbre_1) = 5);
	Fusionner(Arbre_1 , Arbre_2);
	pragma Assert (Donnee(Arbre_1) = "010101");
	pragma Assert (Valeur(Arbre_1) = 11);
	pragma Assert (Donnee(Gauche(Arbre_1)) =  "010101");
	pragma Assert (Valeur(Gauche(Arbre_1)) =  5);
	pragma Assert (Donnee(Gauche(Arbre_2)) =  "0101");
	pragma Assert (Valeur(Gauche(Arbre_2)) =  6);
	Vider(Arbre_1);
	Vider(Arbre_2);

end Test_arbre_bin;
