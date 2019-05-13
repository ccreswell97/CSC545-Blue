import gab.opencv.*;
import processing.video.*;
import java.awt.*;

PImage sunglasses, batman, clown_nose, clown_hair;
PImage currentImg;
String filter;
Capture video;
OpenCV opencv;

final float WINDOW_WIDTH = 640.0;
final float WINDOW_HEIGHT = 480.0;
int imageNumber = 0;
boolean takePicture = false;
int currentFilter = 0;
PImage[] filters = new PImage[4];
String[] filterName = new String[4];

void setup() {
  size(640, 480);
  video = new Capture(this, int(WINDOW_WIDTH/2), int(WINDOW_HEIGHT/2));
  opencv = new OpenCV(this, int(WINDOW_WIDTH/2), int(WINDOW_HEIGHT/2));
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  sunglasses = loadImage("sunglass.png");
  batman = loadImage("batman.png");
  clown_nose = loadImage("clown_nose.png");
  clown_hair = loadImage("clown_hair.png");
  
  filters[0] = loadImage("beach.png");
  filterName[0] = "sunglasses";
  filters[1] = loadImage("bat.png");
  filterName[1] = "batman";
  filters[2] = loadImage("clown.png");
  filterName[2] = "clown";
  // Replace these when new filters are added
  filters[3] = loadImage("sunglass.png");
  filterName[3] = "sunglasses";
  //sunglasses = clearColor(sunglasses, color(255, 255, 255));
  shapeMode(CENTER);
  
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0 );
  filter = filterName[currentFilter];
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();
  //println(faces.length);
  addFilter(faces, filter);
  
  // If the button to take a picture is pressed, don't display shapes so the picture is of only
  // the person with the filter
  if (!takePicture) {
    addTakePictureButton();
    addFilterPreview();
  } else {
    takePicture(imageNumber);
    imageNumber++;
    takePicture = false;
  }
  //saveFrame("video/line-######.png");
}

void captureEvent(Capture c) {
  c.read();
}

void addFilter(Rectangle[] faces, String filter) {
  switch(filter) {
    case "sunglasses":
      for (int i = 0; i < faces.length; i++) {
        image(sunglasses, faces[i].x + 3, faces[i].y + 15, faces[i].width, faces[i].height/2);
      }
      break;
      case "batman":
      for (int i = 0; i < faces.length; i++) {
        //println(faces[i].x + "," + faces[i].y);
        image(batman, faces[i].x - 33, faces[i].y - 80, faces[i].width + 70, faces[i].height+95);
      }
      break;
      case "clown":
      for (int i = 0; i < faces.length; i++) {
        image(clown_nose, faces[i].x + (faces[i].width/2.0) - ((faces[i].width/3.5)/2), 
        faces[i].y + (faces[i].height/1.8) - ((faces[i].height/3.5)/2), 
        faces[i].width/3.5, faces[i].height/3.5);
        image(clown_hair, faces[i].x - (faces[i].width*0.3), faces[i].y - (faces[i].height * 0.8),
        faces[i].width*1.6, faces[i].height*1.6);
      }
      break;
    default:
      exit();
  }
}

PImage clearColor(PImage image, int maskColor) {
    PImage newImage = createImage(image.width, image.height, ARGB);
    image.loadPixels();
    newImage.loadPixels();
    for(int n = 0; n < newImage.pixels.length; n++)
        newImage.pixels[n] = image.pixels[n] == maskColor ? 0x00000000 : image.pixels[n] | 0xff000000;
    newImage.updatePixels();
    return newImage;
}

void addTakePictureButton() {
  fill(245);
  noStroke();
  circle(WINDOW_WIDTH/4.0, WINDOW_HEIGHT/2.15, 16);
  noFill();
  stroke(255);
  circle(WINDOW_WIDTH/4.0, WINDOW_HEIGHT/2.15, 20);
  if (mousePressed 
    && (mouseX > 300 && mouseY > 428) 
    && (mouseX < 342 && mouseY < 471)) {
    takePicture = true;
  }
}

void takePicture(int imageNumber) {
  saveFrame("pictures/pic" + imageNumber + ".jpg");
}

void addFilterPreview() {
  for (int i = 0; i < filters.length; i++) {
    if (currentFilter == i) {
      stroke(255);
      fill(255, 100);
    } else {
      stroke(255);
      noFill();
    }
    int spacing = 10;
    if (i >= filters.length/2) {
      spacing = 20;
    }
    image(filters[i], ((WINDOW_WIDTH/8.0)*i)+spacing, WINDOW_HEIGHT/2.6, 50, 50);
    rect(((WINDOW_WIDTH/8.0)*i)+spacing, WINDOW_HEIGHT/2.6, 50, 50, 7);
  }
  // If user clicks on box, that filter is then used
  if (mousePressed && (mouseY > 370 && mouseY < 470)) {
    if (mouseX > 20 && mouseX < 120) {
      currentFilter = 0;
    }
    if (mouseX > 180 && mouseX < 280) {
        currentFilter = 1;
    }
    if (mouseX > 360 && mouseX < 460) {
        currentFilter = 2;
    }
    if (mouseX > 520 && mouseX < 620) {
        currentFilter = 3;
    }
  }
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (currentFilter == 3) {
        currentFilter = 0;
      } else {
        currentFilter += 1;
      }
    }
    if (keyCode == LEFT) {
      if (currentFilter == 0) {
        currentFilter = 3;
      } else {
        currentFilter -= 1;
      }
    }
  }
}
