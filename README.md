# RGB LED control 

Controlling the light in your room from a thousand miles away had never been simpler

## The Basics

Yeah, the title was catchy, but I'll be honest: right now this code can only control a basic RGB LED through a flutter app. Before we move ahead on the actual working, more about the app:

## The App
The app is a (not so quite) simple flutter app that allows you to select the precise color you need through multiple ways: RGB sliders, HEX input and a free colour picker. 
The selected colour is interconverted between HEX values and RGB values just to display to the user, but ultimately, the R,G and B values are sent separately to a Firebase RTDB. 
And that's about the functionality of the app. Moving on to the hardware

## The hardware
The microcontroller used here is the NodeMCU ESP8266. Chosen cus it was the first hit I got for a WiFi module. Also, I chose the NodeMCU and not just the ESP8266 module, because that significantly increased the ease of portability (no requirement of an extra arduino board for control). All that was left to do was to wire it up to the RTDB and pull the RGB values. Once we pulled the raw values, the rest is cakewalk

And that was about it for the project. 

General note: 
The .ino file that was loaded onto the Node is available in the folder RGBcontrol
