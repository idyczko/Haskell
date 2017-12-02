--Type constructors are somehow similar to value constructors, only they produce types!!
mayInt = Just 5 :: Maybe Int

--Let's create some generic data type!
data Vector a = Vector a a a deriving (Read, Show, Eq, Ord)

integerVector = Vector 12 32 41 :: Vector Int

addVectors :: (Num a) => Vector a -> Vector a -> Vector a
addVectors (Vector x1 y1 z1) (Vector x2 y2 z2) = Vector (x1+x2) (y1+y2) (z1+z2)

compositeVec = addVectors integerVector (read "Vector 0 0 1") -- Note how explicit casting of outcome of read
                                                              -- is not necessary due to the fact, that its
                                                              -- type can be inferenced from operation.


--Enumerable types
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday deriving (Read, Show, Ord, Eq, Enum, Bounded)

monday = Monday
tuesday = succ monday
trueValue = (monday == (pred tuesday)) && ((maxBound :: Day) == Sunday) && (read "Monday" < Wednesday)

--Type synonyms
phoneBook = [("Rita", "997"), ("Tom", "112")]
-- :t phoneBook -> [([Char], [Char])]
type Name = String
type Number = String
type AssociationList k v = [Record k v] -- parametrized type synonym
type Record k v = (k, v)
type PhoneBook = [Record Name Number]

--Now function signature will look far better
findNumber :: PhoneBook -> Name -> Number
findNumber [] _ = error "Beep... Beep... Beep..."
findNumber (r:rs) n = if fst r == n then snd r else findNumber rs n
