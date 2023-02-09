
-- Auteur: 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);

    
    type T_Stock is limited private;

    -- Créer un stock vide.
    --
    -- paramètres
    --     Stock : le stock à créer
    --
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;


    -- Obtenir le nombre de matériels dans le stock Stock.
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;

    
    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;
    
    
    --Obtenir le nombre de Matériels hors état de fonctionnement dans le stock
    --
    -- Pramètres
    --    Stock : le Stock sur lequel on veut récupérer l'information
    --Necessite:
    --    Vrai
    --Assure
    --    Resultat >= 0 and Resultat <= Capacité
    --
    function Nb_Materiels_HS  (Stock : in T_Stock) return Integer with
            Post => Nb_Materiels_HS'Result >= 0 and Nb_Materiels_HS'Result <= CAPACITE;
    
    
    -- Mettre à jour l'état d'un matériel enregistrer dans le stock à partir de son numéro de série
    -- Paramètres
    --    Stock : Le stock que l'on veut modifier
    --    Numero_Serie : Le numero de serie de l'objet que l'on veut modifier dans le stock
    --
    --Necessite
    --    Numero_Serie doit appartenir au stock
    --
    --Assure
    --    Le nouveau numero de serie a bien été pris en compte
    procedure Modifier_Objet (Stock : in out T_Stock;  Numero_Serie : in Integer) with
            Pre => True ,
            Post => True ;
    
    
    -- Supprimer un matériel enregistrer dans le stock à partir de son numéro de série
    -- Paramètres
    --    Stock : Le stock que l'on veut modifier
    --    Numero_Serie : Le numero de serie de l'objet que l'on veut supprimer dans le stock
    --
    --Necessite
    --    Numero_Serie doit appartenir au stock
    --
    --Assure
    --    Le nouveau numero de serie a bien été pris en compte
    procedure Supprimer_Objet (Stock : in out T_Stock;  Numero_Serie : in Integer) with
            Pre => True ,
            Post => True ;
    
    
private
    
    type T_Etat is (MARCHE, NE_MARCHE_PAS);
    type T_Objet is
        record
            Numero_Serie : Integer;
            Nature : T_Nature;
            Annee_Achat : Integer;
            Etat : T_Etat;
 
        end record;
    type T_Stock_Tab is  array (1..Capacite) of T_Objet;
    type T_Stock is
        record
            Stock_Tab : T_Stock_Tab;
            Stock_Nb  : Integer;
             
    end record;
end Stocks_Materiel;