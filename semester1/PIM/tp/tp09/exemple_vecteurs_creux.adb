with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- Exemple d'utilisation des vecteurs creux.
procedure Exemple_Vecteurs_Creux is

        V : T_Vecteur_Creux;
        b : Float;
        Epsilon: constant Float := 1.0e-5;
        test : Unbounded_String;
        test_2 : Unbounded_String;
        a : String := "53";
begin
        test := To_Unbounded_String("1");
        test_2 := To_Unbounded_String("2");

        Append(Source   => test,
               New_Item => test_2);
        a := To_String(Test);
        Put(a(1));




        Put_Line ("Début du scénario");
        -- initialisation d'un vecteur
        Initialiser(V) ;
        pragma Assert(Est_Nul(V));
        Afficher(V) ;
        New_Line;
        b := Composante_Iteratif(V,0);
        b := Composante_Recursif(V,0);
        Detruire(V);

        Put_Line ("Fin du scénario");
end Exemple_Vecteurs_Creux;
