/*

MIT License

Copyright (c) 2024 Prashaanth

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

##################################################

Writer - LucifrBrkr @ Prashaanth
last Modified - 08 Jun 2024
**Part of CompConX**

https://github.com/LucifrBrkr/CompConX

Description - this code is run in laptop2 to map the keyboard inputs, encode them and send them to the slave arduino through Serial
              click and activate GUI before use
              
note - to be run only after the slave arduino is programmed and connected.
*/

  
//############################################################
  

import processing.serial.*;

  
//############################################################
  
//defining image objects
PImage controllerIMG;
PImage logoIMG;

  
//############################################################
  
  
//declaration of control units

boolean Abutton, Bbutton, Xbutton, Ybutton; // ABXY keys
boolean JLleft, JLright, JLfront, JLback;   // joystick move
boolean JRleft, JRright, JRup, JRdown;      // joystick view
boolean trigL, trigR;                       // trigger L and R
boolean bumpL, bumpR;                       // bumper L and R
boolean startB, backB, logoB;               // start, back, logo Buttons
boolean upB, downB, leftB, rightB;          // DPAD buttons

  
//############################################################
  
  
//declaration of graphic components

JoyBack JLbase, JRbase, DPADbase, ABXYbase, LogoButtonBase, StartButtonBase, BackButtonBase;
JoyStick JLstick, JRstick;
Buton LogoB, StartB, BackB;
Buton Abut, Bbut, Xbut, Ybut;
TrigButon TrigL, TrigR, BumpL, BumpR;
DPADbuton Bup, Bdown, Bleft, Bright, Baes;

  
//############################################################
  
  
// values required for GUI

int stickMove = 25;

  
//############################################################
  
  
// Set your max and min joystick values here

int valJRx,valJRy = 0;
int valJLx,valJLy = 0;

  
//############################################################
  
//setting up remote max and min joystick values range - 1 to 9, mid - 5
int JLxMAX = 8;
int JLxMIN = 2;
int JLyMAX = 8;
int JLyMIN = 2;

int JRxMAX = 8;
int JRxMIN = 2;
int JRyMAX = 8;
int JRyMIN = 2;

  
//############################################################
  
  
// the string that will carry the commands to the arduino through serial
// outstr corresponds 
// [ 0A, 1B, 2X, 3Y, 4LX, 5LY, 6RX, 7RY, 8LT, 9RT, 10RB, 
// 11LB, 12LoB, 13StB, 14BaB, 15UP, 16DOWN, 17LEFT, 18RIGHT ]

String outstr = "0000000000000000000";

// value collection array

int[] arr = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

  
//############################################################
  
  
// initialization of serial channel port
Serial port;


void setup() 
{
  //canvas setup
  size(800, 800);
  
  
  //############################################################
  
  
  // images for the GUI
  controllerIMG = loadImage("xbc.png");
  logoIMG = loadImage("xboxlogo1.png");
  
  
  //############################################################
  
  
  // initialization of GUI components
  
  JLbase = new JoyBack(215,310,110);
  JLstick = new JoyStick(215, 310, 70);  
  
  JRbase = new JoyBack(480,410,100);
  JRstick = new JoyStick(480, 410, 60);
  
  LogoButtonBase = new JoyBack(400,320,60);
  LogoB = new Buton(400,320,true,50);
  StartB = new Buton(460, 320, false, 40);
  BackB = new Buton(340, 320, false, 40);
  
  ABXYbase = new JoyBack(575,310,130);
  Abut = new Buton(575,340+5,false,40);
  Bbut = new Buton(605+5,310,false,40);
  Xbut = new Buton(545-5,310,false,40);
  Ybut = new Buton(575,280-5,false,40);
  
  TrigL = new TrigButon(210,127,40,45, 70,20,5,5);
  TrigR = new TrigButon(590,127,40,45, 20, 70, 5,5);
  BumpL = new TrigButon(210,210,40,30, 5,5,0,0);
  BumpR = new TrigButon(590,210,40,30, 5, 5, 0,0 );
  
  DPADbase = new JoyBack(320,410,100);
  Bup = new DPADbuton(320,390, 15);
  Bdown = new DPADbuton(320,430, 15);
  Bleft = new DPADbuton(300,410, 15);
  Bright = new DPADbuton(340,410, 15);
  Baes = new DPADbuton(320, 410, 15);

  
  //############################################################
  
  
  // List all the available serial ports in the output pane.
  // You will need to choose the port that the Arduino board is connected to from this list.
  // The first port in the list is port #0 and the third port in the list is port #2.
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());
  
  // Open the port that the Arduino board is connected to (in this case #0)
  // Make sure to open the port at the same speed Arduino is using (9600bps here)
  
  port = new Serial(this, Serial.list()[0], 9600);
  delay(2000);
}

