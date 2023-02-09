-- with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;


package body LCA is

        procedure Free is
                new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


        procedure Initialiser(Sda: out T_LCA) is
        begin
                Sda := null;	-- Initialisation d'une Sda vide qui pointe sur la masse
        end Initialiser;


        function Est_Vide (Sda : T_LCA) return Boolean is
        begin
                return Sda = null;	 -- Test si la sda est vide
        end;


        function Taille (Sda : in T_LCA) return Integer is
        begin
                if Sda /= null then	--
                        return (Taille(Sda.all.Suivant)+1); --Codage récursif pour la rapidité
                else
                        return 0;
                end if;
        end Taille;


        procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
                Curseur : T_LCA;
        begin
                Curseur := Sda;
                if Cle_Presente(Sda, Cle) then                   -- Comme la clé est présente on chage uniquement la donnée au bon endroit
                        if Sda.all.Cle = Cle then
                                Sda.all.Donnee := Donnee;
                        else
                                Enregistrer(Sda.all.Suivant, Cle, Donnee);
                        end if;

                else
                        -- Si la clé n'est pas présente il faut creer un nouvel élément (allocation puis initialisation)

                        Curseur := new T_Cellule;
                        Curseur.all.Cle := Cle;
                        Curseur.all.Donnee := Donnee;
                        Curseur.all.Suivant := Sda;

                        --Changer Sda (elle pointe maintenant sur le curseur)
                        Sda := Curseur;
                end if;
        end Enregistrer;


        function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
                Curseur : T_LCA;
        begin
                Curseur := Sda;
                while Curseur /= null loop
                        if Curseur.all.Cle = Cle then
                                return True;
                        end if;
                        Curseur := Curseur.all.Suivant;
                end loop;
                return False;
        end Cle_Presente;


        function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
        begin
                if Sda = null then
                        raise Cle_Absente_Exception;
                elsif Sda.all.Cle = Cle then
                        return Sda.all.Donnee;
                else
                        return La_Donnee(Sda.all.Suivant, Cle);
                end if;

        end La_Donnee;


        procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
                Memoire : T_LCA;

        begin
                if Sda /= null then

                        --Sda := Sda.all.Suivant;

                        if Sda.all.Cle = Cle then
                                Memoire := Sda;
                                Sda := Sda.all.Suivant;
                                Free(Memoire);

                        else
                                Supprimer(Sda.all.Suivant, Cle);
                        end if;
                else
                        raise Cle_Absente_Exception;
                end if;


        end Supprimer;


        procedure Vider (Sda : in out T_LCA) is
        begin
                if Sda /= null then
                        Vider (Sda.all.Suivant);
                        Free(Sda);
                else
                        null;
                end if;
        end Vider;


        procedure Pour_Chaque (Sda : in T_LCA) is
        begin
                if Sda /= null then
                        begin
                                Traiter(Sda.all.Cle, Sda.all.Donnee);
                        exception
                                when others => null;
                        end;
                        Pour_Chaque(Sda.all.Suivant);
                else
                        null;
                end if;
        end Pour_Chaque;




end LCA;
