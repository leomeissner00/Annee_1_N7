function [r,a,b] = calcul_parametres_correlation(Vd,Vg)
E_Vd = mean(Vd)
E_Vg = mean(Vg)
Ecart_type_Vd = sqrt(mean(Vd^2) - E_Vd^2)
Ecart_Type_Vg = sqrt(mean(Vg^2) - E_Vg^2)
Cov_Vg_Vd = mean(Vg*Vd) - E_Vd*E_Vg
r = sqrt(Cov_Vg_Vd)/(Ecart_type_Vd*Ecart_type_Vg)
a = sqrt(Cov_Vg_Vd)/(Ecart_type_Vd*Ecart_type_Vd)
b = E_Vg

end