 function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'opérateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivité dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'opérateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
L=sparse([]);
N = N1*N2;

D_1 = 2*(nu(1)/(dx1^2))*speye(N, N);
D_2 = 2*(nu(2)/(dx2^2))*speye(N, N);

D_Haut = (-nu(2)/(dx2^2))*speye(N-1, N-1);
D_Bas = (-nu(1)/(dx1^2))*speye(N-1, N-1);

compteur = 1;
while compteur < N
    compteur = compteur + N1
    D_Haut(compteur,compteur) = 0;
    D_Bas(compteur,compteur) = 0;
end;

S_Haut = spdiags(D_Haut, 1, N,N);
S_Bas = spdiags(D_Bas, -1, N,N);

%D_Haut_2 = (-nu(1)/(dx1^2))*speye(N1,N1);
%S_Haut_2 = spdiags(D_Haut_2, N1, N, N);

%D_Bas_2 = (-nu(2)/(dx2^2))*speye(N1,N1);
%S_Bas_2 = spdiags(D_Bas_2, -N1, N, N);

L = L + D_1 + D_2 + S_Haut + S_Bas ;%+ S_Haut_2 + S_Bas_2;

print (L);
%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TO DO %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%

end    