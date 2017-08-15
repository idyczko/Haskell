-- Pattern matching

lucky :: (Integral a) => a -> String
lucky 7 = "You got lucky!"
lucky x = if abs ((-) 7 x) == 1 then "Almost!" else "Meh... Not even close" -- "Catch all" pattern
-- "If" is expression, therefore it has to return some value. As is function! When considering immutable state,
-- function without return value makes no sense!
-- Patterns will always be checked from top to the bottom!

-- Remember "factorial' n = product [1..n]" function? Check out this recursion utilizing pattern matching:
factorial'' :: (Integral a) => a -> a
factorial'' 0 = 1
factorial'' x = x * factorial'' (x - 1)

-- Beware of non-exhaustive patterns:
someNumber :: (Integral a) => a -> a
someNumber 1 = 1
someNumber 2 = 2
-- No pattern that would match other inputs technically allowed by function signature

-- Pattern matching on tuples:
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) -- As opposed to "addVectors v1 v2 = (fst v1 + fst v2, snd v1 + snd v2)"

-- Extracting values from triples using pattern matching:
first :: (a, b, c) -> a
first (a, _, _) = a  -- Again, "_" means we do not care of what stands on those positions

-- Pattern matching in list comprehensions:
zippy :: (Num a) => [(a, a)] -> [a]
zippy listOfDoubles = [a + b | (a, b) <- listOfDoubles]

-- Pattern matching on lists (String):
nameJudge :: String -> String
nameJudge "Igor" = "That is some cool name!"
nameJudge "Bob" = "Nice one!"
nameJudge name = "Seen better..."

-- Not String:
head' :: [a] -> a
head' [] = error "The list is empty!"
head' (x:_) = x

-- Some cool example:
tell :: (Show a) => [a] -> String
tell [] = "The list is empty!"
tell (x:[]) = "The list has a single element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ "and" ++ show y
tell [x,y,z] = "The list has three elements!"
tell (x:y:z:_) = "The list has maaaany elements!"

-- Maybe a brand new length function?
length' :: [a] -> Int
length' [] = 0 -- Edge condition
length' (_:xs) = 1 + length' xs

-- Sum
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- "AS PATTERNS" (those with @) - breaking some value to parts, while still having the whole thing:
letterCount :: String -> String
letterCount [] = "There are no letters in given String"
letterCount wholeString@(x:xs) = "There are "++ show (length' [x|x<-wholeString, x/=' ']) ++ " letters in \"" ++ wholeString ++ "\""