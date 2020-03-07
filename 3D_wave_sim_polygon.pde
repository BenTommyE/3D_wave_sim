float[][] particle;
float[][] particlesSpeed;

float[][] particlesNew;
float[][] particlesSpeedNew;

float particelGain = 0.00999;
float forceGain = 0.999;  // Speed

int funberOfPArticles = 100;
float CameraX = 800;
float CameraY = 1500;
float CameraZ = 300;

float CameraMovments = 0;
int CameraMovInt = 0;

float zoom = 1000 / funberOfPArticles;
float offset = 0;

float waveOrNot = -5;

void setup() {
  //size(1280, 780, P3D);
  fullScreen(P3D);
  pixelDensity(2);
  particle = new float[funberOfPArticles][funberOfPArticles];
  particlesSpeed = new float[funberOfPArticles][funberOfPArticles];
  particlesNew = new float[funberOfPArticles][funberOfPArticles];
  particlesSpeedNew = new float[funberOfPArticles][funberOfPArticles];

  for (int x = 1; x<funberOfPArticles-1; x++) {
    for (int y = 1; y<funberOfPArticles-1; y++) {

      particle[x][y] = 0.0;
      particlesNew[x][y] = 0.0;
      particlesSpeed[x][y] = 0.0;
      particlesSpeedNew[x][y] = 0.0;
    }
  }



  noFill();
  stroke(255);
}

void draw() {
  camera(CameraX, CameraY, CameraZ, 500, 500, 0.0, 
    0.0, 0.0, -1.0);

  directionalLight(126, 126, 126, 0, 0.5, -1);

  updateMesh();

  background(0);
  drawCoorinats();
  drawMesh();
  println(frameRate);
}

void updateMesh() {


  for (int x = 1; x<funberOfPArticles-2; x++) {
    for (int y = 1; y<funberOfPArticles-2; y++) {
      //under 
      float force1 = 0.0;
      force1 += particle[x-1][y-1] - particle[x][y];
      force1 += particle[x-1][y] - particle[x][y];
      force1 += particle[x-1][y+1] - particle[x][y];
      //over
      force1 += particle[x+1][y-1] - particle[x][y];
      force1 += particle[x+1][y] - particle[x][y];
      force1 += particle[x+1][y+1] - particle[x][y];
      //sidene
      force1 += particle[x][y-1] - particle[x][y];
      force1 += particle[x][y+1] - particle[x][y];

      force1 -= particle[x][y+1] / 8;

      //force1 = constrain(force1, -1, 1);

      particlesSpeedNew[x][y] = 0.995 * particlesSpeedNew[x][y] + force1/100;

      particlesNew[x][y] = particle[x][y] + particlesSpeedNew[x][y];
    }
  }

  for (int x = 1; x<funberOfPArticles-1; x++) {
    for (int y = 1; y<funberOfPArticles-1; y++) {

      particle[x][y] = particlesNew[x][y];
    }
  }
  if (waveOrNot != 0) {
    offset += .1;
    int MouseXIndex = 2 + (funberOfPArticles-4) * mouseX / width;
    int MouseYIndex = 2 + (funberOfPArticles-4) * mouseY / height;
    particlesSpeedNew[MouseXIndex][MouseYIndex] = waveOrNot;
    particlesSpeedNew[MouseXIndex+1][MouseYIndex+1] = waveOrNot;
    particlesSpeedNew[MouseXIndex+1][MouseYIndex] = waveOrNot;
    particlesSpeedNew[MouseXIndex+1][MouseYIndex-1] = waveOrNot;
    particlesSpeedNew[MouseXIndex][MouseYIndex-1] = waveOrNot;
    particlesSpeedNew[MouseXIndex-1][MouseYIndex+1] = waveOrNot;
    particlesSpeedNew[MouseXIndex-1][MouseYIndex] = waveOrNot;
    particlesSpeedNew[MouseXIndex-1][MouseYIndex-1] = waveOrNot;

    particle[MouseXIndex][MouseYIndex] = waveOrNot*10;
    particle[MouseXIndex+1][MouseYIndex+1] = waveOrNot*5;
    particle[MouseXIndex+1][MouseYIndex] = waveOrNot*10;
    particle[MouseXIndex+1][MouseYIndex-1] = waveOrNot*5;
    particle[MouseXIndex][MouseYIndex-1] = waveOrNot*10;
    particle[MouseXIndex-1][MouseYIndex+1] = waveOrNot*5;
    particle[MouseXIndex-1][MouseYIndex] = waveOrNot*10;
    particle[MouseXIndex-1][MouseYIndex-1] = waveOrNot*5;

    //particlesSpeedNew[40][40] = 100.0 * sin( offset);
  }
}

void drawCoorinats() {
  strokeWeight(3);
  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);

  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
}

void drawMesh() {


  //strokeWeight(1);
  //stroke(0, 255, 255);
  noStroke();
  fill(200);
  for (int x = 0; x<funberOfPArticles-1; x++) {

    for (int y = 0; y<funberOfPArticles-1; y++) {
      beginShape();
      vertex( (x)*zoom, (y)*zoom, particle[x][y] );
      vertex( (x+1)*zoom, (y)*zoom, particle[x+1][y] );
      vertex( (x+1)*zoom, (y+1)*zoom, particle[x+1][y+1] );
      vertex( (x)*zoom, (y+1)*zoom, particle[x][y+1] );
      endShape();
    }
  }
}
