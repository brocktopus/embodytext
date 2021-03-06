/*---------------------------------------
 
 @project   emBody(dekaaz) {
 @authors   David M Rieder & Kevin Brock
 @year      2011
 @descript  Kinect-based exploration
 of embodied textuality
 
 @Conference on Composition and Communication,
  St. Louis, MO, March 21-24 2012
 
 For more: http://www4.ncsu.edu/~dmrieder/
 http://www4.ncsu.edu/~kmbrock/
 
 Copyright (C) 2012 David Rieder and Kevin Brock
 
 This program is free software: you can redistribute it 
 and/or modify it under the terms of the GNU General 
 Public License as published by the Free Software 
 Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be
 useful, but WITHOUT ANY WARRANTY; without even the 
 implied warranty of MERCHANTABILITY or FITNESS FOR A 
 PARTICULAR PURPOSE.  See the GNU General Public License 
 for more details.
 
 You should have received a copy of the GNU General 
 Public License along with this program.  If not, see 
 <http://www.gnu.org/licenses/>.
 ----------------------------------------*/

/*
First - you'll need the libfreenect drivers available
 from OpenKinect ( http://openkinect.org/ ).
 */
import dLibs.freenect.toolbox.*;
import dLibs.freenect.constants.*;
import dLibs.freenect.interfaces.*;
import dLibs.freenect.*;

/*
Importing Twitter4J (http://www.twitter4j.org) for Twitter searches.
 */
import twitter4j.conf.*;
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.json.*;
import twitter4j.internal.util.*;
import twitter4j.management.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;
import twitter4j.internal.json.*;

/*
This project can use OpenGL or P3D; if you find OpenGL
 is running too slowly on your machine, switch over to P3D
 and you'll likely find a much faster response time at the
 expense of some rendering smoothness.
 
 NOTE: This line should be unnecessary for Processing 2.0.
 */
import processing.opengl.*;

/*
We also use the Sonia library ( http://sonia.pitaru.com/ )
 to handle the sound files that pan in and out when certain
 depth fields are registered by users interacting with the Kinect.
 You can find out more about these sound files in the 
 'Sonia' file/tab.
 */
import pitaru.sonia_v2_9.*; // automatically created when importing sonia using the processing menu.
Sample s1; //forest birds sample (background)
Sample s2; //keyboard sounds
Sample s3; //bees buzzing
Sample s4; //magneto-electrical noise
Sample s5; //water in stream
Sample s6; //bugs in meadow

PFont font; 

Boolean zoom, backforth;

Kinect kinect_;  
KinectFrameVideo kinect_video_; 
KinectFrameDepth kinect_depth_;      

Kinect3D k3d_;                       
KinectCalibration calibration_data_; 

PImage video_frame_, b;

String[] ee, ee2;
String fortyeight, patchwork;

color[] colors;

int depthnum, depthpast, colReverse, pastframe, pastdepth, iterator, gap, gapy, c, counter, lastMillis, currentMillis, depthHeight, ii;

int[] cam, depthLevels;

float camx, camy, camz, transy, increment, i;

TwitterFactory twitterFactory;
Twitter twitter;
int lastTime;
/*
The 'interval' below is the number in seconds between
searches.
*/
int interval = 10;
int countdown = 0;

/*
This next variable is important!
It contains the text we're searching for in order
to populate our virtual environment:
*/
String queryStr = "your text here!";

/*
I based the max # to be searched on the number of split
array elements used for the ee cummings poem.

(These two variables should be unnecessary. I'll check them soon.)
*/
int max_tweets = 55;
String[] tweets_test;


//---------------------------------------------------------------
void setup() {

  size(1024, 768, P3D);

  connectTwitter();
  getSearchTweets();

  background(0);

  /*
  These three functions set up the colors, sound files, and 
   poem 'chunks' to be called at various field depths.
   */
  initializeEE();
  initializeSONIA();
  initializeCOLORS();

  font = loadFont("Tunga-Bold-24.vlw");

  kinect_ = new Kinect(0);  

  depthHeight = 0;

  kinect_video_ = new KinectFrameVideo(VIDEO_FORMAT._BAYER_   );     
  kinect_depth_ = new KinectFrameDepth(DEPTH_FORMAT._11BIT_);

  k3d_ = new Kinect3D(); 
  k3d_.setFrameRate(30); 

  kinect_depth_.connect(kinect_);
  k3d_.connect(kinect_);

  calibration_data_ = new KinectCalibration();
  calibration_data_.fromFile("kinect_calibration_red.yml", null); 
  k3d_.setCalibration(calibration_data_);

  gap = 20;
  gapy = 20;
  increment = 1.5;
  lastMillis = floor(millis() * .001);
  depthLevels = new int[14];
  iterator = 0;
  ii = 6;
  pastdepth = 2;
  transy = 0;
  backforth = true;
}

