module Exercises_1

data TakeN : List a -> Type where
     Fewer : TakeN xs
     Exact : (n_xs : List a) -> TakeN (n_xs ++ rest)

-- 1
takeN : (n : Nat) -> (xs : List a) -> TakeN xs
takeN Z _ = Exact []
takeN (S k) [] = Fewer
takeN (S k) (x :: xs) with (takeN k xs)
  takeN (S k) (x :: xs) | Fewer = Fewer
  takeN (S k) (x :: (n_xs ++ rest)) | (Exact n_xs) = Exact (x :: n_xs)


groupByN : (n : Nat) -> (xs : List a) -> List (List a)
groupByN n xs with (takeN n xs)
  groupByN n xs | Fewer = [xs]
  groupByN n (n_xs ++ rest) | (Exact n_xs) = n_xs :: groupByN n rest


-- 2
halves : List a -> (List a, List a)
halves input with (takeN (div (length input) 2) input)
  halves input | Fewer = (input, [])
  halves (n_xs ++ rest) | (Exact n_xs) = (n_xs, rest)
