fizzbuzz :: Int -> Int -> [Int] -> [String]
fizzbuzz _ _ [] = []
fizzbuzz f b (x:xs)
    | fizz && x `mod` b == 0 = "FizzBuzz" : rest
    | fizz = "Fizz" : rest
    | buzz = "Buzz" : rest
    | otherwise = show x : rest
     where fizz = x `mod` f == 0
           buzz = x `mod` b == 0
           rest = fizzbuzz f b xs