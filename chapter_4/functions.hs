-- Cheesy quicksort :) it is beautiful though :)
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = let smaller = [a | a <- xs, a <= x]; bigger = [a | a <- xs, a > x] in quicksort smaller ++ [x] ++ quicksort bigger

-- And "elem'":
elem' :: (Eq a) => a -> [a] -> Bool
a `elem'` [] = False -- Yep, we can also define function as infix.
a `elem'` (x:xs)
   | a == x = True
   | otherwise = a `elem'` xs
   
-- Maximum of elements
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "The given list is empty"
maximum' [x] = x
maximum' (x:xs) = max' x (maximum' xs)
       where max' a b
                | a < b = b
                | otherwise = a

-- Replication of an element
replicate' :: Int -> a -> [a]
replicate' n x
           | n <= 0 = []
           | otherwise = x : replicate' (n-1) x

-- Repeat
repeat' :: a -> [a]
repeat' x = x : repeat' x

-- Take
take' :: Int -> [a] -> [a]
take' _ [] = []
take' n (x:xs)
        | n <= 0 = []
        | otherwise = x : (take' (n-1) xs)


-- Any 
any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = f x || any f xs

-- Primality test with function composition (.) and late function application ($)
prime' :: Integer -> Bool
prime' x =  not $ any' ((==0) . (x `mod`)) [pos | pos<-[2.. floor $ sqrt $ fromIntegral x]]