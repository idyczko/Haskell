expression = "2 3 + 5 * 10 - 2 /" --7.5

calculate :: String -> Float
calculate = head . foldl foldingFunction [] . words
  where foldingFunction (x:y:xs) "+" = (x+y:xs)
        foldingFunction (x:y:xs) "*" = (x*y:xs)
        foldingFunction (x:y:xs) "-" = (y-x:xs)
        foldingFunction (x:y:xs) "/" = (y/x:xs)
        foldingFunction xs x = read x:xs

outcome = calculate expression