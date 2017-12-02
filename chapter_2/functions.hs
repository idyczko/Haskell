-- The chapter's name is Types and Typeclasses
-- Haskell is strongly (statically) typed and has type inference.
-- We can however define types:
removeCaps :: [Char] -> [Char] -- type declaration (same as String -> String)
removeCaps str = [x | x<-str, not (x `elem` ['A'..'Z'])] -- Will remove caps

addThree :: Int -> Int -> Int -> Int -- there is no explicit distinction between parameters and output - do you recall curried functions? That's why!
addThree x y z = x + y + z

-- Remember, that functions are expressions too!!! They must return some value, as they do not have side effects! If they wouldn't return some value then what
-- is the point of using them after all? :D

-- Int is smaller but more efficient than Integer
factorial :: Int -> Int
factorial n = product [1..n] -- factorial 10 is ok, but factorial 320 is pure madness for Int! Use Integer, when working with big integers! Clever factorial btw!

-- Besides - as usual: Float, Double, Boolean and Char

-- In Haskell there are also type variables - when you care more about container than the elements themselves.
head' :: [a] -> a
head' tab = tab !! 0 -- Not quite safe, becaues we may land out of bounds, when empty list will be inserted!
-- Pattern matching (explained better in next chapter)!

x = 10.2 :: Double -- Explicitly defined type

head'' :: [a] -> a
head'' [] = error "Well, shit... The list was empty to begin with!" -- let's throw some error!
head'' (x:_) = x -- Much much better, isn't it? :>

fst' :: (a, b) -> a -- another example of how we don't give a damn about specific types.
fst' (a, _) = a;

-- Make it double!
circumference' :: Double -> Double
circumference' r = 2 * pi * r

-- Typeclasses are some sort of general types - interfaces if you will. "If a type is a part of typeclass, that means that it supports and implements the behaviour
-- the typeclass describes." - well said!
-- when using :t operator in GHCi everything that appears before '=>' operator is "class constraint" - it defines which Typeclass the referenced object has to be
-- derived from to enable usage of this operation.
-- Some of the Typeclasses:
-- Eq - enforces implementation of == and /= functions
f' :: String -> String -> String
f' a b = a ++ b
