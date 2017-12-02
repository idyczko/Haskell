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
-- sum, product - also list functions

-- Ranges
r_1 = ['A'..'z']
r_2 = [1..10] -- Ranges are basically just a list (instead [1,2,3,4,5,6,7,8,9,10])
r_3 = [1,3..10] -- Range with defined step
r_4 = [0,0.1..5] -- As always - some errors caused by representation of floating point numbers - use with precaution!

-- Infinite list
rpt = repeat 4 -- Infinite list of fours [4,4,4,4,4...]
rpt_2 = take 10 rpt -- List of ten fours
rpct = replicate 3 10 -- List of three tens [10,10,10]

-- List comprehension
someComplicatedFunction tab threshold= [(2*x)^2|x<-tab, x>threshold] -- list comprehensions are cool!
removeOdds tab = [x | x<-tab, not (odd x)] -- there is also "even"
removeCapitals str = [x | x<-str, not (x `elem` ['A'..'Z']), x /= ' '] -- you can define multiple predicates! And yeah - did you remember string is just list of characters?
length' tab = sum [1|_<-tab] -- _ means we don't care about specific elements - only think of table as a whole!
removeEvens tab = [[x | x<-y, not (even x)]|y<-tab]

-- Tuples - tuples are data structures that allow storing values of different types - they are not homogenous and they are of fixed length! tuple and triple are two different things
tup = (12, "asdasd")
first = fst tup -- first will be equal to 12
second = snd tup -- yeah, you've guessed it - "asdasd"
-- as tuple and triple are values of different types Haskell will not allow a list like this one: [(1,2), (1,2,3), (1,2)]
equalTuples = (1,2,3) == (1,2,3) -- will be evaluated to true

-- Creating pairs from lists:
zipped = zip [1..] "Some bullshit" -- It just cuts the longer list off

-- Extracting data from tuple:
third (_,_,c,_) = c

-- A cool list comprehension+triples assignment: which right triangle that has integers for all sides and all sides equal to or smaller than 10 has a perimeter of 24?
triples = [(a,b,c)|a<-[1..10], b<-[1..10], c<-[1..10], c>b, b>a, a+b+c==24, a^2+b^2==c^2]

-- Way smarter!
triples' = [(a,b,c)|c<-[1..10], b<-[1..c], a<-[1..b], a+b+c==24, a^2+b^2==c^2]
