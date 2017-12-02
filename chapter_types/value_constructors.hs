-- data operator is responsible for creating new types:
data Point = Point Float Float deriving (Show, Read, Ord, Eq)
-- note how Point is a type with one value constructor
-- Show - lets us call constructorPoint for printing its value.
-- Read - reading from String to Point.
-- Ord - comparison.
-- Eq - == and /=
constructedPoint = Point 12 10 -- Creating point by constructor
readPoint = read "Point 100 10" :: Point -- Creating utilizing Read typeclass' interface

--You can create aliases for types: (be aware of differences between type and data!)
type Radius = Float

--Type can have multiple value constructors:
data Shape = Circle Point Radius | Rectangle Point Point deriving (Show, Read, Ord, Eq)

circle = Circle (Point 12 12) 15.5
circle_2 = Circle (Point 0 0) 10.1
rect = Rectangle (Point 0 0) (Point 1 1)
-- circle > rect -- Always false by default, because ordering of value constructors is taken
                -- into consideration here first!
-- circle > circle_2 --Hmmm... Let's see... True!

-- Let's do some pattern matching against value constructors:
surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (*) (abs $ (-) x1 x2) (abs $ (-) y1 y2)
-- Coooool :)

-- NOTE THAT NEITHER CIRLCE NOR RECTANGLE ARE NOT TYPES!!! SHAPE IS TYPE!!!

--Sooooo... How do we get some parameter of value?
getX :: Point -> Float
getX (Point x _) = x
--Imagine how it would have look like if we had type with 10 fields. We would
-- have to write such functions for each of them _ l _ a _ m _ e _ ...
--RECORD SYNTAX COMES to Rescue:
data Person = Person { firstName :: String
                      , lastName :: String
                      , age :: Int
                      } deriving (Show, Read)
person = Person {age=64, firstName="Tom",  lastName="Hagen"} -- We don't have to watch ordering anymore!
hagen = lastName person -- lastName becomes function Person -> String
