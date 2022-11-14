float arml = 80;

Vec2 root = new Vec2(590,400);
Vec2 point1 = new Vec2(670, 400);
Vec2 point2 = new Vec2(750, 400);

Vec2 goal;

float angle1, angle2, angle3;
float x1, y1, x2, y2, x3, y3;

void setup(){
  size(1640,1480);
  surface.setTitle("Inverse Kinematics [CSCI 5611 Example]");

  goal = new Vec2(random(root.x-3*80, root.x+3*80), random(root.y-3*80, root.y+3*80));
}

void update() {
  Vec2 startGoal, normaStartGoal;

  for(int i = 0; i < 5; i++) {
    //goal accurate
    startGoal = point2.minus(goal);
    normaStartGoal = startGoal.normalized();
    point2 = goal.plus(normaStartGoal.times(arml));

    startGoal = point1.minus(point2);
    normaStartGoal = startGoal.normalized();
    point1 = goal.plus(normaStartGoal.times(arml));

    //root accurate
    startGoal = point1.minus(root);
    normaStartGoal = startGoal.normalized();
    point1 = root.plus(normaStartGoal.times(arml));

    startGoal = point2.minus(point1);
    normaStartGoal = startGoal.normalized();
    point2 = point1.plus(normaStartGoal.times(arml));
  }

  x1 = point1.x-root.x;
  y1 = point1.y-root.y;
  if((x1>=0 && y1>=0) || (x1>=0 && y1<0)) {
    angle1 = atan(y1/x1);
  }
  else  {
    angle1 = PI + atan(y1/x1);
  }

  x2 = point2.x-point1.x;
  y2 = point2.y-point1.y;
  angle2 = atan(y2/x2);
  if((x2>=0 && y2>=0) || (x2>=0 && y2<0)) {
    angle2 = atan(y2/x2);
  }
  else {
    angle2 = PI + atan(y2/x2);
  }

  x3 = goal.x-point2.x;
  y3 = goal.y-point2.y;
  angle3 = atan(y3/x3);
  if((x3>=0 && y3>=0) || (x3>=0 && y3<0)) {
    angle3 = atan(y3/x3);
  }
  else {
    angle3 = PI + atan(y3/x3);
  }

  //println("point1: ", root.x, " ", root.y, "point2: ", point1.x, " ",  point1.y, "point3: ", point2.x, " ",  point2.y);
  println("angle1: ", angle1, "angle2: ", angle2, "angle3: ", angle3);
}

Vec2 robotHead = new Vec2(550, 300);
Vec2 robotBody = new Vec2(520, 330);
Vec2 robotEyeLeft = new Vec2(575, 315);
Vec2 robotEyeRight = new Vec2(605, 315);
float armW = 20;

void draw() {
  background(250,250,250);
  update();

  //draw body
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

  //draw arm
  fill(255,0,0);
  pushMatrix();
  translate(root.x,root.y);
  rotate(angle1);
  rect(0, -armW/2, arml, armW);
  popMatrix();

  fill(0,255,0);
  pushMatrix();
  translate(point1.x,point1.y);
  rotate(angle2);
  rect(0, -armW/2, arml, armW);
  popMatrix();

  fill(0,0,255);
  pushMatrix();
  translate(point2.x,point2.y);
  rotate(angle3);
  rect(0, -armW/2, arml, armW);
  popMatrix();

  fill(255, 0, 0);
  pushMatrix();
  translate(goal.x,goal.y);
  circle(0, 0, 20);
  popMatrix();
}

void keyPressed() {
  if(key == 'r') {
    goal = new Vec2(random(590-4*80, 590+4*80), random(300-4*80, 300+4*80)); 
  }
}

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