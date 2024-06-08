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

class DPADbuton
{
  int x;
  int y;
  int dia;
  
  
  DPADbuton(int xx, int yy, int diam)
  {
    x = xx;
    y = yy;
    dia = diam;
  }
  
  void display(int bup)
  {
    strokeWeight(2);
    stroke(120, 120, 120);
    fill(120, 120, 120);
    rect(x, y, dia-bup*2.5, dia-bup*2.5, 5);
    rectMode(RADIUS);
  }
}
