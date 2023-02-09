clear all;
close all;
clc;

%% Données utilisées

N = 100;    % Longueur du message généré
Fe = 24000;
Rb = 3000;
Tb = 1/Rb;
Ns = Fe/Rb;
Ts = Ns/Fe;
Te = 1/Fe;

%% Génération d'un signal binaire aléatoire

bits = randi([0 1], 1, N);


%%%%%%%%%%%%%%%%%%%% Etude sans canal de propagation


%% bloc modulateur/démodulateur

        % Modulateur

% On réalise le mapping de la suite de bits  en affectant 1 aux bits 1 et -1 aux bits 0
Symboles = 2*bits - 1;

% On réalise le suréchantillonage 
Diracs = kron(Symboles, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre de mise en forme du modulateur 
h = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac

x = filter(h, 1, Diracs);


        % Démodulateur

% On génère la réponse impulsionnelle du filtre de réception
hr = h;

% On filtre notre signal

r = filter(hr, 1, x);


%% Tracé du signal en sortie du filtre de réception

figure (1)
plot([0:Ts/(N*Ns -1):Ts], r);
title('Signal en sortie du filtre de réception')
xlabel('t')
ylabel('r(t)')



%% Réponse impulsionnelle globale de la chaine de transmission

g = conv(h, hr);

figure(2);
plot(g);
title('Réponse impulsionnelle globale de la chaine de transmission')
xlabel('t')
ylabel('g(t)')


%% Instant optimale pour echantillonner sans interférences entre symboles n0 + m.Ns

n0 = Ns;    
% On prend n0 = Ns car à cette valeur, pour tout m != 0 g(n0 + m*Ns) = 0 : 
% respectant ainsi le critère de Nyquist 


%% Tracé du diagramme de l'oeil 

figure(3);
plot(reshape(r(Ns+1:end), Ns, length(r(Ns+1:end))/Ns));
title('Diagramme de l oeil')
xlabel('Temps')
ylabel('Amplitude')

% à Ns, il y a 2 valeurs possibles ce qui confirme notre résultat car cela 
% respecte le critère de Nyquist


%% Verification du taux d'erreur binaire à n0 = Ns
%Échantillonnage à l'instant optimal
r_ech = r(n0 : n0 : length(r));
%demapping
r_erreur = ((r_ech/Ns) + 1)/2;
%Calcul du TEB
erreur = length(find((r_erreur - bits).^2 ~= 0)) / N 


%% Estimation taux d'erreur binaire pour n0 = 3
%Échantillonnage à un autre instant
r_ech_3 = r(3 : Ns : length(r));
%Demapping
r_erreur_3 = ((r_ech_3/Ns) + 1)/2;
%Calcul TEB
erreur_3 = length(find((r_erreur_3 - bits).^2 ~= 0)) / N
% Le taux d'erreur à n0 = 3 est élevée car d'après le diagramme de l'oeil à 
% n0 = 3 il y a 4 valeurs possibles donc ça ne respecte pas le critère de Nyquist.



%%%%%%%%%%%%%%%%%%%% Etude avec canal de propagation 

%%%%%%%%%% BW = 8000 Hz

% Filtre passe-bas représentant le canal de propagation
N = 101;
BW1 = 8000;
hc1 = (2*BW1/Fe) * sinc(2*(BW1/Fe)*[-(N-1)/2 : (N-1)/2]);


% Tracé de la réponse impulsionnelle globale de la chaîne de transmission 
g1 = conv(conv(h, hc1), hr);

figure(4)
plot(g1);
title('Réponse impulsionnelle globale de la chaine de transmission avec BW = 8000 Hz')
xlabel('t')
ylabel('g(t)')

figure(101)
plot(g)
hold on
plot (hc1)

% Tracé du diagramme de l'oeil à la sortie du filtre de réception
retard = (N-1)/2;
z1 = filter(hc1, 1, [x zeros(1, retard)]);
z1 = z1(retard + 1 : end);
z1 = filter(hr, 1, z1);


figure(10)
plot(z1);

figure(5)
plot(reshape(z1(Ns+1:end), Ns, length(z1(Ns+1 : end))/Ns));
title('Diagramme de l oeil')
xlabel('Temps')
ylabel('Amplitude')
% Tracés des réponses en fréquence des filtres





%%%%%%%%%% BW = 1000 Hz

% Filtre passe-bas représentant le canal de propagation
N = 101;
BW2 = 1000;
hc2 = (2*BW2/Fe) * sinc(2*(BW2/Fe)*[-(N-1)/2 : (N-1)/2]);


% Tracé de la réponse impulsionnelle globale de la chaîne de transmission 
g2 = conv(conv(h, hc2), hr);

figure(7)
plot(g2);
title('Réponse impulsionnelle globale de la chaine de transmission avec BW = 1000 Hz')
xlabel('t')
ylabel('g(t)')

% Tracé du diagramme de l'oeil à la sortie du filtre de réception
z2 = filter(g2, 1, Diracs);

figure(8)
plot(reshape(z2(Ns+1:end), Ns, length(z2(Ns+1:end))/Ns));
title('Diagramme de l oeil')
xlabel('Temps')
ylabel('Amplitude')
% Tracé des réponses en fréquence des filtres