clear all;
close all;
clc;

%% Constante utilisée dans le script 

N = 500;    % Longueur du message généré
Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000;  % Débit binaire
Tb = 1/Rb;
Ns = Fe/Rb; % Facteur de suréchantillonnage
Ts = Ns/Fe; % Temps d'émission symboles
Te = 1/Fe;

%% Génération d'un sigal aléatoire binaire

% On génére aléatoirement une suite de 0 et de 1 de la longueur voulue 
bits = randi([0 1], 1, N);


%% Modulateur 1 

% On réalise le mapping de la suite de bits  en affectant 1 aux bits 1 et -1 aux bits 0
Symboles1 = 2*bits - 1;

% On réalise le suréchantillonage 
Diracs1 = kron(Symboles1, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre du modulateur 1
h1 = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac

x1 = filter(h1, 1, Diracs1);


%% Modulateur 2

% On réalise le mapping de la suite de bits en affectant aux bits 00 la
% valeur -3, aux bits 01 la valeur -1, aux bits 11 la valeur +1 et aux bits
% 10 la valeur +3;

Symboles2 = 2*bi2de(reshape(bits, N/2, 2), 'right-msb') - 3 ;

% On réalise le suréchantillonnage 
Diracs2 = kron(Symboles2', [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre du modulateur 2
h2 = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac
x2 = filter(h2, 1, Diracs2);


%% Modulateur 3 

% On réalise le mapping de la suite de bits  en affectant 1 aux bits 1 et -1 aux bits 0
Symboles3 = 2*bits - 1;

% On réalise le suréchantillonage 
Diracs3 = kron(Symboles3, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre du modulateur 3
alpha = 1;
h3 = rcosdesign(alpha, length(Diracs3)/Ns, Ns);

% On filtre notre suite d'impulsions de Dirac en prenant en compte le
% retard
retard = length(Diracs3)/2;
x3 = filter(h3, 1, [Diracs3, zeros(1,retard)]);
x3 = x3(retard+1:end);

%% Représentations temporelles des signaux

figure (1)
plot([0:Ts/(N*Ns -1):Ts], x1);
xlabel('t (en seconde)');
ylabel('SignalTransmis x(t)');
title('Modulateur bande de base 1')

figure (2)
plot([0:2*Ts/(N*Ns -1):Ts], x2);
xlabel('t (en seconde)');
ylabel('SignalTransmis x(t)');
title('Modulateur bande de base 2')

figure (3)
plot([0:Ts/(N*Ns -1):Ts], x3);
xlabel('t (en seconde)');
ylabel('SignalTransmis x(t)');
title('Modulateur bande de base 3')


%% Représentation de la densite spectrale des signaux

S_x1 = pwelch(x1, [], [], [], Fe, 'twosided');
S_x2 = pwelch(x2, [], [], [], Fe, 'twosided');
S_x3 = pwelch(x3, [], [], [], Fe, 'twosided');


figure (4)
semilogy(linspace(-Fe/2, Fe/2, length(S_x1)), fftshift(S_x1/max(abs(S_x1))));
xlabel('f (en Hz)');
ylabel('DSP du Signal Transmis');
title('Modulateur bande de base 1');

figure (5)
semilogy(linspace(-Fe/2, Fe/2, length(S_x2)), fftshift(S_x2/max(abs(S_x2))));
xlabel('f (en Hz)');
ylabel('DSP du Signal Transmis');
title('Modulateur bande de base 1');

figure (6)
semilogy(linspace(-Fe/2, Fe/2, length(S_x3)), fftshift(S_x3/max(abs(S_x3))));
xlabel('f (en Hz)');
ylabel('DSP du Signal Transmis');
title('Modulateur bande de base 2');

%% Comparaison simulation / théorique

% Comparaison modulateur 1
%Calcul de la DSP théorique
S_x1_theorie = Ts*sinc(linspace(-Fe/2, Fe/2, length(S_x1))*Ts).^2;

figure (7)
semilogy(linspace(-Fe/2, Fe/2, length(S_x1)), fftshift(S_x1/max(abs(S_x1))));
hold on;
semilogy(linspace(-Fe/2, Fe/2, length(S_x1_theorie)), S_x1_theorie/max(abs(S_x1_theorie)));
xlabel('f (en Hz)');
ylabel('DSP du Signal Transmis, Réelle en bleu Théorique en rouge');
title('Modulateur bande de base 1');

% Comparaison modulateur 2
%Calcul de la DSP théorique
S_x2_theorie = Ts*sinc(linspace(-Fe/2, Fe/2, length(S_x2))*Ts).^2;

figure (8)
semilogy(linspace(-Fe/2, Fe/2, length(S_x2)), fftshift(S_x2/max(abs(S_x2))));
hold on;
semilogy(linspace(-Fe/2, Fe/2, length(S_x2_theorie)), S_x2_theorie/max(abs(S_x2_theorie)));
xlabel('f (en Hz)');
ylabel('DSP du Signal Transmis, Réelle en bleu Théorique en rouge');
title('Modulateur bande de base 2');

% Comparaison modulateur 3
%Calcul de la DSP théorique
[t3, v3] = size(S_x3);
lin3 = linspace(-Fe/2, Fe/2, t3);
S_x3_theorie = (Ts*(abs(lin3))<= ((1-alpha)/(2*Ts))) + ((Ts/2)*(1+cos((pi*Ts/alpha)*(abs(lin3)-((1-alpha)/(2*Ts)))))).*(((1-alpha)/(2*Ts))<= abs(lin3)).*(abs(lin3)<= ((1+alpha)/(2*Ts)));

figure (9)
semilogy(linspace(-Fe/2, Fe/2, length(S_x3)), fftshift(S_x3/max(abs(S_x3))));
hold on;
semilogy(linspace(-Fe/2, Fe/2, length(S_x3_theorie)), S_x3_theorie/max(abs(S_x3_theorie)));
xlabel('f (en Hz)');
ylabel('DSP du Signal Transmis, Réelle en bleu Théorique en rouge');
title('Modulateur bande de base 3');


%% Comparaison efficacité spectrale

figure (10)
semilogy(linspace(-Fe/2, Fe/2, length(S_x1)), fftshift(S_x1/max(abs(S_x1))), '-b');
hold on;
semilogy(linspace(-Fe/2, Fe/2, length(S_x2)), fftshift(S_x2/max(abs(S_x2))), '-g');
semilogy(linspace(-Fe/2, Fe/2, length(S_x3)), fftshift(S_x3/max(abs(S_x3))), '-r');
title('DSP MOD 1 en bleu | DSP MOD 2 en vert | DSP MOD 3 en rouge');



