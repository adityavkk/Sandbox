Require Export basics.

Theorem plus_n_O_firsttry : forall n : nat,
  n = n + 0.
Proof.
  intros n. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite <- IHn'. reflexivity. Qed.

Theorem minus_diag : forall n : nat,
  minus n n = 0.
Proof.
  intros n. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite <- IHn'. reflexivity.
Qed.

(* Exercise basic_induction *)
Theorem mult_0_r : forall n : nat,
  n * 0 = 0.
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite -> IHn'. reflexivity.
Qed.

Theorem plus_n_Sm : forall n m : nat,
  S (n + m) = n + (S m).
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite -> IHn'. reflexivity. Qed.

Theorem plus_comm : forall n m : nat,
  n + m = m + n.
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. rewrite <- plus_n_O_firsttry. reflexivity.
  - simpl. rewrite <- plus_n_Sm. rewrite -> IHn'. reflexivity. 
Qed.

Theorem plus_assoc : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite -> IHn'. reflexivity.
Qed.

(* Exercise double_plus *)
Fixpoint double (n:nat) :=
  match n with
  | O => O
  | S n' => S (S (double n'))
  end.

Lemma double_plus : forall n, double n = n + n.
Proof.
  intros. induction n as [| n' IHn'].
  - simpl. reflexivity.
  - simpl. rewrite <- plus_n_Sm. rewrite -> IHn'. reflexivity. 
Qed.

(*Exercise binary_inverse*)

Fixpoint nat_to_bin (n:nat) :=
  match n with
  | O => Z
  | S n' => incr (nat_to_bin n')
  end.

Fixpoint normalize (b:bin) :=
  match b with
  | Z => Z
  | T Z => Z
  | T b' => match (normalize b') with
            | T Z => Z
            | r => T r
            end
  | ST b' => ST (normalize b')
  end.

Theorem bin_nat_bin: forall b : bin,
  nat_to_bin(bin_to_nat b) = (normalize b).
Proof.
  intros. induction b as [| b' | b'' IHb''].
  - simpl. reflexivity.
  - simpl. rewrite <- plus_n_O_firsttry

