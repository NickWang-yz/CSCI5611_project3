//Inverse Kinematics
//CSCI 5611 IK [Solution]
// Stephen J. Guy <sjguy@umn.edu>

/*
INTRODUCTION:
Rather than making an artist control every aspect of a characters animation, we will often specify 
key points (e.g., center of mass and hand position) and let an optimizer find the right angles for 
all of the joints in the character's skelton. This is called Inverse Kinematics (IK). Here, we start 
with some simple IK code and try to improve the results a bit to get better motion.

TODO:
Step 1. Change the joint lengths and colors to look more like a human arm. Try to match 
        the length ratios of your own arm/hand, and try to match your own skin tone in the rendering.

Step 2: Add an angle limit to the wrist joint, and limit it to be within +/- 90 degrees relative
        to the lower arm.
        -Be careful to put the joint limits for the wrist *before* you compute the new end effoctor
         position for the next link in CCD

Step 3: Add an angle limit to the shoulder joint to limit the joint to be between 0 and 90 degrees, 
        this should stop the top of the arm from moving off screen.

Step 4: Cap the acceleration of each joint so the joints can only update slowly. Try to tweak the 
        acceleration cap to be different for each joint to get a good effect on the arm motion.

Step 5: Try adding a 4th limb to the IK chain.


CHALLENGE:

1. Go back to the 3-limb arm, can you make it look more human-like. Try adding a simple body to 
   the scene using circles and rectangles. Can you make a scene where the character picks up 
   something and moves it somewhere?
2. Create a more full skeleton. How do you handle the torso having two different arms?

*/

void setup(){
  size(640,480);
  surface.setTitle("Inverse Kinematics [CSCI 5611 Example]");
}

//Root
Vec2 root = new Vec2(350,300);
Vec2 rootLeft = new Vec2(230, 300);

//Arm 0
float l0 = 100; 
float a0 = 0.3; //Shoulder joint

//Arm 1
float l1 = 100;
float a1 = 0.3; //Elbow joint

//Arm 2
float l2 = 100;
float a2 = 0.3; //Wrist joint

//hand
float l3 = 100;
float a3 = 0.3;

//Arm 0
float l4 = 100; 
float a4 = 0.3; //Shoulder joint

//Arm 1
float l5 = 100;
float a5 = 0.3; //Elbow joint

//Arm 2
float l6 = 100;
float a6 = 0.3; //Wrist joint

//hand
float l7 = 100;
float a7 = 0.3;

Vec2 start_l1,start_l2,start_l3,endPoint;
Vec2 start_l5,start_l6,start_l7,endPoint2;

float angleSpeedLimit = 0.00001;

void solve(float dt){
  Vec2 goal = new Vec2(mouseX, mouseY);
  
  Vec2 startToGoal, startToEndEffector;
  float dotProd, angleDiff;

  //Update wrist joint
  startToGoal = goal.minus(start_l7);
  startToEndEffector = endPoint2.minus(start_l7);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a7 += (angleSpeedLimit+dt);
    else
      a7 -= (angleSpeedLimit+dt);
  }
  /*TODO: Wrist joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)

  //Update wrist joint
  startToGoal = goal.minus(start_l6);
  startToEndEffector = endPoint2.minus(start_l6);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a6 += (angleSpeedLimit+dt);
    else
      a6 -= (angleSpeedLimit+dt);
  }
  /*TODO: Wrist joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)

  //Update wrist joint
  startToGoal = goal.minus(start_l5);
  startToEndEffector = endPoint2.minus(start_l5);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a5 += (angleSpeedLimit+dt);
    else
      a5 -= (angleSpeedLimit+dt);
  }
  /*TODO: Wrist joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)

  //Update shoulder joint
  startToGoal = goal.minus(rootLeft);
  if (startToGoal.length() < .0001) return;
  startToEndEffector = endPoint2.minus(rootLeft);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a4 += (angleSpeedLimit+dt);
    else
      a4 -= (angleSpeedLimit+dt);
  }
  /*TODO: Shoulder joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)

  //Update wrist joint
  startToGoal = goal.minus(start_l3);
  startToEndEffector = endPoint.minus(start_l3);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a3 += (angleSpeedLimit+dt);
    else
      a3 -= (angleSpeedLimit+dt);
  }
  /*TODO: Wrist joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)
  
  //Update wrist joint
  startToGoal = goal.minus(start_l2);
  startToEndEffector = endPoint.minus(start_l2);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a2 += (angleSpeedLimit+dt);
    else
      a2 -= (angleSpeedLimit+dt);
  }
  /*TODO: Wrist joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)
  
  
  
  //Update elbow joint
  startToGoal = goal.minus(start_l1);
  startToEndEffector = endPoint.minus(start_l1);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a1 += (angleSpeedLimit+dt);
    else
      a1 -= (angleSpeedLimit+dt);
  }
  fk(); //Update link positions with fk (e.g. end effector changed)
  
  
  //Update shoulder joint
  startToGoal = goal.minus(root);
  if (startToGoal.length() < .0001) return;
  startToEndEffector = endPoint.minus(root);
  dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
  dotProd = clamp(dotProd,-1,1);
  angleDiff = acos(dotProd);
  println("angleDiff: ", angleDiff);
  if(angleDiff > 0.01) {
    if (cross(startToGoal,startToEndEffector) < 0)
      a0 += (angleSpeedLimit+dt);
    else
      a0 -= (angleSpeedLimit+dt);
  }
  /*TODO: Shoulder joint limits here*/
  fk(); //Update link positions with fk (e.g. end effector changed)

  //println("Angle 0:",a0,"Angle 1:",a1,"Angle 2:",a2, "Angle 3:",a3);
}

