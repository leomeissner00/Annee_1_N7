Require Import Naturelle.
Section Session1_2021_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Naturelle :  ((A -> C) \/ (B -> C)) -> ((A /\ B) -> C).
Proof.
I_imp H.
I_imp H1.
E_imp A.
E_ou (A -> C) (B -> C).
Hyp H.
I_imp H2.
Hyp H2.
I_imp H2.
I_imp H3.
E_imp B.
Hyp H2.
E_et_d A.
Hyp H1.
E_et_g B.
Hyp H1.
Qed.

Theorem Exercice_1_Coq : ((A -> C) \/ (B -> C)) -> ((A /\ B) -> C).
Proof.
intro H.
intro H1.
elim H.
intro H2.
cut A.
exact H2. 
cut (A /\ B).
intro H3.
elim H3.
intros HA HB.
exact HA.
exact H1.
intro H2.
cut B.
exact H2.
cut (A /\ B).
intro H3.
elim H3.
intros HA HB.
exact HB.
exact H1.
Qed.


End Session1_2021_Logique_Exercice_1.

