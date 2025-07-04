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

-   I created the variables semi-manually which caused a little trouble initially but it was fine. 
-   Pretty happy with my `get_next()` function rather than writing a series of functions. 
-   Part two has me stumped, I think I need to write some kind of search function? Update to come...
-   I don't need to keep track of every number, just the boundaries, so I think a list of lists will do nicely. 

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

1.  Navigate through the network with the instructions given by Left or Right
2.  Don't just follow one path, follow many paths. 

-   I like the little things that make problems easier: a dictionary for L/R directions, and a function for a lambda to create another dictionary for the options. 
-   Part two could be a very bad time, but realising that the paths are probably independent really helped, so it's actually six individual problems. 



### Day 9

1.  Extrapolate forwards to get the next number in the sequence.
2.  Extrapolate backwards to get the previous number in the sequence. 

-   I was sceptical that the way the instructions gave the method was the right way to go but it turned out ok. 
-   This was very similar to the first part, but still required a bit of thinking. 



### Day 10

1.  Follow the loop around the pipes. 
2.  How many tiles are enclosed by the loop? 

-   It took some time to create the correct dictionary for the movement, but it still feels like the right way to do things. 
-   Not really sure how to do this one: update to come. 



### Day 11

1.  Find the shortest path between each pair of galaxies. 
2.  The celestial picture is actually much older and the distance between the galaxies is actually way bigger. 

-   `np.insert()` does me well here. 
-   I thought I had part two done by not actually doing the expansion and adding millions to the distances between the galaxies but that did not quote work. 
-   What did work was realising that you've accounted for one unit of distance so actually insert 999,999 rows or columns. 


### Day 12

1.  How many different arrangements of springs are there? 
2.  Actually, there are way more arrangements, what are the possibilities? 

-   Created two functions: `create_options()` and `verify_arr()` which helps things along
-   Part two creates way more iterations than is reasonable: back to the drawing board. 



### Day 13

1.  Find the row or column of reflection for each set of mirrors. 
2.  There's a smudge on the mirrors! Find the different line of reflection.

-   I tried some different approaches and eventually found the correct loop scheme, checking all the rows/columns. 
-  



### Day 14

1.  Roll the rocks north to see the load on the support beams
2.  Roll the rocks around and around a billion times to see how things end up

-   This is simple enough, since the usual iteration means we move the rocks in the correct order to avoid errors
-   Part two required setting up different functions for movement and iteration
-   We don't actually have to iterate a billion times, since we get into a repeating pattern, and once we figure that out, we can work out where we would be at the billion mark. 



### Day 15

1.  Run the hash algorithm for the initialization sequence. 
2.  

-   
-  



### Day 16

1.  Follow the laser around the hall of mirrors, except the laser can be split
2.  

-   
-  



### Day 17

1.  Find the shortest path through the city, except you can only go three blocks in the same direction at a time. 
2.  

-   
-  



### Day 18

1.  Find how much space there is for the lava to fill, following a rambling path around the edge of the lagoon
2.  Actually, there is a much larger lagoon bounded by a rambling path described by the hex digits. 

-   
-  



### Day 19

1.  Accept or reject the machine parts, according to a series of rules based on: Cool looking, musical, aerodynamic, or shiny. 
2.  

-   
-  



### Day 20

1.  Propagate the pulse through a series of modules
2.  

-   
-  



### Day 21

1.  Step Counter: How far can the elf go in exactly 64 steps? 
2.  

-   
-  



### Day 22

1.  Given the locations of some falling bricks, how many can be safely disintegrated when they have come to rest? 
2.  

-   
-  



### Day 23

1.  Find the longest hike through the snow
2.  

-   
-  



### Day 24

1.  Given a flurry of hailstones, determine how many of those hailstones interact within the test area
2.  

-   
-  



### Day 25

1.  Disconnect three wires to create two distinct groups of components. 
2.  

-   
-  
