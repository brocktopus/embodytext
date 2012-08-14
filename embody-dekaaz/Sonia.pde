
void initializeSONIA() {
 
 // depthnum is 0 - 13
 // 13 is the closest
 
 
 /*
 Each of the .wav files used in this project was procured via
 ( http://www.freesound.org ) - the ID for each sound file is the 
 numerical string at the beginning of the file name listed below
 */
  
 Sonia.start(this);
    s1 = new Sample("28239__herbertboland__forestbirds.wav"); //background (changing pan value)
    s2 = new Sample("44796__gezortenplotz__nyc-street-leve02l.wav"); //background (unchanging pan value)
    s3 = new Sample("13533__acclivity__bumblebee.wav"); //13-10
    s4 = new Sample("13533__acclivity__bumblebee.wav"); //9 - 7
    s5 = new Sample("76392__paul-mcnelis__stream-0725-110928.wav"); // 6 - 3
    s6 = new Sample("53380__eric5335__meadow-ambience.wav"); //3 - 0  

    i = 0.0;
    
    s1.setVolume(0,0);
    s1.setVolume(0,1);
    s2.setVolume(1,0);
    s2.setVolume(1,1);
    s3.setVolume(0,0);
    s3.setVolume(0,1);
    s4.setVolume(0,0);
    s4.setVolume(0,1);
    s5.setVolume(0,0);
    s5.setVolume(0,1);
    s6.setVolume(0,0);
    s6.setVolume(0,1);
    s1.repeat(); 
    s2.repeat();
    s3.repeat();
    s4.repeat();
    s5.repeat();
    s6.repeat();
    
}
