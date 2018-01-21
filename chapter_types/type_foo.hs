func :: Int -> Char
func a = (alphabet!!(mod a (length alphabet))) where alphabet = ['A'..'Z']

--Functor typeclass requires type to be of kind * -> * (as Maybe is)
x = fmap func (Just 123) -- x == Just 'T'
--Functor describes types which can be mapped over (single value containers).
