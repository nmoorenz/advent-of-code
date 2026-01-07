## Advent of Code 2025

1 ★ ★\
2 ★ ★\
3 ★ ★\
4 ★ ★\
5 ★ ★\
6 ★ ★\
7 ★ ★\
8 ★ ★\
9 ★ ★\
10 ★ ★\
11 ★ ★\
12 ★ ★\

### Day 1

1.  How many times does the dial point at zero?
2.  How many times does the dial point at or move past zero?

-   Simple enough to follow instructions
-   Not so simple with the counting of the movement. The instructions did say be careful!

### Day 2

1.  Do any of the ranges of digits contain repeated numbers i.e. 456456?
2.  Do any of the ranges contain repeated numbers, of any sort i.e. all repeated?

-   Simple enough to split a number in half and check if it is repeated. I tried to be efficient for 8 and 10 digit numbers, but brute force for smaller ranges.
-   Part two can be any type of repeat, and I really thought I had it sorted while trying to be efficient.
-   Turns out that brute force helps for checking things and found two bugs.

### Day 3

1.  Find the highest two digit joltage in the number given
2.  Find the highest twelve digit joltage in the number given.

-   Loop through and try to find some two digits, counting down from 99
-   Find the maximum of the digits, while leaving space for the rest of the eleven digits, then ten, etc.
-   I had to return to this and figure things out but then it worked fine

### Day 4

1.  How many paper rolls can be accessed by the forklifts?
2.  If the forklifts start removing rolls, how many can they remove?

-   This feels like one of those numpy array things that I only have to deal with for Advent of Code.
-   Keep looping until I don't remove any more rolls i.e. my counter stops going up. Use an iteration counter because I don't trust my while loops.

### Day 5

1.  How many of the ingredient numbers fit into the fresh ranges?
2.  How many numbers are there in total in the fresh ranges?

-   Loop through and check in or out
-   Loop through and check if the ranges overlap or not

### Day 6

1.  Add or multiply the numbers in the lists
2.  Actually, because Advent of code, the numbers are arranged differently.

-   Get the lists in the right shape with integers to easily do the math
-   Get the lists in the right shape with individual characters, then loop backwards, collecting columns as we go.

### Day 7

1.  Count how many times the laser beam gets split
2.  How many different paths are there through the quantum tachyon manifold?

-   Loop the array and make sure we count and split the beams as we go
-   First read through: huh?
-   Read some examples from Reddit and find a good example to copy.

### Day 8

1.  Connect some junction boxes by the shortest distances
2.  Connect all the junction boxes into one group

-   Calculate each of the distances, and do some trickery to group the groups
-   Keep going on the connections, and with a bit of trial and error, find the last connection to be added.

### Day 9

1.  Find the largest rectangle between any two points
2.  Find the largest rectangle between any two points that only contains other points within it.

-   Calculate all the areas and get the largest
-   Attempt 1: of course there are complications with the calculations
-   Attempt 2: draw some charts and figure out what's wrong
-   Attempt 3: be more careful with restricting what I'm testing for improved speed

### Day 10

1.  Work out how many button presses you need to do to turn on some lights.
2.  Work out how many button presses you need to meet the joltage requirements

-   Add up some button presses to turn lights on and off
-   Go on a long ramble trying to figure out a way to calculate the joltage, but then remember how to specify the problem in a linear programming kind of way.

### Day 11

1.  Find how many paths go from `you` to the `out` node in a graph
2.  Find how many paths go from `svr` to `fft` to `dac` to the `out` node

-   Found a new-to-me library `networkx`
-   Attempt 1: figured out the order of the intermediate nodes, which makes things seemingly more solvable, but didn't get right answer.
-   Attempt 2: take some code from reddit. I was on the right track, just needed to try some longer paths, much more calculation time.

### Day 12

1.  Fit the weird shaped presents under the Christmas tree
2.  Earn the stars from the other days.

-   There are quite a lot of shapes, so there are going to be lots of good permutations, just check the area!
-   People are mad about this one online
-   The easter egg (I had forgotten about these!) from the puzzle creator says: *I need to throw in a puzzle like this occasionally to keep everyone on their toes, right?*
