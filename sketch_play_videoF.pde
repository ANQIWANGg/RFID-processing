import processing.serial.*; 
import processing.video.*;
Movie[] myMovie = new  Movie[4]; 
Movie movieToPlay;

Serial myPort; // Create object from Serial class 
String val; // Data received from the serial port
String[] card = new String[4];
void setup() {
  fullScreen ();
  String portName = Serial.list()[0] ; //*******check port number*********
  myPort = new Serial(this, portName, 9600);
  card[0] = "D6 14 C6 1A";
  card[1] = "C6 19 3D 25";
  card[2] = "D6 56 AB 1A";
  card[3] = "CC 88 65 A3";
  myMovie[0] = new Movie(this, "mymovie1.mp4");
  myMovie[1] = new Movie(this, "mymovie2.mp4");
  myMovie[2] = new Movie(this, "myvideo3.mp4");
  myMovie[3] = new Movie(this, "myvideo4.mp4");

  movieToPlay = myMovie[0]; 
  movieToPlay.frameRate(29.97);
  movieToPlay.loop( );
  frameRate(60);
}
void draw() {
  /*PShape part;
  part = createShape();
  part.beginShape(QUAD);
  part.noStroke();
  part.texture(movieToPlay);
  part.normal(0, 0, 1);
  part.vertex(0, 0, 0, 0);
  part.vertex(width, 0, movieToPlay.width, 0);
  part.vertex(width, height, movieToPlay.width, movieToPlay.height);
  part.vertex(0, height, 0, movieToPlay.height);
  part.endShape();
  shape(part);*/
  image (movieToPlay, 0, 0, width, height);
  fill(255);
  text(int(frameRate), 10, 20);
  if (myPort.available() > 0) {
    if ( (val = myPort. readStringUntil(ENTER)) != null ) val = trim(val); 
    else return; 
    if (val != null && val.indexOf("hex")>=0) { 
      println(val);
    }
  }
  for (int i=0; i<myMovie.length; i++) {
    if (val.indexOf(card[i])>=0) { 
      println ("PLAY MOVIE "+(i+1)); 
      movieToPlay.stop ( );  //stop current
      movieToPlay = myMovie[i]; // swap for a new movie 
      movieToPlay.frameRate(29.97);
      movieToPlay.loop( );
      break;
    }
  }
}
// Called every time a new frame is available to read 
void movieEvent(Movie m) { 
  m. read() ;
}
