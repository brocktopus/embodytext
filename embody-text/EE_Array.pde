
void initializeEE() {
  
/*
The text we're working with below is the ee cummings poem 
"this is the garden," which we've split into an array of 
components splitting the content of each line of the poem.
*/
  
  ee2 = new String[55];
  
  ee = new String[55];
    ee[0] = " this is ";
    ee[1] = "the garden ";
    ee[2] = "colours: ";
    ee[3] = "come and go ";
    ee[4] = "frail azures ";
    ee[5] = "fluttering ";
    ee[6] = "from night's ";
    ee[7] = "outer wing ";
    ee[8] = "strong ";
    ee[9] = "silent ";
    ee[10] = "greens ";
    ee[11] = "silently lingering ";
    ee[12] = "absolute lights ";
    ee[13] = " like ";
    ee[14] = "baths of golden snow. ";
    ee[15] = "This is the ";
    ee[16] = "garden ";
    ee[17] = ": pursed lips do blow";
    ee[18] = "upon ";
    ee[19] = "cool flutes ";
    ee[20] = "within ";
    ee[21] = "wide glooms ";
    ee[22] = "and sing ";
    ee[23] = "(of harps celestial to ";
    ee[24] = " the quivering string) ";
    ee[25] = "invisible faces ";
    ee[26] = "hauntingly and slow. ";
    ee[27] = "This is the garden. ";
    ee[28] = "Time ";
    ee[29] = "shall surely ";
    ee[30] = "reap ";
    ee[31] = "and on ";
    ee[32] = "Death's blade ";
    ee[33] = "lie ";
    ee[34] = "many a flower curled, ";
    ee[35] = "in other ";
    ee[36] = "lands ";
    ee[37] = "where ";
    ee[38] = "other ";
    ee[39] = "songs be sung ";
    ee[40] = "; yet stand ";
    ee[41] = "They ";
    ee[42] = "here ";
    ee[43] = "enraptured, ";
    ee[44] = "as among ";
    ee[45] = "the slow deep ";
    ee[46] = "trees perpetual ";
    ee[47] = "of sleep ";
    ee[48] = "some ";
    ee[49] = "silver-fingered ";
    ee[50] = "fountain ";
    ee[51] = "steals ";
    ee[52] = "the ";
    ee[53] = "world ";
    ee[54] = ".";
  
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
