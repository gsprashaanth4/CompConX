# CompConX
warning: you may find the content below, as a waste of your time.... :/  

## About
{cheap joke} This project is the result of my inability to be idle while waiting for college... :|  

{actual content}
cause of events,  
1* i really wanted to play 'It takes Two'...  
2* But the controller i had tunred to dust... :/  
3* i then did wht evry reasonble guy would do, started playing modern warfare 2... :/  
4* but, i really wanted to play 'It takes Two'...  
5* so i did wht you'd do, but controllers would empty my allowance... :/  
6* so i turned my second laptop into my controller, Hence born CompConX... ;)  

keyPoints.exe... :#    
*Processing, to map key inputs from laptop2  
*1st arduino to recieve the keyValues from processing through Serial  
*2nd arduino {bruh emulates an XBOX controller through XInput}, recieves the keyValues, maps it to XBOX controls, sends commands to laptop1  
*laptop1 is dumb enough to think it's a controller... :/  

note: standalone-USB capable arduino's must be used...leonardo used here.  

## Shots
these images and videos were shot with the arduinos connected to the same laptop for shooting purposes {my other laptop was definitely not battery dead... :/ }


### the GUI v.1  

![Screenshot 2024-06-08 233543](https://github.com/LucifrBrkr/CompConX/assets/172132985/5e99ddc9-764a-4f90-9a42-7131989a719e)  


### the GUI v.2  

i thought it might be a good idea to just activate a screen and display the signals...but meh..  

![Screenshot 2024-06-08 233450](https://github.com/LucifrBrkr/CompConX/assets/172132985/40dc4914-7178-48c9-bf9a-09a545234707)  

Notice the first two programs only recorded 11 bytes of data, this is because they were tailored for It takes Two  
The next version recorded 19 bytes of data approaching complete controller emulation... :]  


### the GUI v.3  

look at that beauty, real piece of work... :))  

![Screenshot 2024-06-08 230947](https://github.com/LucifrBrkr/CompConX/assets/172132985/be764e65-95b9-4805-870e-db87a848c46a)  

in Action...  

https://github.com/LucifrBrkr/CompConX/assets/172132985/f5373638-5a4d-4609-bf7b-d56e7792d7fd  

### the Setup  

The two arduinos connected via I2C...  

![Screenshot 2024-06-08 232652](https://github.com/LucifrBrkr/CompConX/assets/172132985/97e2bb59-4fa7-4d5e-86d5-bd7f2f09aa73)  

## Important Links
https://github.com/dmadison/ArduinoXInput_AVR  
https://dronebotworkshop.com/i2c-arduino-arduino/  
https://hardwaretester.com/gamepad  





