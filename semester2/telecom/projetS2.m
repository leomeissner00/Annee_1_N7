clear all;
close all;
clc;

%% Constante utilisée dans le script 

N =6;    % Longueur du message généré
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
bits = [0 1 1 0 0 1 ]%

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

xc = filter(hc, 1, x);
Px = mean(abs(x).^2);
M = 2;
Eb_div_N0 = power(10, 2/10);
sigma_n_carre = (Px * Ns) / (2 * log2(M) * (Eb_div_N0));
bruit = sqrt(sigma_n_carre) * randn(1, length(x));
xc = xc %+ bruit;

        % Démodulateur

% On génère la réponse impulsionnelle du filtre de réception
hr = h;

% On filtre notre signal

r = filter(hr, 1, xc);


        % Instant optimale pour echantillonner sans interférences entre symboles n0 + m.Ns
n0 = Ns;    
% On prend n0 = Ns car à cette valeur, pour tout m != 0 g(n0 + m*Ns) = 0 : 
% respectant ainsi le critère de Nyquist 


        % Verification du taux d'erreur binaire à n0 = Ns

r_ech = r(n0 : n0 : length(r));
r_ech(find(r_ech >= 0)) = 1;
r_ech(find(r_ech < 0)) = 0;



TEB = length(find((r_ech - bits).^2 ~= 0)) / N %plot des bails
figure (1)
plot([0:Ts:(N*Ns -1)*Ts], r);
title('Signal en sortie du filtre de réception')
xlabel('Temps');


figure (2)
    
plot(reshape(r(Ns+1:end), Ns, length(r(Ns+1:end))/Ns));
title('Diagramme de l oeil en sortie du filtre de réception')
xlabel('Temps');
