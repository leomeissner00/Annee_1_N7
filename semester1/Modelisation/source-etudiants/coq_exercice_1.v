Require Import Naturelle.
Section Session1_2019_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Naturelle :  (A -> B -> C) -> ((A /\ B) -> C).
Proof.
intro H0.
intro H1.
cut B.
cut A.
apply H0.
cut(A/\B).
intro H2.
elim H2.
intros HA HB.
apply HA.
apply H1.
cut(A/\B).
intro H2.
elim H2.
intros HA HB.
apply HB.
apply H1.
Qed.

Theorem Exercice_1_Coq :  (A -> B -> C) -> ((A /\ B) -> C).
Proof.
(* A COMPLETER *)
Qed.

End Session1_2019_Logique_Exercice_1.

