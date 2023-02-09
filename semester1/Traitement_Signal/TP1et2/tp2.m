close all;
clear all;


% échantillons de la somme de deux cosinus et représentations temporelle et
% fréquentielle

f1 = 1000;
T1 = 1 / f1;
f2 = 3000;
T2 = 1 / f2;
fe = 10000;
Te = 1 / fe;

x = cos (2*pi*f1*[0 : Te :  99*Te]) + cos (2*pi*f2*[0 : Te :  99*Te]);
X = fft(x);




plot([0: Te : 99 * Te], x);
xlabel('Temps en s');
ylabel('Amplitude en V');

semilogy([0 : fe/100 : fe - fe/100]/fe, abs(X));
xlabel('Fréquence en Hz');


% Synthèse du filtre passe-bas
Nfft = 1024;
fc = 1500/fe;
N = 61;
Ordre_N = [-(N-1)/2:1:(N-1)/2];
h_N = 2 * fc * sinc(2*fc*Ordre_N);
F = [0:1:Nfft-1]*fe/Nfft-1;
y = filter(h_N,1,x);


figure
plot(h_N);

figure
plot(F, abs(fft(x,Nfft)).^2/max(abs(fft(x,Nfft)).^2));
hold on;
plot(F, abs(fft(h_N,Nfft)).^2,'r-');
plot(F, abs(fft(y,Nfft)).^2/max(abs(fft(y,Nfft)).^2),'g-');

figure
semilogy(F, abs(fft(x,Nfft)).^2/max(abs(fft(x,Nfft)).^2));
hold on;
semilogy(F, abs(fft(h_N,Nfft)).^2,'r-');
semilogy(F, abs(fft(y,Nfft)).^2/max(abs(fft(y,Nfft)).^2),'g-');

