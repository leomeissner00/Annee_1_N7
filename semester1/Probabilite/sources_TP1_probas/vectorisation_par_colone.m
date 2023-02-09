function [Vd,Vg] = vectorisation_par_colonne(I)
G = I(:, 1:2:end-1)
D = I(:, 2:2:end)
Vd = D(:)
Vg = G(:)
end