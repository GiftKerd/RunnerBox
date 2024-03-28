abstract class Obstacle {
  PVector l;
  PImage obstacleImage;
  PVector v;
  PVector g;
  float wobble;
  float alpha;

  //constructor function
  //initialize all the variables
  Obstacle (PImage _image, float _x, float _y) {
    l= new PVector (_x, _y);
    obstacleImage=_image;
    v = new PVector ( 0, 0 );
    g = new PVector(0, 0.3);
    wobble=0;
  }

  abstract void move();
  abstract void contact();

//displaying the images in void draw
//x is to update its x location y is the amount of wobbling
  void show(float _x, float _y) {
    wobble+=PI/20;
    alpha = sin(wobble)*_y;
    image(obstacleImage, l.x+_x, l.y+alpha);
  }
}
