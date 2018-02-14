module Exercises

import Data.Vect

-- 1
||| Compute the length of a list.
my_length : List a -> Nat
my_length xs = length' xs 0
  where
    length' : List a -> Nat -> Nat
    length' [] k = k
    length' (x :: xs) k = length' xs (S k)

-- 2
||| Return the elements of a list in reverse order.
my_reverse : List a -> List a
my_reverse xs = reverse' xs []
  where
    reverse' : List a -> List a -> List a
    reverse' [] ys = ys
    reverse' (x :: xs) ys = reverse' xs (x :: ys)

-- 3
||| Apply a function across everything of type 'a' in a list.
my_map : (a -> b) -> List a -> List b
my_map f xs = map' xs
  where
    map' : List a -> List b
    map' [] = []
    map' (x :: xs) = f x :: map' xs

-- 4
||| Apply a function across everything of type 'a' in a Vect.
my_vect_map : (a -> b) -> Vect n a -> Vect n b
my_vect_map f xs = map' xs
  where
    map' : Vect n a -> Vect n b
    map' [] = []
    map' (x :: xs) = f x :: map' xs
