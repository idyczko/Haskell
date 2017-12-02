import qualified Data.Map as Map

--Yet another cool type: Either - when there is more than one thing that could go wrong in our function
--data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)  -- this is how it's defined!
someRight = Right 20 :: Either String Int

data LockerState = Taken | Free deriving (Read, Show, Eq, Ord)
type Code = String
type LockerMap = Map.Map Int (Code, LockerState)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map = case Map.lookup lockerNumber map of
                                    Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " does not exist!"
                                    Just (code, state) -> if state /= Taken then Right code else Left $ "Locker number " ++ show lockerNumber ++ " is taken!"

lockers :: LockerMap
lockers = Map.fromList
    [(100,("ZD39I", Taken))
    ,(101,("JAH3I", Taken))
    ,(103,("IQSA9", Free))
    ,(105,("QOTSA", Taken))
    ,(109,("893JJ", Free))
    ,(110,("99292", Taken))
    ]
