-- Check out this beauty with delayed function application and composition and where bindings and all :)
cutInHalf :: [a] -> ([a], [a])
cutInHalf xs = (take (half xs) xs, drop (half xs) xs) where half = ceiling . (/2) . fromIntegral . length

-- How do you like my AS PATTERNS? :)
merge :: (Ord a) => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge xs@(x:tailXs) ys@(y:tailYs) = if x < y then x : merge tailXs ys else y : merge xs tailYs

mergesort :: (Ord a) => [a] -> [a]
mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (mergesort (firsthalf xs)) (mergesort (secondhalf xs))
                  where firsthalf = fst . cutInHalf
                        secondhalf = snd . cutInHalf
