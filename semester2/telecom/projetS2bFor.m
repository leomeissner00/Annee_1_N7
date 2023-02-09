clear all;
close all;
clc;

%% Constante utilisée dans le script 

N = 10000;    % Longueur du message généré
Fe = 24000;
Rb = 3000;
Tb = 1/Rb;
Ns = Fe/Rb;
Ts = Ns/Fe;
Te = 1/Fe;

alpha0 = 1;
alpha1 = 0.5;

%% Génération d'un sigal aléatoire binaire

% On génére aléatoirement une suite de 0 et de 1 de la longueur voulue 
bits = randi([0 1], 1, N);%[0 1 1 0 0 1 ]%

% On réalise le mapping de la suite de bits  en affectant 1 aux bits 1 et -1 aux bits 0
Symboles1 = 2*bits - 1;

%Génération d'un dirac à l'entrée
n = 10000;
d = [1, zeros(1,n)];

% On réalise le suréchantillonage 
Diracs1 = kron(Symboles1, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre du modulateur 1
h = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac
x = filter(h, 1, Diracs1);

hc = kron([alpha0, alpha1], [1 zeros(1, Ns-1)]);

xc = filter(hc,1,x);

        % MISE EN PLACE DU BRUIT 
n0 = Ns;

Px = mean(abs(xc).^2);
M = 2;
TEB_bruit = [];
TEB_th = [];
for i = 0:10
    Eb_div_N0 = power(10, i/10);
    sigma_n_carre = (Px * Ns) / (2 * log2(M) * (Eb_div_N0));
    bruit = sqrt(sigma_n_carre) * randn(1, length(xc));
    x_bruit = xc + bruit;
    r_bruit = filter(h, 1, x_bruit);
  

        % Tracé diagrammes de l'oeil

    %figure (i+1)
    
    %plot(reshape(r_bruit(Ns+1:end), Ns, length(r_bruit(Ns+1:end))/Ns));
    
    
    r_ech_bruit = r_bruit(n0 : n0 : length(r_bruit));
    r_ech_bruit(find(r_ech_bruit >= 0)) = 1;
    r_ech_bruit(find(r_ech_bruit < 0)) = 0;
    TEB_bruit = [TEB_bruit length(find((r_ech_bruit - bits).^2 ~= 0)) / N];
    
    arg = sqrt(2*Eb_div_N0);
    TEB_th = [TEB_th qfunc(arg)];
    

end

plot(TEB_bruit)
hold on
plot(TEB_th)