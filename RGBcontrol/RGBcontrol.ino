#include <Firebase.h>
#include <FirebaseArduino.h>
#include <FirebaseCloudMessaging.h>
#include <FirebaseError.h>
#include <FirebaseHttpClient.h>
#include <FirebaseObject.h>

#include<ESP8266WiFi.h>

#define FIREBASE_HOST "rgb-control-317ba-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "8rVBD1gysryqMp4W0Ak9nOvz3hLWflWswFfd36s1"
#define WIFI_SSID "tadinadahome"
#define WIFI_PASS "k@v@pr@M1312"

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
//  digitalWrite(LED_BUILTIN,LOW);
//  delay(1000);
//  digitalWrite(LED_BUILTIN,HIGH);
//  delay(1000);     
}
