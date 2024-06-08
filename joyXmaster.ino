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

Description - this code is uploaded to the arduino emulator
              standalone-USB capable board must be used for this code...
              upload can be tricky...MUST PRESS RESET BUTTON ON ARDUINO TWICE WHILE THE CONSOLE DIAPLYS 'UPLOADING...'
              enable verbose output in preferences
              note that the XInput library for respective board is installed and selected in the boards manager

refer for XInput setup - https://github.com/dmadison/ArduinoXInput
*/

#include <XInput.h>
#include <Wire.h>

char instr[] = "0000111100000000000";
int ii = 0;

void setup() 
{
  //initializing Wire as Master
  Wire.begin();

  //range set for Joystick....actions on processing side is advised...
	XInput.setJoystickRange(1, 9);  // Set joystick range to the ADC
	XInput.setAutoSend(false);  // Wait for all controls before sending
	XInput.begin();

  delay(3000);
}

void loop()
{
  // requesting the data from the slave arduino through I2C
  Wire.requestFrom(9,19);// slave address and number of bytes to be requested respectively
  
  while(Wire.available()) 
  {
      char b = Wire.read();
      if(ii<19)
      {
        instr[ii] = b;
        ii++;
      }
  }
  ii=0;

  // the string outstr corresponds
  // [ 0A, 1B, 2X, 3Y, 4LX, 5LY, 6RX, 7RY, 8LT, 9RT, 10RB, 
  // 11LB, 12LoB, 13StB, 14BaB, 15UP, 16DOWN, 17LEFT, 18RIGHT ]
  
  //converting recieved char values into boolean and int respectively
  boolean aa = instr[0] - '0';
  boolean bb = instr[1] - '0';
  boolean xx = instr[2] - '0';
  boolean yy = instr[3] - '0';

  int lx = instr[4] - '0';
	int ly = instr[5] - '0';

  int rx = instr[6] - '0';
	int ry = instr[7] - '0';

  boolean lt = instr[8] - '0';
	boolean rt = instr[9] - '0';

  boolean rb = instr[10] - '0';
  boolean lb = instr[11] - '0';

  boolean lo = instr[12] - '0';
  boolean st = instr[13] - '0';
  boolean ba = instr[14] - '0';

  boolean up = instr[15] - '0';
  boolean down = instr[16] - '0';
  boolean left = instr[17] - '0';
  boolean right = instr[18] - '0';

	// Set XInput buttons
	XInput.setButton(BUTTON_A, aa);
	XInput.setButton(BUTTON_B, bb);
	XInput.setButton(BUTTON_X, xx);
	XInput.setButton(BUTTON_Y, yy);

	XInput.setButton(BUTTON_LB, lb);
	XInput.setButton(BUTTON_RB, rb);

	XInput.setButton(BUTTON_L3, 0);
	XInput.setButton(BUTTON_R3, 0);

	// Set XInput DPAD values
	XInput.setDpad(up, down, left, right);

  XInput.setButton(TRIGGER_LEFT, lt);
	XInput.setButton(TRIGGER_RIGHT, rt);

  XInput.setButton(BUTTON_LOGO, lo);
  XInput.setButton(BUTTON_START, st);
  XInput.setButton(BUTTON_BACK, ba);

	XInput.setJoystick(JOY_LEFT, lx, ly);
  XInput.setJoystick(JOY_RIGHT, rx, ry);

	// Send control data to the computer
	XInput.send();
  
}