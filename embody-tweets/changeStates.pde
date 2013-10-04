
void changeStates(int din) {

  float jj = map(din, 0, 13, 0, width);
   float ii = map(din, 0, 13, height, 0);
  float qq = map(din, 0, 13, 200, -600);
  float uu = map(din, 13, 9, 0, 200);
  
    if((camx + 10) < jj) {
      camx += 5;
    }
    else if(camx > jj) {
      camx -= 5;
    }
   
    if((camy + 10) < ii) {
      camy += 5;
    }
    else if(camy > ii) {
      camy -= 5;
    }  
   
    if((camz + 10) < qq) {
      camz += 5;
    }
    else if(camz > qq) {
      camz -= 5;
    } 
   
//   if(din >= 9) {
//     transy = uu;
//   }
   
   depthpast = din;
}