void draw()
{
  background(0);
  
  
  //############################################################
  

  //mapping values for ABXY buttons
  
  if(Abutton == true)
  {
    arr[0] = 1;
  }else
  {
    arr[0] = 0;
  }
  
  if(Bbutton == true)
  {
    arr[1] = 1;
  }else
  {
    arr[1] = 0;
  }
  
  if(Xbutton == true)
  {
    arr[2] = 1;
  }else
  {
    arr[2] = 0;
  }
  
  if(Ybutton == true)
  {
    arr[3] = 1;
  }else
  {
    arr[3] = 0;
  }
  
  
  //############################################################
  
  
  //mapping the values for left joystick
  
  if(JLleft == true)
  {
    arr[4] = JLxMIN;
    valJLx = -stickMove;
  }else if(JLright == true)
  {
    arr[4] = JLxMAX;
    valJLx = stickMove;
  }else
  {
    arr[4] = 5;
    valJLx = 0;
  }
  
  
  if(JLfront == true)
  {
    arr[5] = JLyMAX;
    valJLy = -stickMove;
  }else if(JLback == true)
  {
    arr[5] = JLyMIN;
    valJLy = stickMove;
  }else
  {
    arr[5] = 5;
    valJLy = 0;
  }
  
  
  //############################################################
  
  
  //mapping the values for right joystick\
  
  if(JRleft == true)
  {
    arr[6] = JRxMIN;
    valJRx = -stickMove;
  }else if(JRright == true)
  {
    arr[6] = JRxMAX;
    valJRx = stickMove;
  }else
  {
    arr[6] = 5;
    valJRx = 0;
  }
  
  
  if(JRup == true)
  {
    arr[7] = JRyMAX;
    valJRy = -stickMove;
  }else if(JRdown == true)
  {
    arr[7] = JRyMIN;
    valJRy = stickMove;
  }else
  {
    arr[7] = 5;
    valJRy = 0;
  }  
  
  
  //############################################################
  
  
  //mapping values for trigger buttons
  
  if(trigL == true)
  {
    arr[8] = 1;
  }else
  {
    arr[8] = 0;
  }
  
  if(trigR == true)
  {
    arr[9] = 1;
  }else
  {
    arr[9] = 0;
  }
  
  
  //############################################################
  
  
  //mapping values for bumper button
  
  if(bumpR == true)
  {
    arr[10] = 1;
  }else 
  {
    arr[10] = 0;
  }
  
  if(bumpL == true)
  {
    arr[11] = 1;
  }else 
  {
    arr[11] = 0;
  }
  
  
  //############################################################
  
  
  //mapping values for logo, start and back buttons
  
  if(logoB == true)
  {
    arr[12] = 1;
  }else 
  {
    arr[12] = 0;
  }
  
  if(startB == true)
  {
    arr[13] = 1;
  }else 
  {
    arr[13] = 0;
  }
  
  if(backB == true)
  {
    arr[14] = 1;
  }else 
  {
    arr[14] = 0;
  }
  
  
  //############################################################
  
  
  //mapping values for DPAD
  
  if(upB == true)
  {
    arr[15] = 1;
  }else
  {
    arr[15] = 0;
  }
  
  if(downB == true)
  {
    arr[16] = 1;
  }else
  {
    arr[16] = 0;
  }
  
  if(leftB == true)
  {
    arr[17] = 1;
  }else
  {
    arr[17] = 0;
  }
  
  if(rightB == true)
  {
    arr[18] = 1;
  }else
  {
    arr[18] = 0;
  }
  
  
  //############################################################
  
  
  // encoding the values from arr to outstr
  outstr = "";
  for(int i=0; i<19; i+=1)
  {
    outstr += str(arr[i]);
  }

  // Sending outstr through Serial to arduino
  port.write(outstr);
  
  
  //############################################################
  
  
  // GUI diaplay
  
  image(controllerIMG,400,400, 800, 800);
  fill(32,32,32);
  textSize(50);
  text(outstr, 165,700);
  
  JLbase.display();
  DPADbase.display();
  JLstick.display(valJLx, valJLy);
  
  JRbase.display();
  JRstick.display(valJRx, valJRy);
  
  ABXYbase.display();
  Abut.display(arr[0],47,136,87);
  Bbut.display(arr[1],154,39,37);
  Xbut.display(arr[2],56,109,139);
  Ybut.display(arr[3],154,118,55);
  
  TrigL.display(arr[8]);
  TrigR.display(arr[9]);
  BumpL.display(arr[11]);
  BumpR.display(arr[10]);
  
  LogoButtonBase.display();
  LogoB.display(arr[12],0,0,0);
  StartB.display(arr[13],90,130,90);
  BackB.display(arr[14],130,90,90);
  
  Bup.display(arr[15]);
  Bdown.display(arr[16]);
  Bleft.display(arr[17]);
  Bright.display(arr[18]);
  Baes.display(1);
  
}

  
//############################################################
  

