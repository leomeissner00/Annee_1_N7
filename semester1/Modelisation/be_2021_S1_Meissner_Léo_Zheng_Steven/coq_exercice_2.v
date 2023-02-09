Require Import Naturelle.
Section Session1_2021_Logique_Exercice_2.

Variable A B C : Prop.

Theorem Exercice_2_Naturelle : ((A /\ B) -> C) -> ((A -> C) \/ (B -> C)).
Proof.
I_imp H.
E_ou A (~A).
TE.
I_imp H2.
I_ou_d.
I_imp H3.
E_imp (A/\B).
Hyp H.
I_et.
Hyp H2.
Hyp H3.
I_imp H3.
I_ou_g.
I_imp H4.
E_antiT.
E_non A.
Hyp H4.
Hyp H3.
Qed.

Theorem Exercice_2_Coq : ((A /\ B) -> C) -> ((A -> C) \/ (B -> C)).
Proof.
intro H1.
cut (A\/~A).
intro H.
elim H.
intro H2.
right.
intro H3.
cut (A/\B).
exact H1.
Qed.

End Session1_2021_Logique_Exercice_2.

