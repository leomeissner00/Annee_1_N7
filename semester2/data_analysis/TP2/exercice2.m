load Data_Exo_2/SG3.mat
load Data_Exo_2/ImSG3.mat

[n, m] = size(ImMod);
[n_1, m_1] = size(DataMod);

A = reshape((-1)*Data, [n_1*m_1, 1]);
B = reshape(DataMod, [n_1*m_1, 1]);

A_tild = [A ones(n_1*m_1, 1)];
B_tild = log(B);

X = pinv(A_tild)*B_tild;


Vrai_im = reshape(ImMod, [n*m, 1]);
Vrai_im = log(Vrai_im);
Inv = (Vrai_im-X(2,1))*1/((-1)*X(1,1));
Im_fin = reshape(Inv, [n, m]);

figure;
subplot(1,2,1);
imshow(I);
subplot(1,2,2);
imshow(Im_fin);

erreur = sqrt((mean((I(:)-Im_fin(:)).^2)))