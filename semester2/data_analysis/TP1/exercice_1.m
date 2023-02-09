clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('ishihara-0.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:, :, 1));
V = double(I(:, :, 2));
B = double(I(:, :, 3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
R_vect = R(:);
V_vect = V(:);
B_vect = B(:);
X = [R_vect-mean(R_vect) V_vect-mean(V_vect) B_vect-mean(B_vect)]; % Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance :
Sigma = (1/size(X,1))*(X'*X);

% Coefficients de correlation lineaire :
rRV = (Sigma(1,2))/sqrt(Sigma(1,1)*Sigma(2,2));
rRB = (Sigma(1,3))/sqrt(Sigma(1,1)*Sigma(3,3));
rVB = (Sigma(2,3))/sqrt(Sigma(2,2)*Sigma(3,3));

% Proportions de contraste :
Cr = (Sigma(1,1))/(sum(diag(Sigma)));
Cv = (Sigma(2,2))/(sum(diag(Sigma)));
Cb = (Sigma(3,3))/(sum(diag(Sigma)));