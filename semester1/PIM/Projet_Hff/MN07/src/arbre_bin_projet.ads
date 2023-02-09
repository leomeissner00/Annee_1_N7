

-- DÉfinition de structures de donnÉes associatives sous forme d'un arbre
-- binaire de recherche (ABR).
generic
	type T_Cle is private;
	

package arbre_bin_projet is

	type T_Abr is private;

	-- Initialiser une Arbre.  La Arbre est vide.
	procedure Initialiser(Arbre: out T_Abr) with
		Post => Est_Vide (Arbre);


	-- Est-ce qu'une Arbre est vide ?
	function Est_Vide (Arbre : T_Abr) return Boolean;


	-- Enregistrer une Donnée associÉe à une Clé dans une Arbre.
	-- Si la clÉ est déjà présente dans la Arbre, sa donnÉe est changée.
	procedure Enregistrer_feuille (Arbre : in out T_Abr ; Donnee : in Integer ; Cle : in T_Cle);
		
	function Taille (Arbre : T_Abr) return Integer;

	-- Supprimer tous les ÉlÉments d'une Arbre.
	procedure Vider (Arbre : in out T_Abr) with
		Post => Est_Vide (Arbre);

	function Droite(Arbre : in T_Abr) return T_Abr;

	
	function Gauche(Arbre : in T_Abr) return T_Abr;

			
	procedure Fusionner(Arbre_g : in out T_Abr; Arbre_d : in T_Abr);
			

	function La_Cle (Arbre : in T_Abr) return T_Cle;


	function La_Donnee (Arbre : in T_Abr) return Integer;
		
			
	generic
		with procedure Traiter (Donnee : in Integer; Cle: in T_Cle);
	procedure Pour_Chaque_bin(Arbre : in T_Abr);
	
        function Est_Feuille (Arbre : in T_Abr) return Boolean;
        
        

private

	type T_Noeud;
	type T_Abr is access T_Noeud;
	type T_Noeud is
		record
			Donnee : Integer;
			Cle : T_Cle;
			Sous_Arbre_Gauche : T_Abr;
			Sous_Arbre_Droit : T_Abr;

		end record;

end arbre_bin_projet;
