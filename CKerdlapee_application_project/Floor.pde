class Floor {
  float x;
  float span;
  float fHeight;
  float fWidth;
  Rock rocks;
  fBox boxes;

  //constructor function
  //initialize all the variables
  Floor(float _x, float h, float _w) {
    x = _x;
    fHeight = h;
    fWidth = _w;
    rocks = (new Rock(rockPNG, -100, height+300));
    boxes = (new fBox(boxJPG, -100, height+300));
  }

  //floor+snow shape
  void show() {
    fill (#edb9a3);
    noStroke();
    rect ( x, height-fHeight, fWidth, 800 );
    fill (#fef6f3);
    rect ( x, height-fHeight, fWidth, 35);
    beginShape();
    curveVertex(x, height-fHeight+34);
    curveVertex(x, height-fHeight+34);
    for (int i=0; i<=fWidth; i+=30) {
      if (i%60==0) {
        curveVertex(x+i, height-fHeight+34+20);
      } else {
        curveVertex(x+i, height-fHeight+34);
      }
    }
    curveVertex(x+fWidth, height-fHeight+34);
    curveVertex(x+fWidth, height-fHeight+34);
    endShape(CLOSE);
  }

  //move floor to mimic running
  void moveLeft() {
    x-=floorSpeed;
  }

  //spawining obstacles
  void spawnObs() {
    if (obCheck>1) {
      rocks = (new Rock(rockPNG, random(100, fWidth-300), height-fHeight-rockPNG.height));
      boxes = (new fBox(boxJPG, random(300, fWidth-100), height-fHeight-350 ));
    }
  }

  //displaying obstacles
  void showObs() {
    rocks.show(x, 0);
    boxes.show(x, 20);
  }

  //checking if the player is overlapping rock obstacle
  boolean overPlayerX(PVector Player) {
    PVector loRock=new PVector (0, 0);
    if (rocks.l.y-(height-fHeight-rockPNG.height)==0) {
      loRock = new PVector (rocks.l.x+rockPNG.height/2+x, rocks.l.y+rockPNG.height/2);
    }
    return (PVector.dist(Player, loRock)<=rockPNG.height*2/3);
  }

  //checking if the player is overlapping devil obstacle
  boolean overPlayerB(PVector Player) {
    PVector loBox=new PVector (0, 0);
    if (boxes.l.y-(height-fHeight-350)==0) {
      loBox = new PVector (boxes.l.x+boxJPG.height/2+x, boxes.l.y+boxJPG.height/2+boxes.alpha);
    }
    return (PVector.dist(Player, loBox)<=boxJPG.height/2);
  }

  //when in contact initialise variables
  void contactRock() {
    rocks.contact();
  }

  //when in contact initialise variables
  void contactBox() {
    boxes.contact();
  }

  //play rock animation
  void moveRock () {
    rocks.move();
  }

  //play devil animation
  void moveBox () {

    boxes.move();
  }
}