// keyboard mapping

void keyPressed()
{
  if(key == 32)Abutton = true;
  if(key == 'x')Bbutton = true;
  if(key == 'u')Xbutton = true;
  if(key == 'o')Ybutton = true;
  
  if(key == 'a')JLleft = true;
  if(key == 'd')JLright = true;
  if(key == 'w')JLfront = true;
  if(key == 's')JLback = true;
  
  
  if(key == 'j')JRleft = true;
  if(key == 'l')JRright = true;
  if(key == 'i')JRup = true;
  if(key == 'k')JRdown = true;
  
  
  if(key == 'q')trigL = true;
  if(key == 'e')trigR = true;
  
  if(key == 'p')bumpR = true;
  if(key == 'm')bumpL = true;
  
  if(key == 't')logoB = true;
  if(key == 'y')startB = true;
  if(key == 'r')backB = true;
  
  if(keyCode == 38)upB = true;
  if(keyCode == 40)downB = true;
  if(keyCode == 37)leftB = true;
  if(keyCode == 39)rightB = true;
}

void keyReleased()
{
  if(key == 32)Abutton = false;
  if(key == 'x')Bbutton = false;
  if(key == 'u')Xbutton = false;
  if(key == 'o')Ybutton = false;
  
  if(key == 'a')JLleft = false;
  if(key == 'd')JLright = false;
  if(key == 'w')JLfront = false;
  if(key == 's')JLback = false;
  
  
  if(key == 'j')JRleft = false;
  if(key == 'l')JRright = false;
  if(key == 'i')JRup = false;
  if(key == 'k')JRdown = false;
  
  
  if(key == 'q')trigL = false;
  if(key == 'e')trigR = false;
  
  if(key == 'p')bumpR = false;
  if(key == 'm')bumpL = false;
  
  if(key == 't')logoB = false;
  if(key == 'y')startB = false;
  if(key == 'r')backB = false;
  
  if(keyCode == 38)upB = false;
  if(keyCode == 40)downB = false;
  if(keyCode == 37)leftB = false;
  if(keyCode == 39)rightB = false;
}
