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
2.  

-   
-   

### Day 8

1.  
2.  

-   
-   


