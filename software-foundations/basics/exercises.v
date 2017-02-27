Module NatPlayground.

Definition notb (b1:bool) :=
  match b1 with
  | true => false
  | false => true
  end.

Definition andb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => b2
  | false  => false
  end.

Infix "&&" := andb.

Definition nandb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | false => true
  | true  => (notb b2)
  end.

Example test_nandb1: (nandb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb2: (nandb false false) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb3: (nandb false true) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb4: (nandb true true) = false.
Proof. simpl. reflexivity. Qed.

Definition andb3 (b1:bool) (b2:bool) (b3:bool) : bool :=
  match b1 with
  | true => b2 && b3
  | false => false
  end.

Example test_andb31: (andb3 true true true) = true.
Proof. simpl. reflexivity. Qed.
Example test_andb32: (andb3 false true true) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb33: (andb3 true false true) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb34: (andb3 true true false) = false.
Proof. simpl. reflexivity. Qed.

(* Check asks Coq to print the type of an expression *)
Check true.
Check (notb true).
Check (notb).

Inductive nat : Type :=
  | O : nat
  | S : nat -> nat.

Inductive nat' : Type :=
   | stop : nat'
   | tick : nat' -> nat'.

Definition pred (n : nat) : nat :=
  match n with
    | O    => O
    | S n' => n'
  end.

End NatPlayground.

Definition minustwo (n : nat) : nat :=
  match n with
    | O => O
    | S O => O
    | S (S n') => n'
  end.

Check (S (S (S (S (S O))))).
Check S.
Check pred.

Compute (minustwo 4).

Fixpoint evenb (n:nat) : bool :=
  match n with
  | O => true
  | S O => false
  | S (S n') => evenb n'
  end.

Definition oddb (n:nat) : bool := negb (evenb n).

Example test_oddb: oddb 1 = true.
Proof. simpl. reflexivity. Qed.
Example test_oddb1: oddb 4 = false.
Proof. simpl. reflexivity. Qed.

Module NatPlayground2.

Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
    | O => m
    | S n' => S (plus n' m)
  end.

Compute (plus 3 2).

Fixpoint mult (n m : nat) : nat :=
  match n with
    | O => O
    | S n' => plus m (mult n' m)
  end.

Example test_mult1: (mult 3 3) = 9.
Proof. simpl. reflexivity. Qed.

Fixpoint minus (n m : nat) : nat :=
  match n, m with
  | O, _ => O
  | S _, O => n
  | S n', S m' => minus n' m'
  end.

End NatPlayground2.

Fixpoint exp (base power : nat) : nat :=
  match power with
  | O => S O
  | S p => mult base (exp base p)
  end.

Example test_exp: (exp 5 3) = 125.
Proof. simpl. reflexivity. Qed.

(* Exercise: factorial *)
Fixpoint factorial (n : nat) : nat :=
  match n with
  | O => S O
  | S n' => mult n (factorial n')
  end.

Example test_factorial1: (factorial 3) = 6.
Proof. simpl. reflexivity. Qed.
Example test_factorial2: (factorial 5) = (mult 10 12).
Proof. simpl. reflexivity. Qed.

Notation "x + y" := (plus x y)
                      (at level 50, left associativity)
                      : nat_scope.

Notation "x - y" := (minus x y)
                      (at level 50, left associativity)
                      : nat_scope.

Notation "x * y" := (mult x y)
                      (at level 40, left associativity)
                      : nat_scope.

Check ((0 + 1) + 1).

Fixpoint beq_nat (n m : nat) : bool :=
  match n with
  | O => match m with
         | O => true
         | S _ => false
         end
  | S n' => match m with
            | O => false
            | S m' => beq_nat n' m'
            end
  end.

Fixpoint leb (n m : nat) : bool :=
  match n with
  | O => true
  | S n' => match m with
            | O => false
            | S m' => leb n' m'
            end
  end.

(* Exercise: blt_nat *)
Definition blt_nat (n m : nat) : bool := negb (leb m n).

Example test_blt_nat1: (blt_nat 2 2) = false.
Proof. simpl. reflexivity. Qed.
Example test_blt_nat2: (blt_nat 2 4) = true.
Proof. simpl. reflexivity. Qed.
Example test_blt_nat3: (blt_nat 4 2) = false.
Proof. simpl. reflexivity. Qed.

Theorem plus_O_n : forall n : nat, 0 + n = n.
Proof.
  intros n. simpl. reflexivity. Qed.

Theorem plus_1_l: forall n : nat, 1 + n = S n.
Proof.
  intros n. simpl. reflexivity. Qed.

Theorem mult_O_l : forall n : nat, 0 * n = 0.
Proof.
  intros n. simpl. reflexivity. Qed.

Theorem plus_id_example : forall n m : nat,
  n = m -> n + n = m + m.
Proof.
  intros n m.
  intros H.
  rewrite -> H.
  reflexivity. Qed.

(* Exercise *)
Theorem plus_id_exercise: forall n m o : nat,
  n = m -> m = o -> n + m = m + o.
Proof.
  intros n m o.
  intros H G.
  rewrite -> H.
  rewrite <- G.
  reflexivity. Qed.

Theorem mult_O_plus: forall n m : nat,
  (0 + n) * m = n * m.
Proof.
  intros n m.
  rewrite -> plus_O_n.
  reflexivity. Qed.

(* Exercise *)
Theorem Sn_m_minus_one : forall n m : nat,
  m = S n -> m = 1 + n.
