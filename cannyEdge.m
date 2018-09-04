  clc;
  close all;
 
  
  img = imread('C:\Users\hp\Desktop\pro\c7.jpg'); %garbbing an image
  B = imresize(img, [400 300]); %resizing it
  G = rgb2gray(B);   %converting it into gray
  BW = edge(G,'canny',0.6); %finding the edges
  se = ones(30,30);
  IM2 = imdilate(BW,se); %dilsting the image
  
  
  subplot(1,3,1); %plotting orignal resized image
  imshow(B);
  title('Resized orignal image');
  
  subplot(1,3,2);  %plotting edge detected image
  imshow(BW);
  title('Edge detection');
  
  subplot(1,3,3);  %plotting dialated image
  imshow(IM2);
  title('Dialated image');
  
  
  L= find(IM2==1);  %keeping all the '1s' in an array
  p = numel(L);  % calculate number of white/'1s'  pixels 
  
  if( p < 8000 ) %checking the condition
   
   disp(p); %displaying number of white pixel
   disp('clear road');
      
  else
       
   c= 1;  %setting the variable to 1
   s = serial('COM8','BaudRate',9600);   %setting up serial communication
   fopen(s); %open serial communication 
   pause(1);
   fprintf(s, '%i', c); %printing the value in serial port
   fclose(s);  %close serial communication 
   
      disp( p);
      disp('pothole ahead');
     
     
  end
  
  

  
 
  //////////////////////////////////////////////////////
  put this in your ardiuno ide and upload to ardiuno
  /////////////////////////////////////////////////////
  #include <SoftwareSerial.h>
int buzzer = 6;
char r = 0;
SoftwareSerial mySerial(10, 11); 
void setup() {
  
  Serial.begin(9600);
  mySerial.begin(9600);
  pinMode(buzzer,OUTPUT);
 
}

void loop() {  
  if (mySerial.available() ) {
    
    r =  mySerial.read();
    Serial.println(r);
    
  }

 if(r == '1') {

  for (int i=0; i<=4; i++){
          digitalWrite(buzzer,HIGH);
          delay(200);
          digitalWrite(buzzer,LOW);
          delay(200);
             }
      r = 0;
      }
      else{
        digitalWrite(buzzer,LOW);
               
              }
}

