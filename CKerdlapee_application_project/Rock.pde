class Rock extends Obstacle { 
  boolean hit;
  //constructor function
  //initialize all the variables
  Rock(PImage _image, float _x, float _y) {
    //constructor function calls parent's constructor to initialize object
    super(_image, _x, _y);
    hit = false;
  }

//initialise value when the player hits
  void contact() {
    v.y=-5;
    hit=true;
  }

//animation for when the player hits
  void move() {
    if (hit) {
      l.add(v);
      v.add(g);
    }
  }
}
