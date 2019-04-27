import gab.opencv.*;
import processing.video.*;
import java.awt.*;

PImage sunglasses;
Capture video;
OpenCV opencv;

final int WINDOW_WIDTH = 640;
final int WINDOW_HEIGHT = 480;
String filter = "sunglasses";

void setup() {
  size(640, 480);
  video = new Capture(this, WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
  opencv = new OpenCV(this, WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  sunglasses = loadImage("sunglass.png");

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0 );
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  addFilter(faces, filter);
}

void captureEvent(Capture c) {
  c.read();
}

void addFilter(Rectangle[] faces, String filter) {
  switch(filter) {
    case "sunglasses":
      for (int i = 0; i < faces.length; i++) {
        println(faces[i].x + "," + faces[i].y);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        image(sunglasses, faces[i].x, faces[i].y + 20, faces[i].width, faces[i].height/2);
      }
      break;
    default:
      exit();
  }
}
