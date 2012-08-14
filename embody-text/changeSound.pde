
void changeSound(int din) {
  
  if(din < 3) {
    s3.setVolume(.5,0);
    s3.setVolume(.5,1);
    s4.setVolume(0,0);
    s4.setVolume(0,1);
    s5.setVolume(0,0);
    s5.setVolume(0,1);
    s6.setVolume(0,0);
    s6.setVolume(0,1);
  }
  else  if((din >= 3) &&(din < 6)) {
    s3.setVolume(0,0);
    s3.setVolume(0,1);
    s4.setVolume(1,0);
    s4.setVolume(1,1);
    s5.setVolume(0,0);
    s5.setVolume(0,1);
    s6.setVolume(0,0);
    s6.setVolume(0,1);    
  }
  else  if((din >= 6) &&(din < 9)) {
    s3.setVolume(0,0);
    s3.setVolume(0,1);
    s4.setVolume(0,0);
    s4.setVolume(0,1);
    s5.setVolume(1,0);
    s5.setVolume(1,1);
    s6.setVolume(0,0);
    s6.setVolume(0,1);
  }
  else  if(din >= 9) {
    s3.setVolume(0,0);
    s3.setVolume(0,1);
    s4.setVolume(0,0);
    s4.setVolume(0,1);
    s5.setVolume(0,0);
    s5.setVolume(0,1);
    s6.setVolume(1,0);
    s6.setVolume(1,1);
  }
}