Proof.
  intros m n.
  intros H.
  rewrite -> H.
  reflexivity. Qed.

Theorem mult_S_1 : forall n m: nat,
  m = S n -> m * (1 + n) = m * m.
Proof.
  intros m n.
  intros H.
  rewrite -> H.
  reflexivity. Qed.

Theorem plus_1_neq_0_firsttry : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros n. destruct n as [| n'].
  - reflexivity.
  - reflexivity. Qed.

Theorem negb_involutive : forall b : bool,
  negb (negb b) = b.
Proof.
  intros b. destruct b.
  - reflexivity.
  - reflexivity. Qed.

Theorem andb_commutative : forall b c,
  andb b c = andb c b.
Proof.
  intros b c. destruct b.
  - destruct c.
    + reflexivity.
    + reflexivity.
  - destruct c.
    + reflexivity.
    + reflexivity.
Qed.

Theorem andb3_exchange: forall b c d,
  andb (andb b c) d = andb (andb b d) c.
Proof.
  intros b c d. destruct b.
  - destruct c.
    { destruct d.
      - reflexivity.
      - reflexivity. }
    { destruct d.
      - reflexivity.
      - reflexivity. }
  - destruct c.
    { destruct d.
      - reflexivity.
      - reflexivity. }
    { destruct d.
        - reflexivity.
        - reflexivity. }
Qed.

(*Exercise andb_true_elim2*)

Theorem andb_true_elim2: forall b c : bool,
  andb b c = true -> c = true.
Proof.
  intros [] [].
  - intros []. reflexivity.
  - intros []. reflexivity.
  - intros []. reflexivity.
  - intros []. reflexivity.
Qed.

(*Exercise zero_nbeq_plus_1*)

Theorem zero_nbeq_plus_1 : forall n : nat,
  beq_nat 0 (n + 1) = false.
Proof.
  intros [|n'].
  - reflexivity.
  - reflexivity.
Qed.

(*Exercise starsM*)
Theorem identity_fn_applied_twice :
  forall (f : bool -> bool),
    (forall (x : bool), f x = x) ->
    forall (b : bool), f (f b) = b.
Proof.
  intros f H b.
  rewrite -> H.
  rewrite <- H.
  reflexivity.
Qed.

Theorem negation_fn_applied_twice :
  forall (f : bool -> bool),
    (forall (x : bool), f x = negb x) ->
    forall (b : bool), f (f b) = b.
Proof.
  intros f H [].
  - rewrite -> H.
    rewrite -> H.
    reflexivity.
  - rewrite -> H.
    rewrite -> H.
    reflexivity.
Qed.

(*Exercise andb_eq_orb*)
Theorem true_or :
  forall (b : bool),
    (orb true b) = true.
Proof.
  intros [].
  - reflexivity.
  - reflexivity. 
Qed.

Theorem true_and :
  forall (b : bool), (andb true b = true) -> (b = true).
Proof.
  intros b H.
  rewrite <- H.
  simpl. reflexivity.
Qed.

Theorem andb_eq_orb :
  forall (b c : bool),
  (andb b c = orb b c) ->
  b = c.
Proof.
  intros [].
  - simpl.
    intros c H.
    rewrite <- H.
    reflexivity.
  - simpl.
    intros c H.
    rewrite <- H.
    reflexivity.
Qed.

(*Exercise binary*)
Inductive bin : Type :=
  | Z  : bin
  | T  : bin -> bin
  | ST : bin -> bin.

Fixpoint incr (n : bin) : bin :=
  match n with
  | Z => ST Z
  | T n' => ST n'
  | ST n' => T (incr n')
  end.

Fixpoint bin_to_nat (n : bin) : nat :=
  match n with
  | Z => O
  | T n' => 2 * (bin_to_nat n')
  | ST n' => 2 * (bin_to_nat n') + 1
  end.

Example test_bin_incr1: (bin_to_nat (incr Z)) = 1.
Proof. simpl. reflexivity. Qed.

Example test_bin_incr2: (bin_to_nat (incr (T (ST Z)))) = 3.
Proof. simpl. reflexivity. Qed.

Example test_bin_incr3: ((bin_to_nat (T (ST Z))) + 1) = 3.
Proof. simpl. reflexivity. Qed.

Example test_bin_incr4: ((bin_to_nat (T (ST (ST Z))) + 1)) = 7.
Proof. simpl. reflexivity. Qed.

Example test_bin_incr5: (bin_to_nat (incr (ST (ST (ST (ST Z)))))) = 16.
Proof. simpl. reflexivity. Qed.

(*Exercise decreasing*)
Definition minus_1 (n : nat) : nat :=
  match n with
  | O => O
  | S n => n
  end.

Example minus_1_from_3 : (minus_1 3) = 2.
Proof. simpl. reflexivity. Qed.

Fixpoint fib (n : nat) : nat :=
  match n with
  | O => 1
  | 1 => 1
  | S n' => fib (n') + fib (n' - 1)
  end.

Example fib_test: (fib 3) = 3.
Proof. simpl. reflexivity. Qed.

Example neg_nat: 10 - 100 = 0.
Proof. simpl. reflexivity. Qed.
(* Fixpoint f (n : nat) : nat := *)
  (* match n with *)
  (* | O => 1 *)
  (* | S n' => f (n' * 2 - n' * 100) *)
  (* end. *)
