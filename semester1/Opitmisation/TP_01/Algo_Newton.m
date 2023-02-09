function [beta, norm_grad_f_beta, f_beta, norm_delta, nb_it, exitflag] ...
          = Algo_Newton(Hess_f_C14, beta0, option)
%************************************************************
% Fichier  ~gergaud/ENS/Optim1a/TP-optim-20-21/Newton_ref.m *
% Novembre 2020                                             *
% Université de Toulouse, INP-ENSEEIHT                      *
%************************************************************
%
% Newton r�sout par l'algorithme de Newton les problemes aux moindres carres
% Min 0.5||r(beta)||^2
% beta \in R^p
%
% Parametres en entrees
% --------------------
% Hess_f_C14 : fonction qui code la hessiennne de f
%              Hess_f_C14 : R^p --> matrice (p,p)
%              (la fonction retourne aussi le residu et la jacobienne)
% beta0  : point de départ
%          real(p)
% option(1) : Tol_abs, tolérance absolue
%             real
% option(2) : Tol_rel, tolérance relative
%             real
% option(3) : nitimax, nombre d'itérations maximum
%             integer
%
% Parametres en sortie
% --------------------
% beta      : beta
%             real(p)
% norm_gradf_beta : ||gradient f(beta)||
%                   real
% f_beta    : f(beta)
%             real
% res       : r(beta)
%             real(n)
% norm_delta : ||delta||
%              real
% nbit       : nombre d'itérations
%              integer
% exitflag   : indicateur de sortie
%              integer entre 1 et 4
% exitflag = 1 : ||gradient f(beta)|| < max(Tol_rel||gradient f(beta0)||,Tol_abs)
% exitflag = 2 : |f(beta^{k+1})-f(beta^k)| < max(Tol_rel|f(beta^k)|,Tol_abs)
% exitflag = 3 : ||delta)|| < max(Tol_rel delta^k),Tol_abs)
% exitflag = 4 : nombre maximum d'itérations atteint
%      
% ---------------------------------------------------------------------------------

% TO DO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    beta = beta0;
    norm_grad_f_beta = 0;
    Choses = Hess_f_C14(beta0);
    residu = Choses(2);
    J_residu = Choses(3);
    norm_grad_f_beta0 = sqrt(sum(J_residu'*residu.*J_residu'*residu));

    f_beta = 0;
    norm_delta = 0;
    nb_it = 0;
    exitflag = 0;
    

    while exitflag == 0                      
        
        nb_it = nb_it+1;
        Choses = Hess_f_C14(beta);
        H_f = Choses(1);
        residu = Choses(2);
        J_residu = Choses(3);

        delta = (H_f)\J_residu'*residu;
        beta = beta - delta;
        residu1 = Choses(2);
        J_residu1 = Choses(3);
        f_beta = 0.5*sum(residu.*residu);
        f_beta_suivant = 0.5*sum(residu1.*residu1);

        norm_beta = sqrt(beta'*beta);
        norm_delta = sqrt(sum(delta.*delta));

        norm_grad_f_beta =  sqrt(sum(J_residu'*residu.*J_residu'*residu));
        norm_grad_f_beta_suivant =  sqrt(sum(J_residu1'*residu1.*J_residu1'*residu1));
        
        if norm_grad_f_beta_suivant <= max(option(2)*norm_grad_f_beta0, option(1))
            exitflag = 1;
            break
        end
        if abs(f_beta_suivant-f_beta) <= max(option(2)*abs(f_beta), option(1))
            exitflag = 2;
            break
        end  
        
        if norm_delta <= max(option(2)*norm_beta, option(1))
            exitflag = 3;
            break
        end
        
        
        if nb_it == option(3)
            exitflag = 4;
            break
        end
        
        
    end





end
