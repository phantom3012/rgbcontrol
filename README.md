# RGB LED control 

Controlling the light in your room from a thousand miles away had never been simpler

## The Basics

This code can control a basic RGB LED through a flutter app. Before we move ahead on the actual working, more about the app:

## The App
The app is a (not so quite) simple flutter app that allows you to select the precise color you need through multiple ways: RGB sliders, HEX input and a free colour picker. 
The selected colour is interconverted between HEX values and RGB values just to display to the user, but ultimately, the R,G and B values are sent separately to a Firebase RTDB
<img src="https://user-images.githubusercontent.com/78027544/142406477-fd09d536-315a-4aa1-b300-5588b7eb2781.jpg" width="50%" height="50%">
<img src="https://user-images.githubusercontent.com/78027544/142406499-6507093c-501a-4488-a420-61b832dda95b.jpg" width="50%" height="50%">
![rtdb](https://user-images.githubusercontent.com/78027544/142406822-838960b0-c7a2-49b3-8807-3d809f018955.jpg)

And that's about the functionality of the app. Moving on to the hardware
## The hardware
The microcontroller used here is the NodeMCU ESP8266. After this, I had to wire it up to the RTDB and pull the RGB values. Once we pulled the raw values, we can simply command the respective GPIO pins of the NodeMCU to write the respective analog RGB values.



https://user-images.githubusercontent.com/78027544/142407165-dde7501a-293f-49de-98f3-f9502b08b082.mp4



General note: 
The .ino file that was loaded onto the Node is available in the folder RGBcontrol
