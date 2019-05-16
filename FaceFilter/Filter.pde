 //<>//
class Filter {
  String name;
  PImage imagePreview;
  ArrayList<PImage> subImages;
  PVector pos;
  int size;
  private int id;

  public Filter(String name) {
    this.name = name;
    size = 50;

    this.id = filters.size();

    pos = new PVector();
    pos.x = id*53+3;
    pos.y = 245;

    subImages = new ArrayList<PImage>();

    if (name.equals("batman")) {//---------------------------- batman
      imagePreview = loadImage("bat.png");
      subImages.add(loadImage("batman.png"));
    } else if (name.equals("sunglass")) {//---------------------------- sunglass
      imagePreview = loadImage("beach.png");
      subImages.add(loadImage("sunglass.png"));
    } else if (name.equals("clown")) {//---------------------------- clown
      imagePreview = loadImage("clown.png");
      subImages.add(loadImage("clown_hair.png"));
      subImages.add(loadImage("clown_nose.png"));
    } else if (name.equals("cat")) {//---------------------------- cat
      imagePreview = loadImage("cat_display.png");
      subImages.add(loadImage("cat.png"));
    } else if (name.equals("unicorn")) {//---------------------------- unicorn
      imagePreview = loadImage("uni.jpeg");
      subImages.add(loadImage("unicorn.png"));
    } else if (name.equals("santa_hat")) {//---------------------------- santa_hat
      imagePreview = loadImage("santa.png");
      subImages.add(loadImage("santa_hat.png"));
    }  
    imagePreview.resize(50, 50);
  }

  public void draw() {
    fill(255);
    stroke(255);
    rect(pos.x, pos.y, 50, 50, 5);
    image(imagePreview, pos.x, pos.y);
  }

  public boolean isHover() {
    if (mouseX > pos.x*2 && mouseX < pos.x*2+size*2 && mouseY > pos.y*2 && mouseY < pos.y*2+size*2) {
      return true;
    } else {
      return false;
    }
  }

  public int getId() {
    return this.id;
  }
}
