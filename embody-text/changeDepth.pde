
void changeDepth(int d) {

  if(d != pastdepth) {
    
    if(backforth) {
      ii++;
    }
    else {
      ii--;
    }
   
   if(ii > (ee2.length - 15)) {
      backforth = false;
    }
   else if(ii < 1) {
      backforth = true;
    }
  }
    
  
  println(ii);     
  
  
  changeSound(d);
  changeStates(d);
  pastdepth = d;
}

