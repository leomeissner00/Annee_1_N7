close all
clear all

load donnees1;
load donnees2;



%% Constante utilisée dans le tout le code 

N = length(bits_utilisateur1);
fe = 120000;
Te = 1/fe;
Ns = 10;
Ts = Ns*Te;
T = 0.04;
slot1 = 2;
slot2 = 5;
fp1 = 0;
fp2 = 46000;

    % CONSTRUCTION DU SIGNAL MF-TDMA A DECODER

%% 3.2.1 - Modulation bande base 

% On calcule les signaux m1(t) et m2(t) à partir de la suite de bits
% fournie

m1 = kron(2*bits_utilisateur1 - 1, ones(1, Ns));
m2 = kron(2*bits_utilisateur2 - 1, ones(1, Ns));


figure
plot([0 : T/(N*Ns -1) : T], m1);
xlabel('t (en s)');
ylabel('m1(t)')
title('représentation temporelle du message 1')

figure
plot([0 : T/(N*Ns -1) : T], m2);
xlabel('t (en s)');
ylabel('m2(t)');
title('représentation temporelle du message 2')


% On calcule les densités spectrales de puissance des signaux m1(t) et m2(t)

M1 = abs(fft(m1)).^2 / max(abs(fft(m1)).^2);
M2 = abs(fft(m2)).^2 / max(abs(fft(m2)).^2);



figure
semilogy(M1);
xlabel('f en hz')
ylabel('M1(f)')
title('représentation de la densité spectrale de puissance du message 1')


figure 
semilogy(M2);
xlabel('f en hz')
ylabel('M2(f)')
title('représentation de la densité spectrale de puissance du message 2')



%% 3.2.2 - Construction du signal MF-TDMA

% On génère les deux signaux de 5 slots et on y place les messages m1 et m2

m1_slot = zeros(1, 5*N*Ns);
m2_slot = zeros(1, 5*N*Ns);
m1_slot((slot1-1)*4800 : slot1*4800 - 1) = m1;
m2_slot((slot2-1)*4800 : slot2*4800 - 1) = m2;


figure 
plot(m1_slot);
xlabel('t en s');
ylabel('m1_slot(t)');
title('Représentation du signal m1 dans son slot')

figure 
plot(m2_slot);
xlabel('t en s');
ylabel('m2_slot(t)');
title('Représentation du signal m2 dans son slot')


% On place les messages précédemment construits sur leur fréquence porteuse

temps = [0: 5*T/(5*N*Ns - 1) :5*T];
x1 = m1_slot.*cos(2*pi*fp1*temps);
x2 = m2_slot.*cos(2*pi*fp2*temps);


% On somme les signaux dans leur slot pour former le signal complet

x = x1 + x2;


% On ajoute le bruit gaussien

SNR_db = 10;
Ps = mean(abs(x).^2);
SNR = 10^(SNR_db/10);
Pb = Ps/SNR;
Bruit = sqrt(Pb)*randn(1,length(x));

x = x + Bruit;

figure 
plot([0 : 5*T/(5*N*Ns - 1) : 5*T], x);
xlabel('t en s');
ylabel('x(t)');
title('représentation temporelle du signal complet')


% On calcul la densité spectrale de puissance du signal complet 

X = abs(fft(x)).^2 / max(abs(fft(x)).^2);;


figure 
semilogy(X);
xlabel('f en Hz');
ylabel('X(f)');
title('représentation de la densite spectrale de puissance du signal complet');



    % MISE EN PLACE DU RECEPTEUR MF-TDMA


%% 4.1.1 - Synthèse du filtre pâsse-bas

% On implante le filtre passe-bas pour récupérer le signal x1

fc_bas = 30000/fe;
N_filtre = 101;
Ordre_N_filtre = [-(N_filtre-1)/2:1:(N_filtre-1)/2];
h_N_bas = 2 * fc_bas * sinc(2*fc_bas*Ordre_N_filtre);


% Affichage de la réponse impultionelle du filtre passe-bas
figure
plot(h_N_bas);
xlabel('t en s');
ylabel('h_bas(t)')
title('reponse impultionelle du filtre passe bas');

% Affichage de la réponse fréquentielle du filtre passe-bas
figure
semilogy(abs(fft(h_N_bas)).^2 / max(abs(fft(h_N_bas)).^2));
xlabel('f en Hz');
ylabel('H_bas(f)')
title('réponse en fréquence du filtre passe bas')

% Affichage de la densité spectrale du signal reçu et de la réponse fréquentielle du filtre passe-bas
figure
semilogy(X);
hold on;
semilogy(abs(fft(h_N_bas)).^2 / max(abs(fft(h_N_bas)).^2),'g-');
xlabel('f en Hz');
ylabel('X(f) en bleu | H_bas(f) en vert')
title('densité spectrale de puissance du signal reçu et reponse fréquentielle du filtre passe bas')



%%  4.1.2 - Synthèse du filtre passe-haut

% On implante le filtre passe_haut pour récupérer le signal x2

h_N_haut = -h_N_bas;
h_N_haut((N_filtre-1)/2+1) = 1 - h_N_bas((N_filtre-1)/2+1);

