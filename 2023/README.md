## Advent of Code 2023

### Day 1

1.  Find the first and last digit in a string, combine them, sum them. 
2.  Some of the numbers are spelled out, so include them in your considerations. 

-   Regex is my first thought, but looking at the data, it looks like the second part is going to include the numbers that are spelled out, so let's try looping over strings. 
-   Correct - I've played this game before. Maybe a function or two will help with looking for `one`, `two` etc? Yes. 



### Day 2

1.  Choose some cubes out of a bag - count the games that have less than the minimum for each colour.
2.  Given the revealed numbers for each colour are true, what is the minimum for each colour? 

-   I struggled through creating a nice data structure of a dict of lists of dicts, and then iterating over that, but it worked out in the end making part two quite simple. 
-   I think I struggle most with these iterations because I forget how far deep I am in the structure. 



### Day 3

1.  Find the sum of all the 'part numbers' in the schematic
2.  Find the sum of the gear ratios in the parts schematic

-   This felt like a lot of loops to look at the numbers and the cells surrounding the numbers
-   That is, it felt like a lot until I got to part two. I feel like my approach was pretty solid though, and accounted for the weird possibilities of position of numbers around a `*` i.e. gear. 



### Day 4

1.  How many numbers on the winning scratch cards are there? 
2.  How many scratch cards plus bonus scratch cards are there? 

-   I thought about recording the results but I didn't really need to, just sum up as we go along. 
-   There are probably some list comprehension ways of doing this but a loop made sense. 
-   Here I think I did need to record the results as I went along, and once I understood the scoring properly it was easy enough. 



### Day 5

1.  With a series of mappings, go from seed number to location number
2.  Calculate a very large amount of potential seed numbers through the same mappings.

-   I created the variables semi-manually which caused a little trouble but it was fine. 
-   Pretty happy with my `get_next()` function rather than writing a series of functions. 
-   Part two has me stumped, I think I need to write some kind of search function? Update to come...


### Day 6

1.  Find the distance traveled by some toy boats, hold the button down and they go faster but you've got less time for travel. 
2.  Actually, it was only one time and distance

-   This felt really easy to work through, just do some calculations and count how many numbers are greater than a number. 
-   Do a larger amount of calculations with the same formula. 



### Day 7

1.  Rank the poker cards, according to some funny rules, like 5 of a kind
2.  Rank the poker cards, including a Joker

-   This was fine to work through, making it easier on myself to use `sorted()` with the `key` parameter
-   Not much of a change here, need to think through the possibilities of what a wildcard joker can do to the combinations. 



### Day 8

1.  
2.  

-   
-  



### Day 9

1.  
2.  

-   
-  



### Day 10

1.  
2.  

-   
-  



### Day 11

1.  
2.  

-   
-  



### Day 12

1.  
2.  

-   
-  



### Day 13

1.  
2.  

-   
-  



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

## Advent of Code 2023

### Day 1

1.  
2.  

-   
-   



### Day 2

1.  
2.  

-   
-   



### Day 3

1.  
2.  

-   
-   



### Day 4

1.  
2.  

-   
-   



### Day 5

1.  
2.  

-   
-   



### Day 6

1.  
2.  

-   
-   



### Day 7

1.  
2.  

-   
-   



### Day 8

1.  
2.  

-   
-   



### Day 9

1.  
2.  

-   
-   



### Day 10

1.  
2.  

-   
-   



### Day 11

1.  
2.  

-   
-   



### Day 12

1.  
2.  

-   
-   



### Day 13

1.  
2.  

-   
-   



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

