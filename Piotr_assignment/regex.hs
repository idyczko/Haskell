-- This file contains my courageous attempt to solve my fellow Piotr's assignment.
-- For a priori defined reference regex [0-9][0-9|A-E](5)[0-9] one has to decide whether
-- user's regex has non-empty intersection with reference regex. User may only use asterisk,
-- as indication for 0 or more characters of any kind.

-- For our reference regex, allowed characters are defined by two sets:
reference_regex_num = ['0'..'9'] :: String
reference_regex_alpha = reference_regex_num ++ ['A'..'E'] :: String


-- Approach: let us use some of  Constraint Programming paradigm here: for each out of user-specified
-- non-asterisk characters we create domain of possible positions.

-- Let's consider some specific example:
user_unformatted_regex = "***1***E2**2*8*" :: String

-- At first it is worth considering, that multiple consecutive asterisks represent the same
-- operation as single asterisk. Therefore we may substitute them with single asterisk:
remove_multiple_asterisks ::  String -> String
remove_multiple_asterisks [] = []
remove_multiple_asterisks (x:xs)
   | null xs = x : []
   | (x == '*') && ((head xs) == '*') = remove_multiple_asterisks xs
   | otherwise = x : remove_multiple_asterisks xs

user_regex = remove_multiple_asterisks user_unformatted_regex


-- As we see above, there are 5 non-asterisk characters in our regex:
c_1 = '1' :: Char
c_2 = 'E' :: Char
c_3 = '2' :: Char
c_4 = '2' :: Char
c_5 = '8' :: Char
characters = [x | x <- user_regex, x /= '*']

-- Also, note, that when there are more than 7 such non-asterisk characters, then the intersection
-- is empty, as there is no possibility to match regular expression.

-- The intersection is empty also when there is any character not allowed by reference regex in the
-- user defined regex.

-- The listed above 5 characters correlate with 5 decision variables, indicating positions.
-- The initial domains of those 5 decision variables will be:
initial_domains = replicate (length characters) [1..7]
-- as every character can be placed in one of 7 places.

-- Now let us state some constraints:
-- 1. Characters from set regex_num can stand on any position, as regex_num is subset of
-- regex_alpha. From this constraint we derive nothing.


-- 2. Characters from set exclusion regex_alpha\regex_num (letters A-E) can only be placed on
-- positions 2-6.
-- The two above cases may be covered by domain reducing function:
allowed_characters_reduction c
 | c `elem` reference_regex_num = [1..7]
 | c `elem` reference_regex_alpha = [2..6]
 | otherwise = []
 
reduced_domains_1 = [allowed_characters_reduction x | x <- characters]

--Propagation of these constraints will cause reduction of domain of variable
-- x_2 to [2..6]

-- 3. Characters defined by user come one after another in string, from which we would delete
-- asterisks. Domains have to respect that order. Therefore for 2 characters c_i and c_(i+1)
-- the condition holds: x_i<x_(i+1)
   
arc_consistency :: ([Int], [Int], [Int] -> [Int] -> ([Int], [Int])) -> ([Int], [Int])
arc_consistency (domain1, domain2, constraint) = constraint domain1 domain2

-- 4. Characters, which stand in user's regex on positions directly succeeding asterisk character
-- on position n can only be placed on positions [n..7].

AC3 algorithm
