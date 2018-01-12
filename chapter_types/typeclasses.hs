-- Typeclasses 102
data Point = Point Float Float

instance Show Point where
  show (Point x y) = "(" ++ (show x) ++ ", " ++ (show y) ++ ")"


-- yes-no Typeclass:

class YesNo a where
  yesno :: a -> Bool

instance YesNo Bool where
  yesno = id

instance YesNo [a] where
  yesno [] = False
  yesno _ = True

{-
This is illegal due to indistinct variable type:
instance YesNo [Char] where
  yesno [] = False
  yesno _ = True
-}
