-- Expression definition
data Expr = Val Int | Div Expr Expr

-- Not very safe eval function (NaN)
eval :: Expr -> Int
eval (Val i) = i
eval (Div a b) = eval a `div` eval b

--eval (Div (Val 1) (Val 0)) --Booom! Exception: Division by zero!

--Let's try the same with a Maybe monad
safediv :: Int -> Int -> Maybe Int
safediv n m = if m == 0 then Nothing else Just (n `div` m)

eval' :: Expr -> Maybe Int
eval' (Val i) = Just i
eval' (Div a b) = case eval' a of
                    Nothing -> Nothing
                    Just n -> case eval' b of
                                Nothing -> Nothing
                                Just m -> safediv n m

--Using sequence syntax with case analysis:
m >>= f = case m of
            Nothing -> Nothing
            Just x -> f x

eval'' :: Expr -> Maybe Int
eval'' (Val x) = return x -- side definition
eval'' (Div a b) = eval'' a Main.>>= (\n ->
                    eval'' b Main.>>= (\m ->
                      safediv n m))


--Even simpler with do notation:
eval''' :: Expr -> Maybe Int
eval''' (Val x) = return x
eval''' (Div a b) = do n <- eval''' a
                       m <- eval''' b
                       safediv n m
