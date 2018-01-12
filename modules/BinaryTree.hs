module BinaryTree
( BinaryTree(..)
, singleton
, insertValue
, getValue
, findNode
) where

  data BinaryTree a = EmptyBinaryTree | BinaryTreeNode a (BinaryTree a) (BinaryTree a) deriving (Show, Read, Eq)
  -- Notice how it is actually a type constructor and not value constructor, as

  singleton :: (Ord a, Eq a) => a -> BinaryTree a
  singleton x = BinaryTreeNode x EmptyBinaryTree EmptyBinaryTree

  insertValue :: (Ord a, Eq a) => a -> BinaryTree a -> BinaryTree a
  insertValue x EmptyBinaryTree = singleton x
  insertValue x (BinaryTreeNode y left right)
                | x == y = BinaryTreeNode x left right
                | x < y = BinaryTreeNode y (insertValue x left) right
                | x > y = BinaryTreeNode y left (insertValue x right)

  {-
  findInTree :: (Ord a, Eq a) => a -> Tree a -> Maybe a
  findInTree x EmptyBinaryTree = Nothing
  findInTree x (BinaryTreeNode n left right) = if x == n then Just n else
                                          if x < n then findInTree x left else findInTree x right
  -}


  getValue :: BinaryTree a -> Maybe a
  getValue EmptyBinaryTree = Nothing
  getValue (BinaryTreeNode x _ _) = Just x

  findNode :: (Ord a, Eq a) => a -> BinaryTree a -> BinaryTree a
  findNode x EmptyBinaryTree = EmptyBinaryTree
  findNode x tree@(BinaryTreeNode y left right)
                | x == y = tree
                | x < y = findNode x left
                | x > y = findNode x right
