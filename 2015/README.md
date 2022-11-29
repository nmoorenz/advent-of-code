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
2.  Six zeros

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

1.  
2.  

-   
-  

### Day 15

1.  
2.  

-   
-  

### Day 16

1.  
2.  

-   
-  

### Day 17

1.  
2.  

-   
-  

### Day 18

1.  
2.  

-   
-  

### Day 19

1.  
2.  

-   
-  

### Day 20

1.  
2.  

-   
-  

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

1.  
2.  

-   
-  

### Day 24

1.  
2.  

-   
-  

### Day 25

1.  
2.  

-   
-  

