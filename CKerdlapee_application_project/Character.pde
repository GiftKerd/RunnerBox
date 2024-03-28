class PlayerChar {
  PVector l;
  PVector v;
  PVector g;
  int health;
  float counter;
  float heightCheck;
  
  //constructor function
  //initialize all the variables
  PlayerChar (float h) {
    l = new PVector ( width/3, h-charHeight );
    v = new PVector ( 0, 0 );
    g = new PVector(0, 0.25);
    health=3;
    counter=0;
    heightCheck=0;
  }


  void jump(int vi) {
    v.y=-vi;
  }

  //detecting floor height and jump
  void update(float _height) {
    heightCheck=_height;
    l.add(v);
    v.add(g);
    if ( l.y+charHeight > heightCheck ) {
      v.y = 0;
      l.y = heightCheck-charHeight;
      jump=0;
    }
  }

//display the 2 states of the player
  void display() {
    if (l.y+charHeight >= heightCheck-10) {
      image(player, l.x, l.y);
    } else if (l.y+charHeight <= height-200 && l.y+charHeight <= heightCheck-10) {
      image(player2, l.x, l.y); //for when the player jumps display jump image other than that diisplays normal player image
    } else {
      image(player, l.x, l.y); 
    }
  }

//check when the player is hit by the obstacles
  void hitCheck() {
    counter++;
    println(counter);
  }

//decrese 1 lifepoint every hit
  void healthDec() {
    if (counter==1) {
      health-=1;
      if (health<0) {
        health=0;
      }
      counter=0;
    }
  }

  void healthReset() {
    health=3;
  }

  boolean playerDeath() {
    return (health==0);
  }

  void healthDisplay() {
    if (health==3) {
      for (int i=0; i>=-100; i-=50) {
        ellipse (width-20+i, 20, 25, 25);
      }
    } else if (health==2) {
      for (int i=0; i>=-50; i-=50) {
        ellipse (width-20+i, 20, 25, 25);
      }
    } else if (health==1) {
      ellipse (width-20, 20, 25, 25);
    }
  }
}
