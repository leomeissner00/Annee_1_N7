with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;
with LCA;



-- Programme de la question 1.2.
procedure lca_sujet is



        procedure Affiche_Sda (Cle : in Unbounded_String ; Donnee : In Integer) is
        begin
                Put("La clé est : ");
                Put(To_String(Cle));
                Put(" , La donnée est : ");
                Put(Donnee,1);
                New_Line;
        end Affiche_Sda;


        package LCA_String_Integer is
                new LCA (T_Cle => Unbounded_String , T_Donnee => Integer);
        use LCA_String_Integer;

        procedure Affichage is new Pour_Chaque(Traiter => Affiche_Sda);


        -- Initialiser une Sda avec la cle"un" et la donnee 1 puis la cle "deux" et la donnee 2 empilés dans la Sda vide.
        procedure Initialiser_Avec_2_element(Sda : out T_LCA) is
        begin
                Initialiser (Sda);
                pragma Assert (Est_Vide(Sda));
                Enregistrer (Sda,To_Unbounded_String("un"), 1);
                pragma Assert (Cle_Presente(Sda, To_Unbounded_String("un")));
                pragma Assert (1 = La_Donnee(Sda, To_Unbounded_String("un")));
                Enregistrer (Sda    => Sda, Cle    => To_Unbounded_String("deux"), Donnee => 2);
                pragma Assert (Cle_Presente(Sda, To_Unbounded_String("deux")));
                pragma Assert (2 = La_Donnee(Sda, To_Unbounded_String("deux")));
        end Initialiser_Avec_2_element;

        Sda : T_LCA;
begin
        Initialiser_Avec_2_element(Sda);
        Affichage(Sda);
        Vider(Sda);

end lca_sujet;
