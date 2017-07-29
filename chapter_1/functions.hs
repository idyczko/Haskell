-- :t is an operator for checking variable's type
a = 2 + 2 -- Infix function + type inference
ab = (+) 2 2 -- Infix function as prefix function
b = 10 `div` 5 -- Prefix function used as infix function
c = div 10 5 -- Prefix function
x = not False
-- x = False - multiple declaration - not allowed in functional programming.
y = x /= True
d = succ 9 `div` pred 3 -- Successor and predecessor functions
e =	max 10 (min 12 2) -- Minimum and maximum functions
tenOrGreater = max 10 -- Used specific of curried functions - each function in Haskell indeed has only one parameter (multiple parameters are applied one by one) (#partial_application)
less = tenOrGreater 9 -- less will be equal to 10
greater = tenOrGreater 11 -- greater will be equal to 11
f = 19.12  -- Some floating point value
doubleMe x = x*2 -- Function for doubling a number (no explicit type declaration so far)

-- If statement is actually a EXPRESSION in Haskell. It means, that it must return a value, therefore "else" part is mandatory
i = if x then 5 else 10;
s = "Some freakin' string" -- Some string value - as always, the string is just a syntactic sugar on table of characters, therefore:
z = "hello" == ['h', 'e', 'l', 'l', 'o'] -- will be true
t = [1,2,3,4] -- Some table
t_2 = take 3 t -- t_2 will be [1,2,3] - "take" takes the first elements of 
-- t_3 = [1, 2, 3, 'c', 3.12] is not possible, as the lists in Haskell are homogenous (here 'c' is the problem, as integers can be easily cast to floating point numbers)
t_4 = t ++ t_2 -- "++" operator is concatenation of lists - we append "t_2" to "t". Be careful though, as appending requires cycling through whole t list
t_5 = 5 : t_4 -- ":" operator appends an element to begining of the list - it doesn't necessarily have to go through all elements.
-- It is worth stating, that: [1,2,3] is synctactic sugar for 1:2:3:[].
-- Creating cycle (infinite sequence) based on table:
cyc = cycle [1,2,3]
cyc_1 =  take 10 cyc -- cyc_1 will be [1,2,3,1,2,3,1,2,3,1]
-- At this time it would be worth mentioning of laziness of Haskell - it doesn't resolve (calculate) the value of an variable if it is not needed for further computations
-- (in terms of places, where its value needs to be calculated).
-- Hence, the statement:
l = length (cycle  [1,2,3])
-- won't cause any troubles, but the line beneath, trying to calculate the length of infinite sequence by iterating through all its elements and printing it to standard output stream:
-- show l -- will cause program hanging. Forcing resolution of any variable bund to variable "l" will cause failure to be precise.
el = t !! 2 -- taking second element of t (elements are enumerated from 0!!!)
is_el = elem 4 t -- checking if 4 is an element of t
lexic = [1,2,3] > [2,0,0] -- lists can be compared with standard boolean operators if the elements in those lists can be compared (they will be compared in lexicographic order)
a_1 = head t -- first element
a_2 = last t -- last element
a_3 = init t -- all elements except from last
a_4 = tail t -- all elements except from first
a_5 = null t -- checks if list is empty
t_r = reverse t -- reverses table
t_d = drop 3 t -- drops 3 first elements of a table (can be more than size - length (take 100 [1,2,3]) will return 3)
minmax = minimum t == maximum t -- functions for finding minimal and maximal elements
-- sum, product functions
-- Ranges
r_1 = ['A'..'z']
r_2 = [1..10] -- Ranges are basically just a list (instead [1,2,3,4,5,6,7,8,9,10])
r_3 = [1,3..10] -- Range with defined step