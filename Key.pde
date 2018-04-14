

void keyPressed() {
  if (keyCode == UP) {
    CameraY -= 100;
  } else if (keyCode == DOWN) {
    CameraY += 100;
  }
  if (keyCode == RIGHT) {
    CameraX += 100;
  }  if (keyCode == LEFT) {
    CameraX += -100;
  }
  
  if (key==' ') {
    if(waveOrNot == 0) {
      waveOrNot = -5;
    }else{
      waveOrNot = 0;
    }
  }
  
  if (key == 'a') {
    CameraZ += 100;
  }  if (key == 'z') {
    CameraZ += -100;
  }
   println(" " + CameraX + ", " + CameraY + ", " + CameraZ);
}