void fk(){
  start_l1 = new Vec2(cos(a0)*l0,sin(a0)*l0).plus(root);
  start_l2 = new Vec2(cos(a0+a1)*l1,sin(a0+a1)*l1).plus(start_l1);
  start_l3 = new Vec2(cos(a0+a1+a2)*l2,sin(a0+a1+a2)*l2).plus(start_l2);
  endPoint = new Vec2(cos(a0+a1+a2+a3)*l3,sin(a0+a1+a2+a3)*l3).plus(start_l3);
  
  start_l5 = new Vec2(cos(a4)*l4,sin(a4)*l4).plus(rootLeft);
  start_l6 = new Vec2(cos(a4+a5)*l5,sin(a4+a5)*l5).plus(start_l5);
  start_l7 = new Vec2(cos(a4+a5+a6)*l6,sin(a4+a5+a6)*l6).plus(start_l6);
  endPoint2 = new Vec2(cos(a4+a5+a6+a7)*l7,sin(a4+a5+a6+a7)*l7).plus(start_l7);
}

float armW = 20;
Vec2 robotHead = new Vec2(250, 200);
Vec2 robotBody = new Vec2(220, 230);
Vec2 robotEyeLeft = new Vec2(275, 215);
Vec2 robotEyeRight = new Vec2(305, 215);
void draw(){
  fk();
  solve(1/frameRate);
  
  background(250,250,250);
  
  fill(255, 165, 0);
  pushMatrix();
  translate(robotHead.x,robotHead.y);
  rect(0, 0, 80, 30);
  popMatrix();

  pushMatrix();
  translate(robotBody.x,robotBody.y);
  rect(0, 0, 140, 220);
  popMatrix();

  fill(0,0,255);
  pushMatrix();
  translate(robotEyeLeft.x,robotEyeLeft.y);
  circle(0,0,10);
  popMatrix();

  pushMatrix();
  translate(robotEyeRight.x,robotEyeRight.y);
  circle(0,0,10);
  popMatrix();

  fill(200,0,180);
  pushMatrix();
  translate(root.x,root.y);
  rotate(a0);
  rect(0, -armW/2, l0, armW);
  popMatrix();
  
  pushMatrix();
  translate(start_l1.x,start_l1.y);
  rotate(a0+a1);
  rect(0, -armW/2, l1, armW);
  popMatrix();
  
  pushMatrix();
  translate(start_l2.x,start_l2.y);
  rotate(a0+a1+a2);
  rect(0, -armW/2, l2, armW);
  popMatrix();

  pushMatrix();
  translate(start_l3.x,start_l3.y);
  rotate(a0+a1+a2+a3);
  rect(0, -armW/2, l3, armW);
  popMatrix();

  pushMatrix();
  translate(rootLeft.x,rootLeft.y);
  rotate(a4);
  rect(0, -armW/2, l4, armW);
  popMatrix();

  pushMatrix();
  translate(start_l5.x,start_l5.y);
  rotate(a4+a5);
  rect(0, -armW/2, l5, armW);
  popMatrix();

  pushMatrix();
  translate(start_l6.x,start_l6.y);
  rotate(a4+a5+a6);
  rect(0, -armW/2, l6, armW);
  popMatrix();

  pushMatrix();
  translate(start_l7.x,start_l7.y);
  rotate(a4+a5+a6+a7);
  rect(0, -armW/2, l7, armW);
  popMatrix();
  
}



//-----------------
// Vector Library
//-----------------

//Vector Library
//CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>

public class Vec2 {
  public float x, y;
  
  public Vec2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public String toString(){
    return "(" + x+ "," + y +")";
  }
  
  public float length(){
    return sqrt(x*x+y*y);
  }
  
  public Vec2 plus(Vec2 rhs){
    return new Vec2(x+rhs.x, y+rhs.y);
  }
  
  public void add(Vec2 rhs){
    x += rhs.x;
    y += rhs.y;
  }
  
  public Vec2 minus(Vec2 rhs){
    return new Vec2(x-rhs.x, y-rhs.y);
  }
  
  public void subtract(Vec2 rhs){
    x -= rhs.x;
    y -= rhs.y;
  }
  
  public Vec2 times(float rhs){
    return new Vec2(x*rhs, y*rhs);
  }
  
  public void mul(float rhs){
    x *= rhs;
    y *= rhs;
  }
  
  public void clampToLength(float maxL){
    float magnitude = sqrt(x*x + y*y);
    if (magnitude > maxL){
      x *= maxL/magnitude;
      y *= maxL/magnitude;
    }
  }
  
  public void setToLength(float newL){
    float magnitude = sqrt(x*x + y*y);
    x *= newL/magnitude;
    y *= newL/magnitude;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y);
    x /= magnitude;
    y /= magnitude;
  }
  
  public Vec2 normalized(){
    float magnitude = sqrt(x*x + y*y);
    return new Vec2(x/magnitude, y/magnitude);
  }
  
  public float distanceTo(Vec2 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    return sqrt(dx*dx + dy*dy);
  }
}

Vec2 interpolate(Vec2 a, Vec2 b, float t){
  return a.plus((b.minus(a)).times(t));
}

float interpolate(float a, float b, float t){
  return a + ((b-a)*t);
}

float dot(Vec2 a, Vec2 b){
  return a.x*b.x + a.y*b.y;
}

float cross(Vec2 a, Vec2 b){
  return a.x*b.y - a.y*b.x;
}


Vec2 projAB(Vec2 a, Vec2 b){
  return b.times(a.x*b.x + a.y*b.y);
}

float clamp(float f, float min, float max){
  if (f < min) return min;
  if (f > max) return max;
  return f;
}
