-- You can simply define an infix operator by comprising it only from special
-- characters:
x ^- y = x*x - 2*x*y + y*y


-- You can also define priority of a custom operator:
(-^) = (^-)
infixr 1 ^-
x = 10 ^ 2 ^- 1 -- x = 9801

infixr 9 -^
y = 10 ^ 2 -^ 1 -- y = 10


-- Let us implement something cool - a binary search tree!

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)
-- Notice how it is actually a type constructor and not value constructor, as
-- it contains type parameter! Let's create some cool tree:
tree = Node 10 (Node 8 EmptyTree EmptyTree) (Node 20 EmptyTree EmptyTree)

singleton :: (Ord a, Eq a) => a -> Tree a
singleton x = Node x EmptyTree EmptyTree

insertValue :: (Ord a, Eq a) => a -> Tree a -> Tree a
insertValue x EmptyTree = singleton x
insertValue x (Node y left right)
              | x == y = Node x left right
              | x < y = Node y (insertValue x left) right
              | x > y = Node y left (insertValue x right)

{-
findInTree :: (Ord a, Eq a) => a -> Tree a -> Maybe a
findInTree x EmptyTree = Nothing
findInTree x (Node n left right) = if x == n then Just n else
                                        if x < n then findInTree x left else findInTree x right
-}
findInTree :: (Ord a, Eq a) => a -> Tree a -> Maybe a
findInTree x EmptyTree = Nothing
findInTree x (Node y left right)
              | x == y = Just y
              | x < y = findInTree x left
              | x > y = findInTree x right
