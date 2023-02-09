close all
clear all

        %Études de chaines de transmission sur fréquence porteuse

% 3 Utilisation de la chaine passe-bas équivalente pour le calcul et
% l'estimation du taux d'erreur binaire
N = 1000;  % Longueur du signal aléatoire

%% 3.1 Implantation de la chaine sur fréquence porteuse
%Constante du Tp
alpha = 0.35;
fp = 2000;
Fe = 10000;
Te = 1/Fe;
Rb = 2000;
Ns = Fe/Rb;
Ts = Ns/Fe;

%% Génération d'un signal aléatoire binaire
Signal = randi(2, 1, N)-1; 

%Mapping QPSK
partieI = 2*(Signal(1:2:end))-1; %Partie réelle
partieQ = 2*(Signal(2:2:end))-1; %Partie imaginaire
mapping_s = partieI + j*partieQ; %Mapping QPSK

%Surréchantillonage:
Surrech = zeros(1,Ns);
Surrech(1,1) = 1;
Suite_diracs = kron(mapping_s, Surrech);



%Filtre de mise en forme
h = rcosdesign(alpha, length(Suite_diracs)/Ns, Ns);

%Filtrage en prenant en compte le retard induit
retard = length(Suite_diracs)/2;
x_e = filter(h,1,[Suite_diracs, zeros(1,retard)]);
x_e = x_e(retard+1:end);

%Affichage des signaux sur les voies en phase et en quadrature
figure(1);
subplot(2,1,1);
plot(real(x_e));
title('Voie en phase');
xlabel('t (en seconde)');
ylabel('Amplitude')
subplot(2,1,2);
plot(imag(x_e));
title('Voie en quadrature');
xlabel('t (en seconde)');
ylabel('Amplitude')




%DSP du signal
F_x = pwelch(x_e, [], [], [], Fe, 'twosided');
figure(3); %Affichage de la DSP en échelle log
semilogy(linspace(-Fe/2,Fe/2, length(F_x)),fftshift(F_x/max(abs(F_x))));
xlabel('f (en Hz)');
title('DSP du signal transmis');

M = 2;
Px = mean(abs(x_e).^2); %Calcul de la puissance du signal
TEB = [];
for i = 0:6
    Eb_div_n0 = 10^(i/10);
    sigma_square = (Px*Ns)/(2*log2(M)*(Eb_div_n0)); %Calcul de sigma bruit carré
    bruitI = sqrt(sigma_square)*randn(1,length(x_e)); %Partie réel du bruit
    bruitQ = sqrt(sigma_square)*randn(1,length(x_e)); %partie imaginaire du bruit
    x_bruit = x_e + bruitI + 1i*bruitQ; %Ajout du bruit au signal

    %Filtrage de réception en prenant en compte le retard induit
    z = filter(h,1,[x_bruit, zeros(1,retard)]);
    z = z(retard+1:end);
    
    
    
    
    %% Échantillonage du signal en sortie du filtre de recéption
    z_ech = z(1:Ns:length(z));
    
    %Prise de décision avec seuil optimal
    z_ech_real = zeros(1,length(z_ech));
    z_ech_im= zeros(1,length(z_ech));
    z_ech_real(find(real(z_ech) <=0)) = 0;
    z_ech_real(find(real(z_ech) >0)) = 1;
    z_ech_im(find(imag(z_ech) <=0)) = 0;
    z_ech_im(find(imag(z_ech) >0)) = 1;
    
    %Reconstruction du signal reçu
    a_m = zeros(1,2*length(z_ech));
    a_m(1:2:end)= z_ech_real;
    a_m(2:2:end)= z_ech_im;
    %% Recherche du taux d'erreur 
    diff = a_m- Signal;
    nb_e = find(diff ~= 0);
    TEB = [TEB length(nb_e)/length(Signal)];
end
figure() %Affichage du TEB
plot(TEB);
title('TEB')
xlabel('Rapport Eb/N0');
ylabel('Pourcentage')