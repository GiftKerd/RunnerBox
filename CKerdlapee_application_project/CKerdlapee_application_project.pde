//Declare variables
PlayerChar warrior;
ArrayList <Floor> ground;
int spawnTime=0;
float floorHeight = 1.0e38;
int floorW=2000;
int jump=0;
float floorSpeed=8;
int charHeight=120;
int obCheck=0;
float checkRock=0;
int screen=0;
int score=0;
int scoreinc=5;
int health=3;
boolean delhowto= false;
boolean checker2= false;
PVector loWarrior;
PVector loWarrior2;
int offset;
int offset2;

//loadImage
PImage rockPNG;
PImage boxJPG;
PImage sky;
PImage cloud;
PImage player;
PImage player2;
PImage tree;
PImage tree2;
PImage groundIMG;

void setup() {
  size (1000, 700);
  background(150);
  frameRate(60);
  offset=0;
  offset2=0;

  //initialise arraylists+objects
  warrior = new PlayerChar(height);
  ground = new ArrayList<Floor>();

  //load images
  rockPNG = loadImage("rock.png");
  rockPNG.resize(100, 100);
  boxJPG = loadImage("devil1.png");
  boxJPG.resize(100, 100);
  sky = loadImage("BG.jpg");
  cloud = loadImage("clouds.png");
  player=loadImage("girl1.png");
  player.resize(60, 120);
  player2=loadImage("girl2.png");
  player2.resize(60, 120);
  tree= loadImage("Trees.png");
  tree.resize(140, 250);
  tree2 = loadImage("Trees.png");
  tree2.resize(180, 330);
  groundIMG = loadImage("ground.png");


  //add ground objects to the arraylist
  fill ( 45 );
  for (int i=0; i<=floorW; i+=floorW) {
    ground.add (new Floor (i, 150, floorW) );
  }
}


void draw () {
  //homescreen
  if (screen==0) {
    background(#c0d8e4);
    image(sky, 0, 0);

    fill(#a68d89);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Runner Box", width/2, height/2);
    for (int i=0-offset; i<=width*2; i+=width) {
      image(cloud, i, 0);
    }
    offset= (offset+1)%width;

    for (int i= ground.size()-1; i>=0; i--) {
      Floor f = ground.get(i);
      f.show();
    }
    textSize(15);
    text("click to start", width/2, height/2+50);
    if (mousePressed==true) {
      screen=1;
      offset=0;
    }
  } else if (screen == 1) {

    //eliminating remnants with bg
    background(#c0d8e4);
    image(sky, 0, 0);

    //sun
    ellipseMode(CENTER);
    fill(#fef6f3, 80);
    for (int i=0; i<=20; i+=20) {
      ellipse(width-200, 120, 50-i, 50-i);
    }

    //resetting
    floorHeight = 1.0e38;

    //scoring system
    fill(#fef6f3);
    textAlign(LEFT, CENTER);
    textSize(20);
    text("Your score: "+score, 10, 20);
    if (frameCount%60==0) {
      scoreinc=5;
      score+=scoreinc;
    }

    //how to jump + delete after the player double jumps for the first time
    if (!delhowto) {
      textAlign(CENTER, CENTER);
      text("Hit spacebar to jump and double jump", width/2, 20);
    }

    //display Health
    warrior.healthDisplay();
    if (warrior.playerDeath()) {
      screen=2;
    }

    //using floorspeed(5pixels per frame) to indicate spawntime
    spawnTime+=floorSpeed;

    //spawn trees
    for (int i=0-offset; i<=width; i+=width/4) {
      image(tree, i, height-320);
    }
    offset= (offset+1)%width;
    for (int i=0-offset2; i<=width; i+=width/3) {
      image(tree2, i, height-400);
    }
    offset2= (offset2+3)%width;

    //ground
    fill(#edb9a3);
    image(groundIMG, 0, height-120);

    //Spawns spawn a new ground object everytime it moves 2000 pixels
    if (spawnTime==floorW) {
      fill ( #00ff00 );
      //randomise ground object's width so that there are gaps between each one
      float _w=floorW-(int) random(160, 300);

      //generate new ground object at random height
      Floor newFloor = new Floor ( floorW, random(100, 170), _w);
      ground.add (newFloor);
      newFloor.spawnObs();

      //resetting spawn time!
      spawnTime=0;

      //a checker for spawning obstacles (after 2 ground objects are generated)
      obCheck++;
    }

    //calling each ground object in the array list
    for ( int i=ground.size()-1; i>=0; i-- ) {
      Floor floors = ground.get(i);

      //remove floor when it gets out of bounds
      if ( floors.x + floorW < 0 ) {
        ground.remove(i);
      }

      //collission
      else { 

        //checking ground height flor the player
        if ( floors.x-50 < warrior.l.x && floors.x+floors.fWidth > warrior.l.x ) {
          floorHeight = height - floors.fHeight;
        } else { //for when the player fall off the edge of each ground platform
          floorHeight = height+500;
        }
        floors.moveLeft();
        floors.show();

        //shows obstacles only when there are 3 generated ground objects
        floors.showObs();
      }
      warrior.update ( floorHeight );

      //get location of the warrior
      loWarrior = new PVector (warrior.l.x, warrior.l.y+charHeight);
      loWarrior2 = new PVector (warrior.l.x, warrior.l.y);

      if (loWarrior.y>=floorHeight) {
        ellipse(loWarrior.x, loWarrior.y, 20, 20); //just to check the location of the collision
      }
      println(loWarrior); //check the location of the warrior

      //falls off the window
      if (loWarrior.y > height) {
        screen=2;
      }

      //check if the player touches the rock
      if (obCheck>1) {

        if (floors.overPlayerX(loWarrior)) {
          println("working");
          ellipse(loWarrior.x+25, loWarrior.y, 50, 50);
          floors.contactRock();
          //decrease player's health when they touches obstacles
          warrior.hitCheck();
        }
        if (floors.overPlayerB(loWarrior2)) {
          println("working");
          ellipse(loWarrior2.x, loWarrior2.y, 100, 100);
          floors.contactBox();
          warrior.hitCheck();
        }
        warrior.healthDec();
        //play rock&box animation
        floors.moveRock();
        floors.moveBox();
      }
      warrior.display();
    }
  } else if (screen==2) {
    fill(50, 20);
    rectMode(CENTER);
    rect(width/2, height/2, 200, 200);
    fill(#fef6f3);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Runner Box", width/2, height/2-50);
    text("Your score: "+score, width/2, height/2);
    fill(255);
    textSize(15);
    text("Press q to quit", width/2, height/2+50);
    screen=3;
  }
}

//double jumping mechanic
void keyPressed() {
  if (key == ' ') {
    jump++;
    if (jump==1) {
      warrior.jump(12);
      //player can only jump twice
    } else if (jump==2) {
      warrior.jump(10);
      delhowto= true;
      jump=20;
    }
  } else if (key == 'q' || key == 'Q') {
    if (screen==3) {
      exit();
    }
  }
}
