import geomerative.*;

RFont font;
float counter = 0;

class Fourrier {
  int n;
  float amp[];
  float freq[];
  float fase[];
  float x;
  float y;


  Fourrier(int n_, int x_, int y_) {
    n= n_;
    y= y_;
    x= x_;
    amp = new float[n_];
    freq = new float[n_];
    fase = new float[n_];

    for (int i=0; i<n_; i++) {
      fase[i] = random(TWO_PI);
      freq[i]= random(-0.1, 0.1); //quinta de la fundamental y doble de la fundamental
      amp[i]= random(1, 10);
    }
  }

  float valor (float v_) {
    float val = 0;
    for (int i = 0; i<n; i++) {
      val += sin (v_*freq[i]+fase[i]*amp[i]);
    }
    return val;
  }

  float valorEnN (float v_, int n_) {
    float val = 0;
    for (int k= 0; k<n_; k++) {
      val += sin (v_*freq[k]+fase[k]*amp[k]);
    }
    return val;
  }
}

ArrayList <Fourrier> f;
ArrayList <Fourrier> g;
float delta;
PGraphics pg;
float x;
float y;

void setup() {
  size (1200, 400);
  background(255);
  f = new ArrayList <Fourrier>();
  g = new ArrayList <Fourrier>();

  
  //image (pg, 0, 0);

  RG.init(this);
  font = new RFont("Rubik-Light.ttf");
  font.setSize(50);
  font.setAlign(RFont.CENTER);
  noStroke();
  fill(0);
 
}

void draw() {
 //background(255);   //  si se pone aqui crea otra variacion
  translate(width/2-10, height/2+30);
  
  //delta +=0.5;
  for (int j = 0; j<f.size(); j++) {
    float x = f.get(j).valor(delta);
    float y = g.get(j).valor(delta); 
    noStroke();
    fill(30);
    ellipse(f.get(j).x+x, g.get(j).y+y, 0.2, 0.2);
  }
  
    RCommand.setSegmentLength(mouseX/2+6);

  RGroup grp = font.toGroup("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ");
  grp = grp.toPolygonGroup();
  RPoint[] punto = grp.getPoints();
  
  noStroke();
  fill(0, 100, 100);
  for (int i=0; i < punto.length; i++) {
    point(punto[i].x, punto[i].y); 
    line(punto[i].x-5, punto[i].y-5, punto[i].x+5, punto[i].y+5);
    float sinHeight = mouseY/float(height)*50;
    float offsetY = sin(counter+punto[i].x/width*4)*sinHeight;

    ellipse(punto[i].x, punto[i].y+offsetY, 2, 2);
  }

  for (int i=0; i < punto.length-1; i++) {
    float abstand = dist(punto[i].x, punto[i].y, punto[i+1].x, punto[i+1].y);
    stroke(0, 0, 0, 100-abstand*2);
    float sinHeight = mouseY/float(height)*30;
    float offsetY = sin(counter+punto[i].x/width*4)*sinHeight;
    float offsetY2 = sin(counter+punto[i+1].x/width*4)*sinHeight;
    line(punto[i].x, punto[i].y+offsetY, punto[i+1].x, punto[i+1].y+offsetY2);
  }
}
