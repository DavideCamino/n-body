import javax.swing.JOptionPane;

//modify
int lengthTail = 100;
int dimBody = 20;

//do not modify
int nBody;
int time = 0;
int step = 1;
Table positions;
int epoch;
boolean rotation = false;
int xStart = 0;
int yStart = 0;
int xStop = 0;
int yStop = 0;
int rx = 0;
int ry = 0;
float scale = 1;
float scaleP;


void setup() {
  size(1500, 1000, P3D);
  prompt();
  findScale();
  epoch = positions.getRowCount();
}

void draw() {
  background(255);
  drawStep();
  transformView();
  drawAxes();
  drawCurrentBodies();
  updateEpoch();
}

void drawStep() {
  stroke(0,0,0);
  fill(0,0,0);
  text("step = " + str(step) + ", scale = " + scale, width * .9, height * .05); 
}

void drawCurrentBodies() {
  for (int i = 0; i < nBody; i++) {
    float x = positions.getFloat(time,i*3);
    float y = positions.getFloat(time,i*3+1);
    float z = positions.getFloat(time,i*3+2); 
    drawSphere(x, y, z);
  }
}

void drawSphere(float x, float y, float z) {
  stroke(255,0,0);
  fill(255,0,0);
  pushMatrix();
  translate(x * scaleP, y * scaleP, z * scaleP);
  sphere(dimBody);
  popMatrix();
}

void drawAxes() {
   line(0, 0, 0, 0, 0, height);
   line(0, 0, 0, 0, -height, 0);
   line(0, 0, 0, height, 0, 0);
   
}

void transformView() {
  translate(width/2, height/2);
  scale(scale);
  if(rotation == true) {
    xStop = mouseX;
    yStop = mouseY;
    rotateY((rx-xStart+xStop) / (width * 0.3));
    rotateX((ry-yStart+yStop) / (height * 0.3));
  }
  else {
    rotateY(rx / (width * 0.3));
    rotateX(ry /(height * 0.3));
  }
}

void keyPressed() {
  if(keyCode == RIGHT)
    step++;
  if(keyCode == LEFT && step > 1)
    step--;
  if(keyCode == UP)
    scale -= scale*0.1;
  if(keyCode == DOWN)
    scale += scale*0.1;
}

void mousePressed() {
  if(rotation == false) {
    xStart = mouseX;
    yStart = mouseY;
  }
  rotation = true;
}

void mouseReleased() {
  rotation = false;
  rx = rx-xStart+xStop;
  ry = ry-yStart+yStop;
}

void updateEpoch() {
  time = time + step;
  if (time >= epoch) {
    time = 0;
  }
}
  
void prompt() {
   String nBodyStr = JOptionPane.showInputDialog("Inserisci il numero di corpi celesti (default 3):");
  if(nBodyStr == null || nBodyStr.length() == 0)
    nBody = 3;
   else
     nBody = int(nBodyStr);
  String fileName = JOptionPane.showInputDialog("Inserisci nome del file (default logfile.csv)");
  if(fileName == null || fileName.length() == 0)
    fileName = "logfile.csv";
    positions = loadTable(fileName);
 }
 
void findScale() {
  float [] maxPos = new float[3];
  maxPos[0]  = abs(positions.getFloat(0,0));
  maxPos[1]  = abs(positions.getFloat(0,1));
  maxPos[2]  = abs(positions.getFloat(0,2));
  for(int i = 0; i < epoch; i++) {
    for(int j = 0; j < nBody; j++) {
      if(maxPos[0] < abs(positions.getFloat(i, j*3)))
        maxPos[0] = abs(positions.getFloat(i, j*3));
      if(maxPos[1] < abs(positions.getFloat(i, j*3+1)))
        maxPos[1] = abs(positions.getFloat(i, j*3+1));
      if(maxPos[2] < abs(positions.getFloat(i, j*3+2)))
        maxPos[2] = abs(positions.getFloat(i, j*3+2));
    }
  }
  scaleP = height * 0.5 / max(maxPos) / 2 ;
}
