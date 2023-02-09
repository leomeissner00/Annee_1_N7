%2.1

fe = 10000;
Te = 1/fe;
f0 = 1100;
Ech = cos(2*pi*f0*[0:Te:Te*89]);

plot([0:Te : Te*89], Ech);
xlabel('Secondes');
ylabel('cos(2*pi*fo*t');


fe_2 = 1000;
Te_2 = 1/fe_2;

Ech_2 = cos(2*pi*f0*[0:Te_2:Te_2*89]);

plot([0:Te_2 : Te_2*89], Ech_2);
xlabel('Secondes');
ylabel('cos(2*pi*fo*t)');
%cela ne respecte pas le critère de shannon donc on observe en sorti
%une fréquence de 100 Hz

%2.2

%1 Parce que c'est périodisé tous les Fe

Tf_ech = abs(fft(Ech,1024));
semilogy([0:fe/1024:fe-1]/fe, Tf_ech)

pwelch(Ech, [], [], 1024);