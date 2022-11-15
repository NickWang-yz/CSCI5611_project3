# CSCI5611_project3
### Single-arm IK(20 points)

### Multi-arm IK(20 points)

### Joint Limits(20 points)

### Part2: Alternative IK Solver(20 points)
We use FABRIK method in this IK solver, The FABRIK is easier to implement because you just need to breate several points(joints), modify their positions back and forth(use the FABRIK method to relocate the position of each point, I loop the method 5 times to get the final result). It seems to me that they both perform really good and smoothly. By using different way, CCD's IK's arm that towards body may move in less space when the mouse have a small move, but for FABRIK, each arm shall move when the mouse moves. Also, because of using different algorithm, for CCD's IK, the animation is more smooth in the middle processing when the object changes from one position to anther, whereas for FABRIK, since its middle process is not that realistic, it only shows the final result without showing the middle arms moving process.For constraints, CCD can easier implement speed limitation and angle limitation, but FABRIK is harder. Since it use back and force to calculate the position, it can't really do speed limitation, but can only settle the final position and according to original position and final position to do animation. 
