
void initializeEE() {
  
/*
The text we're working with below is the ee cummings poem 
"this is the garden," which we've split into an array of 
components splitting the content of each line of the poem.
*/
  
  ee2 = new String[ee.length];

 for(int k = 0; k < ee.length; k++) {
  for(int r = 0; r < 4800 / ee[k].length(); r++) {
    fortyeight += ee[k];
  }
 
  ee2[k] = fortyeight;
  fortyeight = "";
}

for(int u = 0; u < ee2.length; u++) {
  if(ee2[u].length() <= 4800) {
     ee2[u] += ee[u]; 
  }
}

}  
