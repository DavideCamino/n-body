/* autogenerated by Processing revision 1293 on 2024-03-31 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import javax.swing.JOptionPane;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class amination3D extends PApplet {



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


public void setup() {
  /* size commented out by preprocessor */;
  prompt();
  findScale();
  epoch = positions.getRowCount();
}

public void draw() {
  background(255);
  drawStep();
  transformView();
  drawAxes();
  drawCurrentBodies();
  updateEpoch();
}

public void drawStep() {
  stroke(0,0,0);
  fill(0,0,0);
  text("step = " + str(step) + ", scale = " + scale, width * .9f, height * .05f); 
}

public void drawCurrentBodies() {
  for (int i = 0; i < nBody; i++) {
    float x = positions.getFloat(time,i*3);
    float y = positions.getFloat(time,i*3+1);
    float z = positions.getFloat(time,i*3+2); 
    drawSphere(x, y, z);
  }
}

public void drawSphere(float x, float y, float z) {
  stroke(255,0,0);
  fill(255,0,0);
  pushMatrix();
  translate(x * scaleP, y * scaleP, z * scaleP);
  sphere(dimBody);
  popMatrix();
}

public void drawAxes() {
   line(0, 0, 0, 0, 0, height);
   line(0, 0, 0, 0, -height, 0);
   line(0, 0, 0, height, 0, 0);
   
}

public void transformView() {
  translate(width/2, height/2);
  scale(scale);
  if(rotation == true) {
    xStop = mouseX;
    yStop = mouseY;
    rotateY((rx-xStart+xStop) / (width * 0.3f));
    rotateX((ry-yStart+yStop) / (height * 0.3f));
  }
  else {
    rotateY(rx / (width * 0.3f));
    rotateX(ry /(height * 0.3f));
  }
}

public void keyPressed() {
  if(keyCode == RIGHT)
    step++;
  if(keyCode == LEFT && step > 1)
    step--;
  if(keyCode == UP)
    scale -= scale*0.1f;
  if(keyCode == DOWN)
    scale += scale*0.1f;
}

public void mousePressed() {
  if(rotation == false) {
    xStart = mouseX;
    yStart = mouseY;
  }
  rotation = true;
}

public void mouseReleased() {
  rotation = false;
  rx = rx-xStart+xStop;
  ry = ry-yStart+yStop;
}

public void updateEpoch() {
  time = time + step;
  if (time >= epoch) {
    time = 0;
  }
}
  
public void prompt() {
   String nBodyStr = JOptionPane.showInputDialog("Inserisci il numero di corpi celesti (default 3):");
  if(nBodyStr == null || nBodyStr.length() == 0)
    nBody = 3;
   else
     nBody = PApplet.parseInt(nBodyStr);
  String fileName = JOptionPane.showInputDialog("Inserisci nome del file (default logfile.csv)");
  if(fileName == null || fileName.length() == 0)
    fileName = "logfile.csv";
    positions = loadTable(fileName);
 }
 
public void findScale() {
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
  scaleP = height * 0.5f / max(maxPos) / 2 ;
}


  public void settings() { size(1500, 1000, P3D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "amination3D" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
