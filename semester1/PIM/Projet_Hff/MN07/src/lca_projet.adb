-- with Ada.Text_IO;            use Ada.Text_IO;
with Codage_Huffmann_Exception;         use Codage_Huffmann_Exception;
with Ada.Unchecked_Deallocation;

package body LCA_projet is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null;

	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return Sda = null;
	end;


	function Taille (Sda : in T_LCA) return Integer is
	begin

		if Sda = null then
			return 0;

		else
			return Taille(Sda.all.Suivant) + 1;
		end if;

	end Taille;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
	begin

		if Sda = null then
			Sda := new T_cellule' (Cle => Cle, Donnee => Donnee , Suivant => Null);

		elsif Sda.all.Cle = Cle then
			Sda.all.Donnee := Donnee;

		else
			Enregistrer(Sda.all.Suivant, Cle, Donnee);

		end if;

	end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	begin
		if Sda = null then
			return false;
		elsif Sda.all.Cle = Cle then

			return True;
		else
			return Cle_Presente(Sda.all.Suivant, Cle);
		end if;
	end;


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

	function La_Cle (Sda : in T_LCA ) return T_Cle is
	begin
		if Sda = null then
			raise Cle_Absente_Exception;

		else
			return Sda.all.Cle;

		end if;
	end La_Cle;



	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
		temp : T_LCA;

	begin
		if Sda /= null then
			if Sda.all.Cle = Cle then
				temp := Sda;
				Sda := Sda.all.Suivant;
				Free(temp);
			else
				Supprimer(Sda.all.Suivant,Cle);
			end if;
		else
			raise Cle_Absente_Exception;
		end if;
	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
		if Sda = null then
			Free(Sda);

		else
			Vider(Sda.all.Suivant);
			Free(Sda);

		end if;
	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
	begin
		if Sda = null then
			null;
		else
			begin
				Traiter(Sda.all.Cle, Sda.all.Donnee);
				Pour_Chaque(Sda.all.Suivant);
			exception
				when others => Pour_Chaque(Sda.all.Suivant);
			end;
		end if;
	end Pour_Chaque;

	function La_Suivante (Sda : in T_LCa) return T_LCA is


	begin

		return Sda.all.Suivant;

	end La_Suivante;


end LCA_projet;
