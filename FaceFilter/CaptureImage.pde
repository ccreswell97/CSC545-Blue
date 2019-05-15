
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
  PImage img = get(0, 0, 640, 480);
  img.save("pictures/pic" + imageNumber + ".jpg");
  //saveFrame("pictures/pic" + imageNumber + ".jpg");
}

PImage convertBlackToTransparent(PImage img) {
  int i;
  PImage newImg = createImage( img.width, img.height, ARGB );
  for ( int x = 0; x < img.width; x++ ) {
    for ( int y = 0; y < img.height; y++ ) {
      i = ( ( y * img.width ) + x );
      if ( img.pixels[i] == color( 0, 0, 0 ) ) {
        newImg.pixels[i] = color( 0, 0, 0, 0 );
      } else {
        newImg.pixels[i] = img.pixels[i];
      }
    }
  }
  return newImg;
}
