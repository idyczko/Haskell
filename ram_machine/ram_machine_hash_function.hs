import Data.List
import Data.Maybe

instructions = ["READ", "STORE", "LOAD", "ADD", "SUB", "HALF", "JUMP", "JPOS", "JZERO", "JNEG", "HALT"];

hashInstruction :: String -> Int
hashInstruction [] = 0
hashInstruction (x:xs) = charValue x + hashInstruction xs
                  where charValue c = (*2) $ fromMaybe (-1) $ elemIndex c ['A'..'Z']

main = do
  let indices = map ((`mod` 11) . hashInstruction) instructions
  putStrLn $ show indices
