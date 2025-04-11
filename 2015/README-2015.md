## Advent of Code 2015

We're building a Christmas tree!

### Day 1

1.  Find the floor that Santa ends up on
2.  How many steps until Santa goes into the basement?

-   `string.count()` is perfect for this
-   This feels like a while loop but I might be wrong

### Day 2

1.  Calculate how much wrapping paper the elves need
2.  Calculate how much ribbon the elves need

-   A for loop helps me think through the steps more easily
-   I thought I could just use the smallest sides together but for some reason that doesn't work

### Day 3

1.  How many houses does Santa deliver presents to?
2.  How many houses does Santa plus Robo-Santa deliver presents to?

-   I thought a dictionary might be nice, but got the wrong answer, so tried lists. Somehow I read the question as how many houses receive multiple presents. Both approaches are possible and correct.
-   This one was awkward but that was only my doing.

### Day 4

1.  Let's do some cryptography with AdventCoins - find the hash with five zeros
2.  Six zeros, which is actually crypto 

-   `import hashlib`
-   `hashlib.md5('string'.encode('utf-8')).hexdigest()`
-   Maybe this could be a function with the length of zeros as an input

### Day 5

1.  How many strings are nice?
2.  How many strings are nice with some different rules?

-   This was reasonably simple with the help of some searching
-   Maybe I stumbled on to a good way of doing things but part two was no harder than part one

### Day 6

1.  After a series of on/off/toggle instructions, how many lights are lit?
2.  After the instructions have been revised, what is the overall brightness?

-   I learnt a little numpy for this, which is very nice
-   Maybe I didn't need to use regex for the instructions but that was what was in my brain after the day before
-   numpy was really good for this with array access

### Day 7

1.  For a number of bitwise operations, what signal is provided to wire 'a'?
2.  Change one if the inputs, and what is the signal to 'a' now?

-   Turns out that the signals are largely processed in order
-   This took many small tweaks to get right but ends up being nice for the second step
-   TODO: part two code does not work

### Day 8

1.  Find the difference between the string representation and the string itself (shorter)
2.  Find the difference between string representation and the encoded string (longer)

-   `eval()`
-   Count the number of `\` and `"` and add 2 for new quotes

### Day 9

1.  What is the shortest route for Santa?
2.  What is the longest route?

-   Thanks to Fillipe here <https://github.com/fillipe-gsm/python-tsp>
-   Part two takes a little thinking and adjustment
-   TODO: part two code does not work

### Day 10

1.  Look-and-say, expanding a sequence of numbers 40 times.
2.  50 times

-   I tried this out in google sheets to validate my approach, but O(n\^2) means too many cells
-   I made a function with number of iterations

### Day 11

1.  Find the next valid password, according to some weird rules.
2.  Find the next one after that

-   Functions for the checks, plus some string work, sets us up for success
-   The second time around takes longer, which is fascinating, how does the input work? 

### Day 12

1.  What is the sum of the numbers in the input? 
2.  Oops! Remove the dict with 'red' and then sum up the numbers

-   Good ol' regex helped with this one
-   This was tough to get my head around but I got there in the end with some recursion. 

### Day 13

1.  What is the optimal seating arrangement given some happiness scores? 
2.  What happens when you insert yourself? 

-   This is a two-sided TSP graph, so requires some manipulation to create a nice array
-   Adding a row and a column to a np array is simple enough

### Day 14

1.  In a reindeer race, with flying and resting, who runs the furthest in 2503 seconds? 
2.  In a points race, which reindeer earns the most points? 

-   Only one trick here is that the winning reindeer is flying when the time is up
-   Calculate the distance at each time step, then do some comparisons. Again, there's a trick: there might be ties

### Day 15

1.  For some combination of ingredients, how great can we make some cookies? 
2.  The cookies are now constrained by calories - how good can they be? 

-   I spent too long on data structures, and can only think to try `product` to get combinations of teaspoons
-   Part two is pretty similar, just with a restriction on the final variable. 

### Day 16

1.  There are too many Aunt Sue, find the right one by comparing incomplete information. 
2.  Some of that incomplete information was even more incomplete, giving less than or greater than figures. 

-   Create some nice data structures for comparison, then loop through the lists. 
-   Again loop through with slightly different conditions. Lucky that I can remember exactly 3 things about each Aunt Sue! 

### Day 17

1.  How many different combinations of containers do I need to store 150 litres of eggnog? 
2.  How many different combinations of the minimum amount of containers do I need? 

-   `itertools.combinations()` is right there in the description, pretty much. 
-   This was some trial and error to see how many is the minimum. 

### Day 18

1.  How many lights are on after a certain number of iterations, given the state of the surrounding lights at each step? 
2.  The corner lights are stuck on - what now? 

-   numpy arrays was always the choice here. 
-   Getting the array references right was tough but fair. I defaulted to using 1-based arrays
-   Setting the corner lights within the loop seemed like the simplest modification. 

### Day 19

1.  Find the distinct number of molecules when making replacements to a string of characters. 
2.  Starting from scratch (or one electron, e) how many steps to get to the medicine molecule? 

-   
-  

### Day 20

1.  Find the lowest house number which gets a number of presents when elves do some funky delivery
2.  Elves are only delivering to 50 houses, now where do we get to

-   Looping is bad because loops can take a long time. 
-   We should actually look at factors, since the deliveries work more like that. Stack Overflow!
-   Slightly modify the function for a limit of deliveries i.e. factors



### Day 21

1.  
2.  

-   
-   



### Day 22

1.  
2.  

-   
-   



### Day 23

1.  Collatz Number! If even, divide by 2, if odd, multiply by 3 and add 1. Eventually, get to 1. 
2.  Change the input and jump to a different set of instructions

-   I thought this looked familiar! It was easy to do in a spreadsheet to find the initial number then look up an online calculator to get the Collatz number. 
-   Code was weird, I had to go through a few times to make sure my logic was right, but we got there. 

### Day 24

1.  Find the distribution of packages, such that the smallest amount of packages weighs one third of the total
2.  Find a similar distribution, but with one fourth of the total weight. 

-   This was reasonably easy since there weren't a large number of combinations. `itertools.combinations()` does most of the work. 
-   I was really worried this would produce invalid combinations or more than one combination with the same product, but it really was just a simple extension of the first problem. 


### Day 25

1.  Calculate the sequence of numbers to provide the required number from the manual reference. 
2.  Do all the other days

-   I thought this might have been tricky but in the end just need to keep track of the position in the grid. 
-   Need to complete all the other puzzles to get the 50th star! 

