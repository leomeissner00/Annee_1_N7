with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Auteur: 
-- Gérer un stock de matériel informatique.
--
package body Stocks_Materiel is

    procedure Creer (Stock : out T_Stock) is
    begin
        Stock.Stock_Nb := 0;
    end Creer;


    function Nb_Materiels (Stock: in T_Stock) return Integer is
    begin
        return Stock.Stock_Nb;
    end;


    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
                          ) is
        Objet : T_Objet;
    begin
        if Stock.Stock_Nb < CAPACITE then
            Objet.Numero_Serie := Numero_Serie;
            Objet.Nature := Nature;
            Objet.Annee_Achat := Annee_Achat;
            Objet.Etat := MARCHE;
        
            Stock.Stock_Nb := Stock.Stock_Nb +1;
            Stock.Stock_Tab(Stock.Stock_Nb) := Objet;
        else
            null;
        end if;
    end Enregistrer;
    
    
    function Nb_Materiels_HS (Stock : in T_Stock) return Integer is
        compteur : Integer;
        
    begin
        compteur := 0;
        for i in 1..Stock.Stock_Nb loop
            if Stock.Stock_Tab(i).Etat = NE_MARCHE_PAS then
                compteur := compteur + 1;
            end if;
        end loop;
        return compteur;
    end Nb_Materiels_HS;
    
    
    procedure Modifier_Objet (Stock : in out T_Stock;  Numero_Serie : in Integer) is
    begin
        for i in 1..Stock.Stock_Nb loop
            if Numero_Serie = Stock.Stock_Tab(i).Numero_Serie then
                if Stock.Stock_Tab(i).Etat = MARCHE then
                    Stock.Stock_Tab(i).Etat := NE_MARCHE_PAS;
                else
                    Stock.Stock_Tab(i).Etat := MARCHE;
                end if;
            end if;
        end loop;
    end Modifier_Objet;
    
    
    procedure Supprimer_Objet (Stock : in out T_Stock;  Numero_Serie : in Integer) is
        indice : Integer ;         --Indice du numéro de série que l'on cherche
    begin
        indice :=0;
        loop
           indice := indice+1;     
        exit when Numero_Serie = Stock.Stock_Tab(indice).Numero_Serie;
        end loop;               
        for i in indice..Stock.Stock_Nb loop
            Stock.Stock_Tab(i) := Stock.Stock_Tab(i+1);
            end loop;
        Stock.Stock_Nb := Stock.Stock_Nb-1;
    end Supprimer_Objet;


end Stocks_Materiel;
