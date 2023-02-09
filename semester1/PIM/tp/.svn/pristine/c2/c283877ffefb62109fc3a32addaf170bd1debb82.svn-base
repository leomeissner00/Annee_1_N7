
--Pour chaque fonction, on utilise celle déjà codé dans le fichier LCA en les appliquant à la structure d'une table de hachage

package body TH is

        procedure Initialiser(Sda: out T_TH) is
        begin
                for i in  1..Borne_max loop
                        Initialiser(Sda(i));	-- Initialisation d'une Sda vide avec chaque cellule qui pointe sur la masse
                end loop;

        end Initialiser;


        function Est_Vide (Sda : T_TH) return Boolean is
                Test : Boolean;
        begin
                Test := True;
                for i in 1..Borne_max loop
                        if not Est_Vide(Sda(i)) then	 -- Test si la LCA est vide
                                Test := False;
                        end if;
                end loop;
                return Test;
        end Est_Vide;


        function Taille (Sda : in T_TH) return Integer is
                Taille_Sda : Integer;
        begin
                Taille_Sda := 0;
                for i in 1..Borne_max loop
                        Taille_Sda := Taille_Sda + Taille(Sda(i));
                end loop;
                return Taille_Sda;
        end Taille;


        procedure Enregistrer (Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
                val_hachage : Integer;
        begin
                val_hachage := Fonction_de_hachage(Cle);
                if val_hachage > Borne_max then
                        val_hachage := (Fonction_de_hachage(Cle) mod Borne_max)+1;
                end if;
                Enregistrer(Sda(val_hachage), Cle, Donnee);


        end Enregistrer;


        function Cle_Presente (Sda : in T_TH ; Cle : in T_Cle) return Boolean is
                val_hachage : Integer;
        begin
                val_hachage := Fonction_de_hachage(Cle);
                if val_hachage > Borne_max then
                        val_hachage := (Fonction_de_hachage(Cle) mod Borne_max)+1;
                end if;
                return Cle_Presente(Sda(val_hachage), Cle);
        end Cle_Presente;


        function La_Donnee (Sda : in T_TH ; Cle : in T_Cle) return T_Donnee is
                val_hachage : Integer;
        begin
                val_hachage := Fonction_de_hachage(Cle);
                if val_hachage > Borne_max then
                        val_hachage := (Fonction_de_hachage(Cle) mod Borne_max)+1;
                end if;
                return La_Donnee( Sda(val_hachage), Cle);

        end La_Donnee;


        procedure Supprimer (Sda : in out T_TH ; Cle : in T_Cle) is
                val_hachage : Integer;
        begin
                val_hachage := Fonction_de_hachage(Cle);
                if val_hachage > Borne_max then
                        val_hachage := (Fonction_de_hachage(Cle) mod Borne_max)+1;
                end if;
                Supprimer( Sda(val_hachage), Cle);
        end Supprimer;


        procedure Vider (Sda : in out T_TH) is
        begin
                for i in  1..Borne_max loop
                        Vider (Sda(i));
                end loop;
        end Vider;


        procedure Pour_Chaque (Sda : in T_TH) is
                procedure Pour_Chaque_LCA is new LCA_Pour_TH.Pour_Chaque(Traiter => Traiter);
        begin
                for i in 1..Borne_max loop
                        Pour_Chaque_LCA (Sda(i));

                end loop;
        end Pour_Chaque;


end TH;