void draw() {
  countdown = ((millis()-lastTime)/1000);
  while (countdown > interval)
  {
    getSearchTweets();
    countdown = 0;
    lastTime = millis();
  } 


  smooth();

// This sets up our 'wandering' camera based on a user's movement.
  camera(camx, camy, 200, width/2, height/2, camz, 0.0, 1.0, 0.0);

// Uncomment the next line if you want a 'static' camera instead.
// camera(width/2, height/2, 200, width/2, height/2, camz, 0.0, 1.0, 0.0);

  c = 0;
  counter = 0;

  iterator += 5;
  ;

  background(0);

  KinectPoint3D kinect_3d[] = k3d_.get3D();

  textAlign(CENTER);
  textFont(font);
  textSize(20);     
  for (int row = 0; row < 480; row += 8) { // 64
    for (int col = 0; col < 640; col += 8) { // 48

      /*
  The Kinect's output is not "mirrored" in the sense we think of,
       so if you look at its conventional output to the computer
       screen, it will appear "off" as it shows what it "sees" through
       its sensors.
       
       The following line sets up the mirroring effect by transposing
       the horizontal output to be backwards from its default.
       */
      colReverse = int(map(col, 0, 640, 640, 0));

      c++;

      float cz = kinect_3d[row * 640 + colReverse].z;

      //----Farthest depth, 3.5 meters-----------------------------

      /*
The fundamental mechanism for our project is that a point is
       checked for its distance from the Kinect. After registering which
       depth level the point's content exists "within," the appropriate
       letter from that level's text content is drawn onto the screen
       in Processing's 3D space. Then, the next point (8 pixels from
       the last) is checked, and the process is repeated.
       */

      // Depth Level 4  
      if ((cz < -2.751) && (cz > -3.000)) {
        fill(colors[5]);
        text(ee2[9].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -2.751, -3.000, -501, -550));
        depthLevels[4]++;
      }

      // Depth Level 5    
      else if ((cz < -2.501) && (cz > -2.750)) {
        fill(colors[6]);
        text(ee2[8].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -2.501, -2.750, -451, -500));
        depthLevels[5]++;
      }

      // Depth Level 6   
      else if ((cz < -2.251) && (cz > -2.500)) { 
        fill(colors[7]);
        text(ee2[7].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -2.251, -2.500, -401, -450));
        depthLevels[6]++;
      }

      // Depth Level 7   
      else if ((cz < -2.001) && (cz > -2.250)) {
        fill(colors[8]);
        text(ee2[6].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -2.001, -2.250, -351, -400));
        depthLevels[7]++;
      }

      // Depth Level 8   
      if ((cz < -1.751) && (cz > -2.000)) { 
        fill(colors[0]);
        text(ee2[5].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -1.751, -2.000, -301, -350));
        depthLevels[8]++;
      }

      // Depth Level 9   
      else if ((cz < -1.501) && (cz > -1.750)) {
        fill(colors[10]);
        text(ee2[4].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -1.501, -1.750, -251, -300));
        depthLevels[9]++;
      }

      // Depth Level 10  
      else if ((cz < -1.251) && (cz > -1.500)) {
        fill(colors[11]);
        text(ee2[3].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -1.251, -1.500, -201, -250));
        depthLevels[10]++;
      }

      // Depth Level 11   
      else if ((cz < -1.001) && (cz > - 1.250)) {
        fill(colors[12]);
        text(ee2[2].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -1.001, -1.250, -151, -200));
        depthLevels[11]++;
      }
      // Depth Level 12   
      else if ((cz < -0.751) && (cz > - 1.000)) {
        fill(colors[13]);
        text(ee2[1].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -0.751, -1.000, -101, -150));
        depthLevels[12]++;
      }
      // Depth Level 13  
      else if ((cz < -0.500) && (cz > - 0.750)) {
        fill(colors[14]);
        text(ee2[0].charAt(c), gap + (col * increment), gapy + (row * increment), map(cz, -0.500, -0.750, -51, -100));
        depthLevels[13]++;
      }

      //-----------End of depths---------------------------------------           

      //-----END OF FOR LOOPS
    }
  } 

  for (int o = 1; o < depthLevels.length; o++) {
    if (depthLevels[depthnum] < depthLevels[o]) {
      depthnum = o;
    }
  }

  forestPanVol(depthnum);

  changeDepth(depthnum);

  for (int q = 0; q < depthLevels.length; q++) {
    depthLevels[q] = 0;
  }

  //------END OF DRAW()
}

//-----Additional functions--------------


void forestPanVol(int d) {

  s1.setPan(map(d, 4, 10, -1.0, 1.0), 1);
  s1.setPan(map(d, 4, 10, -1.0, 1.0), 0);
}

void dispose() {
  Kinect.shutDown(); 
  super.dispose();
}































//-- Fin.

