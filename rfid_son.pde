import touchatag.*;
import processing.sound.*;

Touchatag rfid;
PFont font;
int numOfReaders = 1;
String[][] readers = new String[numOfReaders][1];

int numOfTags = 14;
String sound_dir = "sounds/";

String[] tags  = new String[numOfTags];
String[] sounds  = new String[numOfTags];

SoundFile sfile;

int prevTag = -1;
int nextTag = -1;

void setup() 
{  
  rfid = new Touchatag(this, numOfReaders);
  
  tags[0] = "04dabf193e2580";
  tags[1] = "04d9b3193e2580";
  tags[2] = "04c52e193e2580";
  tags[3] = "04cd02193e2584";
  tags[4] = "04dcfc193e2580";
  tags[5] = "04d367193e2580";
  tags[6] = "04b714193e2584";
  tags[7] = "04d3c8193e2580";
  tags[8] = "04d47f193e2580";
  tags[9] = "0403da193e2581";
  tags[10] = "04f8eb193e2580";
  tags[11] = "04f18a193e2580";
  tags[12] = "04b044193e2580";
  tags[13] = "04c538193e2580";
  
  sounds[0] = sound_dir+"A1-sound.mp3";
  sounds[1] = sound_dir+"B1-sound.mp3";
  sounds[2] = sound_dir+"B2-sound.mp3";
  sounds[3] = sound_dir+"C1-sound.mp3";
  sounds[4] = sound_dir+"C2-sound.mp3";
  sounds[5] = sound_dir+"C3-sound.mp3";
  sounds[6] = sound_dir+"C4-sound.mp3";
  sounds[7] = sound_dir+"D2-sound.mp3";
  sounds[8] = sound_dir+"D3-sound.mp3";
  sounds[9] = sound_dir+"D5-sound.mp3";
  sounds[10] = sound_dir+"D8-sound.mp3";
  sounds[11] = sound_dir+"E2-sound.mp3";
  sounds[12] = sound_dir+"E4-sound.mp3";
  sounds[13] = sound_dir+"E7-sound.mp3";

  font = loadFont("Verdana-10.vlw");
  textFont(font);
  
  size(800, 400);
  
  rectMode(CENTER);
  stroke(0);
  fill(125);
}

void draw()
{
   background(255);
   
   int numReaders = rfid.On();
   
   if (numReaders != 0) 
   {
     drawReaders(numReaders);
   
     for (int i = 0; i < numReaders; i++) 
     {
       readers[i] = rfid.tagsOnReader(i);
       drawTags(readers[i], i);
     }  
   }
   
   if (nextTag != prevTag)
   {
     if (nextTag == -1) 
     {
       sfile.pause();
     }
     else
     {
       sfile = null;
       sfile = new SoundFile(this, sounds[nextTag]);
       sfile.loop();
     }
     
     prevTag = nextTag;
   }
}

void drawReaders(int num) {
  for (int i = 1; i <= num; i++) {
    rect(i * 200, 100, 50, 50);
  }
}

void drawTags(String[] tagList, int pos) {
  
  nextTag = -1;
  
  for (int i = 0; i < tagList.length; i++) {
    for (int j = 0; j < tags.length; j++) 
    {
      if (tags[j].equals(tagList[i]))
      {
        //println("yo");
        text(j, (pos + 1) * 175, (i * 10) + 150);
        
        nextTag = j;
      }
    }
  }
}
