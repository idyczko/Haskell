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


getValue :: Tree a -> Maybe a
getValue EmptyTree = Nothing
getValue (Node x _ _) = Just x

findNodeInTree :: (Ord a, Eq a) => a -> Tree a -> Tree a
findNodeInTree x EmptyTree = EmptyTree
findNodeInTree x tree@(Node y left right)
              | x == y = tree
              | x < y = findNodeInTree x left
              | x > y = findNodeInTree x right

findInTree :: (Ord a, Eq a) => a -> Tree a -> Maybe a
findInTree x tree = getValue $ findNodeInTree x tree

numbers = [3,231,5,2,12,3,13,1,2123,1,33,12,23,123,6,3451,3,51,67,6,27]
newTree = foldr insertValue EmptyTree numbers

inOrderTraversal :: (Show a, Eq a) => Tree a -> [Maybe a]
inOrderTraversal EmptyTree = [Nothing]
inOrderTraversal (Node x left right) = filter (/=Nothing) ((inOrderTraversal left) ++ [Just x] ++ (inOrderTraversal right))


inOrderTraversal' :: (Show a, Eq a) => Tree a -> [Maybe a]
inOrderTraversal' EmptyTree = [Nothing]
inOrderTraversal' (Node x left right) = filter (/=Nothing) ([Just x] ++ (inOrderTraversal left) ++ (inOrderTraversal right))

reversedOrderTraversal :: (Show a, Eq a) => Tree a -> [Maybe a]
reversedOrderTraversal = reverse . inOrderTraversal

inverseBinaryTree :: Tree a -> Tree a
inverseBinaryTree EmptyTree = EmptyTree
inverseBinaryTree (Node x l r) = Node x (inverseBinaryTree r) (inverseBinaryTree l)

getChildren :: Tree a -> [Maybe a]
getChildren EmptyTree = [Nothing]
getChildren (Node x left right) = [getValue left, getValue right]

getChildren' :: [Tree a] -> [Maybe a]
getChildren' (x:xs) = (getChildren x) ++ (getChildren' xs)

--breadthFirstSearch :: Tree a ->

-- Typeclasses 102
{-
instance (Show a) => Show (Tree a) where
  show EmptyTree = ""
  show (Node x left right) = show x
-}
