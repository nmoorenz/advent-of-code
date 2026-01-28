## Advent of Code 2020

We're going on a holiday! 

### Day 1

1. Find two entries that sum to 2020
2. Three entries that sum to 2020

* This could be more efficient in R but I don't know how to break out of a double loop.     
* While searching for loop options in python I found three different ways to write the answer.    

### Day 2

1. How many valid passwords? Number of letters is given
2. How many valid, but the position of the letters is given 

* At first `str_split()` and `unnest_wider()` seemed like the way to go but `separate()` is much better.
* `pmap()` really takes care of business after defining a check function
* Lists can take care of many things in python, especially with the asterisk operator
* Multiple returns from functions are great

### Day 3

1. Trees grow weirdly; how many do you hit when riding on your toboggan? Right 3, down 1
2. There are different ways of getting down - multiply them all

* We don't need to replicate and create a huge matrix or dataframe, using modulo is much simpler
* This might be my favourite code from the advent 

### Day 4

1. Passport checking - which records have the required fields? 
2. Passport checks are now stricter: do the fields have the right content? 

* Welcome to the regex portion of proceedings
* The formatting of the input was awkward but ultimately straightforward to parse
* Maybe we want one function (python), maybe we want many functions (R)
* I think I prefer `parse_integer()` to `int(re.search('\\d+', itm).group(0))`

### Day 5

1. The boarding passes are in binary?! What is the highest seat number? 
2. Which seat number is missing? 

* Pretty pleased with myself to recognise this as binary, which makes the code kinda simple
* `strtoi()` has a `base` argument which makes converting to binary very simple
* Having a look again, `str_replace_all()` works within mutate
* python list comprehensions are so great
* `int()` in python also has a base argument! 


### Day 6

1. Sum the count of the letters for the passengers on the plane
2. Sum the count of the common letters for each group

* Looking back at this I'm not sure why I made part two so difficult
* List comprehensions work great for this one too in python
* `count()` with an argument is nice

### Day 7

1. How many bags can hold a shiny gold bag?
2. How many bags can fit inside a shiny gold bag? 

* This was the last to be completed
* The recursion and branching was difficult to work with

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

