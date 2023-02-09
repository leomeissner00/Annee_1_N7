with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;
with LCA_projet;



procedure test_lca_projet is

        package LCA_String_Integer is
                new LCA_projet (T_Cle => Unbounded_String , T_Donnee => Integer);
        use LCA_String_Integer;


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
                pragma Assert (2 = Taille(Sda));
                pragma Assert (not Est_Vide(Sda));
                
                Supprimer (Sda, To_Unbounded_String("deux"));
                pragma Assert ( not Cle_Presente(Sda, To_Unbounded_String("deux")));
                pragma Assert (1 = Taille(Sda));
                pragma Assert (not Est_Vide(Sda));
                           
                
        end Initialiser_Avec_2_element;

        Sda : T_LCA;
begin
        Initialiser_Avec_2_element(Sda);
        Vider(Sda);
        pragma Assert(Est_Vide(Sda));
end test_lca_projet;
