encrypt :: [String] -> String
encrypt [] = error "You were supposed to provide some data, you know..."
encrypt (x:xs) =

pad_char :: Char -> Char -> Char
pad_char x y =

pad :: String -> String -> String
pad x y = if length x > length y then

find :: a -> [a] -> Int
find e tab = [ |i <- [0.. (length tab - 1)]]
