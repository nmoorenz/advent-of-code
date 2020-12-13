
# read file
with open("day3.txt", "r") as f:
  course = f.read().splitlines()
  
def move_tobog(rght, dwn, course):
  x_pos = 0
  y_pos = 0
  trees = 0
  course_len = len(course)
  course_wid = len(course[0])
  while y_pos < course_len:
    if course[y_pos][x_pos] == "#":
      trees += 1
    x_pos = (x_pos + rght) % course_wid
    y_pos = y_pos + dwn
  return trees
    
trees_1 = move_tobog(3, 1, course)
trees_2 = move_tobog(1, 1, course)
trees_3 = move_tobog(5, 1, course)
trees_4 = move_tobog(7, 1, course)
trees_5 = move_tobog(1, 2, course)

trees_1 * trees_2 * trees_3 * trees_4 * trees_5
