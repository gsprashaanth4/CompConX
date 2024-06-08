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

Description - this code is uploaded to the arduino board between Laptop2 and the controller emulating arduino.
              recieves the keyValues through Serial from Processing and sends it to the emulating arduino through I2C.
              Standalone-USB capable arduino NOT NECESSARY for this part.
*/

#include <Wire.h>
char instr[] = "0000111100000000000";
int ii = 0;

void setup()
{
  // initializing Wire as Slave
  Wire.begin(9);
  Wire.onRequest(requestEvent);

  Serial.begin(9600);
}

void loop()
{
  //to collect keyValues from Processing...

  while(Serial.available())
  {
    char b = Serial.read();
    if(ii<19)
      {
        instr[ii] = b;
        ii++;
      }
  }
  ii=0;

}


void requestEvent()
{
  //to send collected values to emulator arduino through I2C,

  // Setup byte variable in the correct size
  byte response[19];
  
  // Format answer as array
  for (byte i=0 ; i<19 ; i++)
  {
    response[i] = (byte)instr[i];
  }
  // Send response back to Master
  Wire.write(response,sizeof(response));

}