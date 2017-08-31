-- Cheesy quicksort :) it is beautiful though :)
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = let smaller = [a | a <- xs, a <= x]; bigger = [a | a <- xs, a > x] in (quicksort smaller) ++ [x] ++ (quicksort bigger)

-- And "elem'":
elem' :: (Eq a) => a -> [a] -> Bool
a `elem'` [] = False -- Yep, we can also define function as infix.
a `elem'` (x:xs)
   | a == x = True
   | otherwise = a `elem'` xs