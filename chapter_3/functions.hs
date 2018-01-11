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

-- Some cool pattern matching on strings:
initials :: String -> String -> String
initials (f:_) (l:_) = [f] ++ "." ++ [l] ++ "."

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

-- Without a function:
(newHead:newTail) = "Some freakin' string"

-- Some cool example:
tell :: (Show a) => [a] -> String
tell [] = "The list is empty!"
tell (x:[]) = "The list has a single element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ "and" ++ show y
tell [x,y,z] = "The list has three elements!" -- Notice, that the brackets may be omitted, as [x,y,z] is syntactic sugar for x:y:z:[]
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
letterCount wholeString@(x:xs) = "There are "++ show (length' [x |x<-wholeString, x/=' ']) ++ " letters in \"" ++ wholeString ++ "\""

-- GUARDS
tellMeIQ :: Int -> String
tellMeIQ iq
   | iq < 50 = "Maybe you should see a doctor..."
   | iq < 100 = "You are not the worst! Yay!"
   | iq < 150 = "Whoa, nice one!"
   | iq < 200 = "Albert, is that you?"
   | otherwise = "AGI implemented, we are doomed..."

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
   | bmi <= skinny = "You are skinny!"
   | bmi <= normal = "You are normal!"
   | bmi <= fatty = "You are fat!"
   | otherwise = "Whale!"
    where bmi = weight / height ^ 2 -- Where clause... Cool, eh? It is not expression though! Weak!
          (skinny, normal, fatty) = (18.5, 25.0, 30.0)

-- You can use it in normal function!
max' a b = x where x = max a b

-- Let expression (it always returns a value - EXPRESSION!):
someVariable = let x = 10 -- Remember of spaces! Pain in the ass!
                   y = 20
                   z = 30
               in x * y + z

-- Let expression can also be used to define functions in local scope:
someList = let square' x = x * x; predicate = odd in [square' x | x <- [1,4..41], predicate x] -- Take a glance at separating multiple bidnings inline

-- Let expression can be used in list comprehension (we then ommit "in" part):
someComprehendedList = [pred | x <- [1..100], let pred = even x, pred] -- pred has local scope and is only known in part before "|" and succeding predicates.

-- Local function and multiple bindings with semicolon separating.
someTriple = [let square x = x * x; five = 5 in (square 3, square 4, square five)]

-- Why not use let... in.. all the time? Because of local scope - we cannot reuse it across pattern matching in function definitions as we did in guards and where bindings.

--CASE expressions
-- Pattern matching for function definitions is only syntactic sugar for case expressions:
head'' :: [a] -> a
head'' [] = error "Well, you know what's screwed up..."
head'' (h:_) = h

head''' :: [a] -> a
head''' xs = case xs of [] -> error "Damn..."
                        (x:_) -> x

-- The two upper functions are interchangeable. First one is prettier though. Case expressions are cool, becaues they allow us to match patterns in the middle of expressions.


-- Let's do some folding:
factorial''' x = foldl1 (*) [1..x]
factorial'''' x = foldr1 (*) [1..x]
factorial''''' x = foldr (*) 1 [1..x]
factorial'''''' x = foldl (*) 1 [1..x]

s = ["S", "t", "r"]
s1 = foldr (++) "a" s -- s1 == "Stra"
s2 = foldl (++) "a" s -- s2 == "aStr"

tr = foldl1 (-) [1..10] == -53 -- Strange, isn't it? :)
-- ((((((((1 - 2) - 3) - 4) - 5) - 6) - 7) - 8) - 9) - 10
tr2 = foldr1 (-) [1..10] == -5 -- Bazinga.
    -- 1 - (2 - (3 - (4 - (5 - (6 - (7 - (8 - (9 - 10))))))))

intSum :: Int -> Int -> Int
intSum x y = x + y


fun num str  = ((++) . show . (!!)abc . (`mod`(length abc))) num str where abc = ['a'..'z']
fun' str num = fun num str

someStr = foldr fun "postfix" [1..10] -- starting with 'b'
someOtherStr = foldl fun' "postfix" [1..10] -- starting with 'k'
