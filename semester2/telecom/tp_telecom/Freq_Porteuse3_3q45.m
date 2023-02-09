close all
clear all

        %Études de chaines de transmission sur fréquence porteuse

% 3 Utilisation de la chaine passe-bas équivalente pour le calcul et
% l'estimation du taux d'erreur binaire
N = 1000;  % Longueur du signal aléatoire

%% 3.1 Implantation de la chaine sur fréquence porteuse
%Constante du TP
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

%Transposition de fréquence
t = [0:length(x_e)-1]*Te; %Génération du temps t
expo = exp(1i*2*pi*fp*t); %Génération de l'exponentielle
x = real(x_e.*expo);      %Génération du signal transmis

M = 2;
Px = mean(abs(x).^2); %Puissance de x
TEB = [];
TEBth = [];
for i = 0:0.5:6
    Eb_div_n0 = 10^(i/10);
    sigma_square = (Px*Ns)/(2*log2(M)*(Eb_div_n0)); %Calcul de sigma carré
    bruit = sqrt(sigma_square)*randn(1,length(x));  %Génération du bruit
    x_bruit = x + bruit; %Ajout du bruit au signal




    %Retour en bande de base
    Rbdb1 = x_bruit.*cos(2*pi*fp*t); %Partie réel
    Rbdb2 = x_bruit.*sin(2*pi*fp*t); %Partie imaginaire
    Rbdb = Rbdb1-1i*Rbdb2;

    %Filtrage de réception en prenant en compte le retard induit
    z = filter(h,1,[Rbdb, zeros(1,retard)]);
    z = z(retard+1:end);

    %% Échantillonage du signal en sortie du filtre de recéption
    z_ech = z(1:Ns:length(z));
    
    z_ech_real = zeros(1,length(z_ech));
    z_ech_im= zeros(1,length(z_ech));
    z_ech_real(find(real(z_ech) <=0)) = 0; %prise de décision avec seuil optimal
    z_ech_real(find(real(z_ech) >0)) = 1;
    z_ech_im(find(imag(z_ech) <=0)) = 0;
    z_ech_im(find(imag(z_ech) >0)) = 1;
    
    %Reconstitution du signal reçu
    a_m = zeros(1,2*length(z_ech));
    a_m(1:2:end)= z_ech_real;
    a_m(2:2:end)= z_ech_im;
    %% Recherche du taux d'erreur 
    diff = a_m- Signal;
    nb_e = find(diff ~= 0);
    TEB = [TEB length(nb_e)/length(Signal)]; %Ajout du TEB à la liste
    TEBth = [TEBth (1-normcdf(sqrt(Eb_div_n0)))]; %Calcul du TEB théorique
end


figure(7)
plot([0:0.5:6], TEB);
title('TEB simulé bleu, théorique en rouge')
xlabel('Rapport Eb/N0');
ylabel('Pourcentage')
hold on;
plot([0:0.5:6], TEBth);

%%Question 3_3_1 : Passe bas équivalent
%Voir script suivant pour les commentaires, c'est uniquement pour
%pouvoir comparer les TEB des 2 chaines à la fin

h = rcosdesign(alpha, length(Suite_diracs)/Ns, Ns);

retard = length(Suite_diracs)/2;
x_e = filter(h,1,[Suite_diracs, zeros(1,retard)]);
x_e = x_e(retard+1:end);

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




%DSP
F_x = pwelch(x_e, [], [], [], Fe, 'twosided');
figure(3);
semilogy(linspace(-Fe/2,Fe/2, length(F_x)),fftshift(F_x/max(abs(F_x))));
xlabel('f (en Hz)');
title('DSP du signal transmis');

M = 2;
Px = mean(abs(x_e).^2);
TEB2 = [];
for i = 0:0.5:6
    Eb_div_n0 = 10^(i/10);
    sigma_square = (Px*Ns)/(2*log2(M)*(Eb_div_n0));
    bruitI = sqrt(sigma_square)*randn(1,length(x_e));
    bruitQ = sqrt(sigma_square)*randn(1,length(x_e));
    x_bruit = x_e + bruitI + 1i*bruitQ;


    z = filter(h,1,[x_bruit, zeros(1,retard)]);
    z = z(retard+1:end);
    
    
    
    
    %% Échantillonage du signal en sortie du filtre de recéption
    z_ech = z(1:Ns:length(z));
    
    z_ech_real = zeros(1,length(z_ech));
    z_ech_im= zeros(1,length(z_ech));
    z_ech_real(find(real(z_ech) <=0)) = 0;
    z_ech_real(find(real(z_ech) >0)) = 1;
    z_ech_im(find(imag(z_ech) <=0)) = 0;
    z_ech_im(find(imag(z_ech) >0)) = 1;
    
    a_m = zeros(1,2*length(z_ech));
    a_m(1:2:end)= z_ech_real;
    a_m(2:2:end)= z_ech_im;
    %% Recherche du taux d'erreur 
    diff = a_m- Signal;
    nb_e = find(diff ~= 0);
    TEB2 = [TEB2 length(nb_e)/length(Signal)];
end
figure()
plot([0:0.5:6],TEB2);
title('TEB chaine 1 en rouge, chaine 2 en bleu')
xlabel('Rapport Eb/N0');
ylabel('Pourcentage')
hold on
plot([0:0.5:6],TEB)