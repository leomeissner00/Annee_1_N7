close all
clear all

        %Études de chaines de transmission sur fréquence porteuse

% 3 Utilisation de la chaine passe-bas équivalente pour le calcul et
% l'estimation du taux d'erreur binaire
N = 1000;  % Longueur du signal aléatoire

%% 3.1 Implantation de la chaine sur fréquence porteuse

alpha = 0.35;
fp = 2000;  %Fréquence porteuse
Fe = 10000; %Fréquence d'échantillonnage
Te = 1/Fe;
Rb = 2000;
Ns = Fe/Rb;
Ts = Ns/Fe;

%% Génération d'un signal aléatoire binaire
Signal = randi(2, 1, N)-1; 

%Mapping QPSK
partieI = 2*(Signal(1:2:end))-1;    %Partie réelle
partieQ = 2*(Signal(2:2:end))-1;    %Partie imaginaire
mapping_s = partieI + j*partieQ;    %Génération du mapping

%Surréchantillonage:
Surrech = zeros(1,Ns);
Surrech(1,1) = 1;
Suite_diracs = kron(mapping_s, Surrech);



%Filtre de mise en forme
h = rcosdesign(alpha, length(Suite_diracs)/Ns, Ns);

retard = length(Suite_diracs)/2; %Prise en compte du retard dans le filtre
x_e = filter(h,1,[Suite_diracs, zeros(1,retard)]);  %Filtrage
x_e = x_e(retard+1:end); %Récuperation du signal avec le retard

%Affichage des voies en phase et en quadrature
figure(1);
subplot(2,1,1);
plot(real(x_e));
xlabel('t (en seconde)');
ylabel('Amplitude')
title('Voie en phase');
subplot(2,1,2);
plot(imag(x_e));
xlabel('t (en seconde)');
ylabel('Amplitude')
title('Voie en quadrature');


%Transposition de fréquence
t = [0:length(x_e)-1]*Te; %Génération du temps
expo = exp(1i*2*pi*fp*t); 
x = real(x_e.*expo);      %Multiplication du signal par l'exponentielle pour le transposer

%Tracer du
%signal transmis sur fréquence porteuse
figure(2);
plot(x);
title('Signal Transmis')
xlabel('t (en seconde)');
ylabel('Amplitude')

%DSP
F_x = pwelch(x, [], [], [], Fe, 'twosided');
%Tracé de la DSP en échelle log
figure(3);
semilogy(linspace(-Fe/2,Fe/2, length(F_x)),fftshift(F_x/max(abs(F_x))));
xlabel('f (en Hz)');
title('DSP du signal transmis');


%Partie réelle
Rbdb1 = x.*cos(2*pi*fp*t);
%Partie imaginaire
Rbdb2 = x.*sin(2*pi*fp*t);
%Retour en bande de base
Rbdb = Rbdb1-1i*Rbdb2;

%Filtrage de réception en prenant en compte le retard induit
z = filter(h,1,[Rbdb, zeros(1,retard)]);
z = z(retard+1:end);




%% Échantillonage du signal en sortie du filtre de recéption
z_ech = z(1:Ns:length(z));

z_ech_real = zeros(1,length(z_ech)); %Signal échantillonné réel
z_ech_im= zeros(1,length(z_ech));    %Signal échantillonné imaginaire
z_ech_real(find(real(z_ech) <=0)) = 0; %Prise de décision pour le signal réel
z_ech_real(find(real(z_ech) >0)) = 1;
z_ech_im(find(imag(z_ech) <=0)) = 0;   %Prise de décision pour le signal imaginaire
z_ech_im(find(imag(z_ech) >0)) = 1;

%Reconstitution du signal reçu
a_m = zeros(1,2*length(z_ech));
a_m(1:2:end)= z_ech_real;
a_m(2:2:end)= z_ech_im;
%% Recherche du taux d'erreur 
diff = a_m- Signal;
nb_e = find(diff ~= 0);
TEB =  length(nb_e)/length(Signal)

