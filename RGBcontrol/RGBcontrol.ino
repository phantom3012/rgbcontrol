#include <Firebase.h>
#include <FirebaseArduino.h>
//#include <FirebaseCloudMessaging.h>
#include <FirebaseError.h>
#include <FirebaseHttpClient.h>
//#include <FirebaseObject.h>

#include<ESP8266WiFi.h>

#define FIREBASE_HOST "firebasehost"
#define FIREBASE_AUTH "firebasekey"
#define WIFI_SSID "wifissid"
#define WIFI_PASS "wifipassword"

#define RedPin D2
#define GreenPin D3
#define BluePin D4

void setup() {
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID,WIFI_PASS);
  Serial.println("In setup..");
  Serial.print("connecting to WiFi");
  while(WiFi.status() !=WL_CONNECTED){
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.println("Established connected!\n IP:");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST,FIREBASE_AUTH);
}
int R,G,B;
void loop() {
  R=(int)Firebase.getFloat("Red");
  Serial.print("R: ");
  Serial.println(R);
  analogWrite(RedPin,R);
  G=(int) Firebase.getFloat("Green");
  Serial.print("G: ");
  Serial.println(G);
  analogWrite(GreenPin,G);
  B=(int) Firebase.getFloat("Blue");
  Serial.print("B: ");
  Serial.println(B);
  analogWrite(BluePin,B);
  if(Firebase.failed()){
    Serial.print("Error!");
    Serial.println(Firebase.error());
  }     
}
