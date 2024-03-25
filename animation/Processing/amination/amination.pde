import javax.swing.JOptionPane;
//modify
int lengthTail = 100;
int dimBody = 20;
//do not modify
int nBody;
String fileName;
int time = 0;
int step = 1;
Table positions;
int nRow;
float [] maxPos = new float[3];
float [] scalePos = new float[3];

void setup() {
  size(1500, 1000);
  background(255);
  String nBodyStr = JOptionPane.showInputDialog("Inserisci il numero di corpi celesti (default 3):");
  println(nBodyStr);
  if(nBodyStr == null || nBodyStr.length() == 0)
    nBody = 3;
   else
     nBody = int(nBodyStr);
  String fileName = JOptionPane.showInputDialog("Inserisci nome del file (default logfile.csv)");
  if(fileName == null || fileName.length() == 0)
    fileName = "logfile.csv";
  positions = loadTable(fileName);
  nRow = positions.getRowCount();
  findMax();
  scalePos[0] = 0.9 * width / 2 / maxPos[0];
  scalePos[1] = 0.9 * height / 2 / maxPos[1];
  scalePos[2] = 0.9 * width / maxPos[2];
  //scalePos[0] = 200;
  //scalePos[1] = 200;
  //scalePos[2] = 200;
  //println("Max coordinates = " + maxPos[0] + " " + maxPos[1] + " " + maxPos[2]);
 }


void draw() {
  background(255);
  drawStep();
  drawCurrent();
  drawTail();
  
  time = time + step;
  if (time >= nRow) {
    time = 0;
  }
}

void drawCurrent() {
  stroke(255,0,0);
  fill(255,0,0);
  for(int i = 0; i < nBody; i++) {
    float x = positions.getFloat(time,i*3) * scalePos[0];
    float y = positions.getFloat(time,i*3+1) * scalePos[1];
    ellipse(x+width/2, y+height/2, dimBody, dimBody); 
  }
}

void drawTail() {
  stroke(255,0,0);
  fill(255,0,0);
  for(int i = 1; i <= lengthTail && time - i >=0; i++) {
    stroke(255, 255*(i+1)/lengthTail, 255*(i+1)/lengthTail);
    fill(255,255*i/lengthTail, 255*i/lengthTail);
    for(int j = 0; j < nBody; j++) {
      float x = positions.getFloat(time - i, j*3) * scalePos[0];
      float y = positions.getFloat(time - i, j*3+1) * scalePos[1];
      ellipse(x+width/2, y+height/2, dimBody-dimBody*i/lengthTail, dimBody-dimBody*i/lengthTail); 
    }
  }
}

void findMax() {
  maxPos[0]  = abs(positions.getFloat(0,0));
  maxPos[1]  = abs(positions.getFloat(0,1));
  maxPos[2]  = abs(positions.getFloat(0,2));
  for(int i = 0; i < nRow; i++) {
    for(int j = 0; j < nBody; j++) {
      if(maxPos[0] < abs(positions.getFloat(i, j*3)))
        maxPos[0] = abs(positions.getFloat(i, j*3));
      if(maxPos[1] < abs(positions.getFloat(i, j*3+1)))
        maxPos[1] = abs(positions.getFloat(i, j*3+1));
      if(maxPos[2] < abs(positions.getFloat(i, j*3+2)))
        maxPos[2] = abs(positions.getFloat(i, j*3+2));
    }
  }
}

void drawStep() {
  stroke(0,0,0);
  fill(0,0,0);
  text("step = " + str(step), width * .95, height * .05); 
}

void keyPressed() {
  if(keyCode == RIGHT)
    step++;
  if(keyCode == LEFT && step > 1)
    step--;
}