% Affichage de la réponse impultionelle du filtre passe-haut
figure
plot(h_N_haut);
xlabel('t en s');
ylabel('h_haut(t)')
title('réponse impultionelle du filtre passe haut')

% Affichage de la réponse fréquentielle du filtre passe-haut
figure 
semilogy(abs(fft(h_N_haut)).^2 / max(abs(fft(h_N_haut)).^2));
xlabel('f en Hz');
ylabel('H_haut(f)');
title('réponse en fréquence du filtre passe haut')

% Affichage de la densité spectrale du signal reçu et de la réponse fréquentielle du filtre passe-haut
figure
semilogy(X);
hold on;
semilogy((abs(fft(h_N_haut)).^2),'r-');
xlabel('f en Hz');
ylabel('X(f) en bleu | H_haut(f) en rouge')
title('représentation fréquentielle du signal reçu et du filtre passe haut')


%%   4.1.3 - Filtrage 

% Calcul des signaux à retrouver à l'aide de la fonction filter.m
retard = (N_filtre-1)/2;
x1_tilde = filter(h_N_bas,1,[x zeros(1, retard)]);
x1_tilde = x1_tilde(retard+1:end);

x2_tilde = filter(h_N_haut,1,[x zeros(1, retard)]);
x2_tilde = x2_tilde(retard+1:end);

% Affichage de ces signaux
figure
plot(x1_tilde);
xlabel('t en s');
ylabel('x1~(t)')
title('représentation du message filtré par le passe bas');

figure
plot(x2_tilde);
xlabel('t en s');
ylabel('x2~(t)')
title('représentation du message filtré par le passe heut')


%% 4.2 Retour en bande de base

% On multiplie par un cos de même fréquence que la fréquence porteuse de chaque signal 

x1_rbb = x1_tilde.*cos(2*pi*fp1*temps);
x2_rbb = x2_tilde.*cos(2*pi*fp2*temps);

fc_bb = 10000/fe;
h_N_bb = 2 * fc_bb * sinc(2*fc_bb*Ordre_N_filtre);


% on filtre ainsi ce signal par un passe-bas pour obtenir une démodulation d'amplitude cohérente 

x1_retour_bande_base = filter(h_N_bb, 1, [x1_rbb zeros(1, retard)]);
x2_retour_bande_base = filter(h_N_bb, 1, [x2_rbb zeros(1, retard)]);

x1_retour_bande_base = x1_retour_bande_base(retard+1:end);
x2_retour_bande_base = x2_retour_bande_base(retard+1:end);

%% 4.3 - Detection du slot utile 

% Calcul de l'énergie de chaque slot de chacun des deux signaux récuperés

E_slot1_1 = mean(abs(x1_retour_bande_base(1:4800)).^2);
E_slot2_1 = mean(abs(x1_retour_bande_base(4801:9600)).^2);
E_slot3_1 = mean(abs(x1_retour_bande_base(9601:14400)).^2);
E_slot4_1 = mean(abs(x1_retour_bande_base(14401:19200)).^2);
E_slot5_1 = mean(abs(x1_retour_bande_base(19201:24000)).^2);

E_slot1_2 = mean(abs(x2_retour_bande_base(1:4800)).^2);
E_slot2_2 = mean(abs(x2_retour_bande_base(4801:9600)).^2);
E_slot3_2 = mean(abs(x2_retour_bande_base(9601:14400)).^2);
E_slot4_2 = mean(abs(x2_retour_bande_base(14401:19200)).^2);
E_slot5_2 = mean(abs(x2_retour_bande_base(19201:24000)).^2);

% On récupère le slot où l'énergie y est maximale pour chauqe signal 
E_retourne_1 = [E_slot1_1 E_slot2_1 E_slot3_1 E_slot4_1 E_slot5_1];
[~ , slot_signal_1] = max(E_retourne_1);

E_retourne = [E_slot1_2 E_slot2_2 E_slot3_2 E_slot4_2 E_slot5_2];
[~ , slot_signal_2] = max(E_retourne);

% On recupère le message sur le slot calculé précédemment
message1_retrouve = x1_retour_bande_base((slot_signal_1 - 1)*4800 + 1: slot_signal_1*4800);
message2_retrouve = x2_retour_bande_base((slot_signal_2 - 1)*4800 + 1: slot_signal_2*4800);


%% 4.4 - Démodulation bande de base 

% On procède à une démodulation en bande de base pour récuperer les bits de chaque message 

SignalFiltre_1=filter(ones(1,Ns),1,message1_retrouve) ;
SignalEchantillonne_1=SignalFiltre_1(Ns :Ns :end) ;
BitsRecuperes_1=(sign(SignalEchantillonne_1)+1)/2;

SignalFiltre_2=filter(ones(1,Ns),1,message2_retrouve) ;
SignalEchantillonne_2=SignalFiltre_2(Ns :Ns :end) ;
BitsRecuperes_2=(sign(SignalEchantillonne_2)+1)/2;



%% FINAL BIN TO STR

% On utilise la fonctino bin2str.m pour tranformer les bits récuperés en une chaîne de caractère formant ainsi le message à décoder

Message1 = bin2str(BitsRecuperes_1)
Message2 = bin2str(BitsRecuperes_2)