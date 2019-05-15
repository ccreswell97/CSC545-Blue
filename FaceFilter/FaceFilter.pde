import gab.opencv.*; //<>//
import processing.video.*;
import java.awt.*;

PImage currentImg;
Filter currentFilter;
Capture video;
OpenCV opencv;

final float WINDOW_WIDTH = 640.0;
final float WINDOW_HEIGHT = 480.0;
int imageNumber = 0;
boolean takePicture;

int currentFilterId = 0;

ArrayList<Filter> filters = new ArrayList<Filter>();

void setup() {
  size(640, 600);

  takePicture = false;

  video = new Capture(this, int(WINDOW_WIDTH/2), int(WINDOW_HEIGHT/2));
  opencv = new OpenCV(this, int(WINDOW_WIDTH/2), int(WINDOW_HEIGHT/2));
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  filters.add(new Filter("sunglass"));
  filters.add(new Filter("batman"));
  filters.add(new Filter("clown"));
  filters.add(new Filter("cat"));
  filters.add(new Filter("unicorn"));
  filters.add(new Filter("santa_hat"));

  shapeMode(CENTER);
  video.start();
}

void draw() {

  background(0);
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0 );

  currentFilter = filters.get(currentFilterId);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();

  addFilter(faces, currentFilter);

  if (!takePicture) {
    addTakePictureButton();
    addFilterPreview();
  } else {
    takePicture(imageNumber);
    imageNumber++;
    takePicture = false;
  }
}

void addFilter(Rectangle[] faces, Filter filter) {
  switch(filter.name) {
  case "sunglass":
    for (int i = 0; i < faces.length; i++) {
      image(filter.subImages.get(0), faces[i].x + 3, faces[i].y + 15, faces[i].width, faces[i].height/2);
    }
    break;
  case "batman":
    for (int i = 0; i < faces.length; i++) {
      image(filter.subImages.get(0), faces[i].x - 33, faces[i].y - 80, faces[i].width + 70, faces[i].height+95);
    }
    break;
  case "clown":
    for (int i = 0; i < faces.length; i++) {
      image(filter.subImages.get(1), faces[i].x + (faces[i].width/2.0) - ((faces[i].width/3.5)/2), 
        faces[i].y + (faces[i].height/1.8) - ((faces[i].height/3.5)/2), 
        faces[i].width/3.5, faces[i].height/3.5);
      image(filter.subImages.get(0), faces[i].x - (faces[i].width*0.3), faces[i].y - (faces[i].height * 0.8), 
        faces[i].width*1.6, faces[i].height*1.6);
    }
    break;
  case "cat":
    for (int i = 0; i < faces.length; i++) {
      image(filter.subImages.get(0), faces[i].x - 22, faces[i].y - 89, faces[i].width + 50, faces[i].height+80);
    }
    break;
  case "unicorn":
    for (int i = 0; i < faces.length; i++) {
      //image(filter.subImages.get(0), faces[i].x - 33, faces[i].y - 150, faces[i].width-50, faces[i].height);
       image(filter.subImages.get(0), faces[i].x - 18, faces[i].y - 77, faces[i].width + 34, faces[i].height);
    
    }
    break;
  case "santa_hat":
    for (int i = 0; i < faces.length; i++) {
      image(filter.subImages.get(0), faces[i].x - 18, faces[i].y - 77, faces[i].width + 34, faces[i].height+62);
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
  for (int n = 0; n < newImage.pixels.length; n++)
    newImage.pixels[n] = image.pixels[n] == maskColor ? 0x00000000 : image.pixels[n] | 0xff000000;
  newImage.updatePixels();
  return newImage;
}

void addFilterPreview() {
  for (Filter filter : filters) {
    filter.draw();
    filter.isHover();
    if (mousePressed && filter.isHover()) {
      currentFilterId = filter.getId();
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (currentFilterId == 5) {
        currentFilterId = 0;
      } else {
        currentFilterId += 1;
      }
    }
    if (keyCode == LEFT) {
      if (currentFilterId == 0) {
        currentFilterId = 5;
      } else {
        currentFilterId -= 1;
      }
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}

void mousePressed() {
  println(mouseX, mouseY);
}
