# CSCI5611_project3
### Single-arm IK(20 points)

### Multi-arm IK(20 points)

### Joint Limits(20 points)

### Part2: Alternative IK Solver(20 points)
We use FABRIK method in this IK solver, The FABRIK is easier to implement because you just need to breate several points(joints), modify their positions back and forth(use the FABRIK method to relocate the position of each point, I loop the method 5 times to get the final result). It seems to me that they both perform really good and smoothly. By using different way, part1's IK's arm that towards body may move in less space when the mouse have a small move, but for FABRIK, each arm shall move when the mouse moves. 
