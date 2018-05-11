type Bird = Int
type Pole = (Bird, Bird)

left :: Pole -> Bird
left (l, _) = l

leftPole :: Bird -> Pole -> Maybe Pole
leftPole b (l, r) = let diff = 3 in if l + b <= r + diff then Just (l + b, r) else Nothing

rightPole :: Bird -> Pole -> Maybe Pole
rightPole b (l, r) = let diff = 3 in if r + b <= l + diff then Just (l, r + b) else Nothing

-- Functor < Applicative Functor < Monad

-- Maybe is a functor, so it supports fmap function.
-- A functor represents a computational context.
-- Maybe represents context with possible computation failure.
l = fmap left (Just (12, 0)) -- 12

-- Applicative functor supports two additional operations: pure and <*> operator.
-- "pure" simply wraps a value into functor. For Maybe it might look like this:
mayP = pure 10 :: Maybe Int -- Just 10
-- so for Maybe pure = Just

-- <*> operator is just like fmap, except it retrieves initial function from a computational context (functor).
maPT = Just (\x -> show (x + 10) ++ "!") <*> Just 10 -- Just "20!"
-- What's really important is considering the computational context in every moment of computations.
-- In the example of Maybe Applicative Functor, when there is a Nothing value
--anywhere in the way, whole computation has to be evaluated to Nothing.
nut = Nothing <*> Just 10 -- Nothing
nut_2 = Just (\x -> show (x + 10) ++ "!") <*> Nothing -- Nothing

-- Thanks to curried functions and the partial application you can chain the
-- operations on applicatice functors:
val = pure (+) <*> Just 3 <*> Just 4 -- Just 7
-- applicative law: pure f <*> x = fmap f x
val_2 = fmap (*) (Just 2) <*> (Just 4) -- Just 8
-- Haskell therefore exports <$> operator, which is a infix fmap
val_3 = (+) <$> (Just 2) <*> (Just 4) -- Just 6

-- List type constructor [] is also an applicative functor:
tab = [(*2), (+1), ((-)4)] <*> [1..5]
-- for [] fs <*> xs = [f x | f <- fs, x <- xs]


routine :: Maybe Pole
routine = do
  start <- return (0, 0)
  first <- leftPole 2 start
  second <- rightPole 4 first
  leftPole 10 second


main = do
  start <- getLine
  putStrLn $ reverse start
