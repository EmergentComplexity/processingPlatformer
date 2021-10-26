

int PlayerX = 20;
int PlayerY = 750;
int Floor = 750;
int EnemyX = 1000;
int Score = 0;
boolean MoveRightEnable = true; // allows the player to move translationally right, false if player collides with object
boolean MoveLeftEnable = true;
boolean EnemyDir = true; // true is forward, false is backward
boolean EnemyAlive = true;
boolean GameOver = false;
void setup() {
  size(1000, 1000);
  strokeWeight(10);
  frameRate((60));
}



// Runs Every Frame
void draw() {
  if (GameOver == false) { // This is all disabled if the game is over
    int HEIGHT = 1000;
    int WIDTH = 1000;
    
    background(3,161,252); 
  
    // Score
    textSize(32);
    text("SCORE", 40, 120);
    text(Score, 40, 300);
    fill(255, 255, 255);
  
  
  
    // Draw the stuff to the screen that required addressing individual pixels
    color Black = color(0, 0, 0);
    loadPixels();

    for(int i = (HEIGHT-1); i >0; i--) {
        for(int j = 0; j < WIDTH; j++) {    
               if (i > 0.01*(j - 100 + PlayerX)*(j- 100 + PlayerX) + 600) { // draw a bush with a parabola
                  pixels[((HEIGHT*i) + j)]= color(11,252,3); 
               }
               if ( (i < 200))  { // Draw the Floor
                 pixels[(HEIGHT*WIDTH) - (j+(HEIGHT*i))] = Black; 
               }
          }
      }
    updatePixels();
  
 
  
  
    if (PlayerY < Floor) {  // gravity
      PlayerY = PlayerY + 5; 
    }

    rect(500, PlayerY, 50, 50);  // player
  
  
  
    // A Platform made from Rectangles that the player can stand on
   // if (PlayerX > 500) {
       rect(1500 - PlayerX, 500, 50, 50);
       rect(1500 - PlayerX - 50, 500, 50, 50);
       rect(1500 - PlayerX - 100, 500, 50, 50);
       if ((PlayerX > 850) && (PlayerX < 1050) && (PlayerY > 500)) { // player on rectangles
         //print(PlayerX);
         Floor = 450;
       }  
    //}
    
    // Reset Gravity to  pull player down to the ground if the player is not on a platform
    if ( PlayerX < 850 || ((PlayerX > 1050) && (PlayerX < 1950)) || PlayerX > 2000) {
      Floor = 750;
    }
  
    // Code to Deal with Enemy
    if (EnemyAlive == true) {
      // make a Goomba
      fill(105, 79, 44);                 // Goomba is brown
      rect(EnemyX - PlayerX, 750, 50, 50);
      fill(255, 255, 255);
      if (EnemyX > 600 ){
        EnemyDir  = false; // toggle if out of bounds
      }
      else if ( EnemyX < 400){
        EnemyDir  = true; // toggle if out of bounds
      }
      if (EnemyDir == true) {
        EnemyX++;
      }
      if (EnemyDir == false) {
        EnemyX--;
      }  
      // if the player touches the enemy
      if (EnemyX-PlayerX == 500) {
    
        if ( PlayerY < 710 && PlayerY > 640) {    // You Kill the Enemy
          EnemyAlive = false;
          Score++;
        } 
        if (PlayerY > 730) {                      // The Enemy Kills You
          GameOver();
        }
      }
    }
  
    // Make a Staircase with Rectangles
  //  if (PlayerX > 1500) {
       rect(2500 - PlayerX, 750, 50, 50);
       rect(2500 - PlayerX - 50, 750, 50, 50);
       rect(2500 - PlayerX - 100, 750, 50, 50);
       rect(2500 - PlayerX - 150, 750, 50, 50);
     
     
       rect(2500 - PlayerX, 700, 50, 50);
       rect(2500 - PlayerX - 50, 700, 50, 50);
       rect(2500 - PlayerX - 100, 700, 50, 50);
     
       rect(2500 - PlayerX, 650, 50, 50);
       rect(2500 - PlayerX - 50, 650, 50, 50);
     
       rect(2500 - PlayerX, 600, 50, 50);
       //print(PlayerX);
     
       // climb the stairs
       if ((PlayerX > 1750) && (PlayerX < 1900) && (PlayerY > 50)) { // player on rectangles
          Floor = 700;
       }
       else if ((PlayerX > 1850) && (PlayerX < 1950) && (PlayerY > 100)) { // player on rectangles
          Floor = 650;
       } 
       else if ((PlayerX > 1900) && (PlayerX < 2000) && (PlayerY > 150)) { // player on rectangles
          Floor = 600;
       } 
       else if ((PlayerX > 1950) && (PlayerX < 2020) && (PlayerY > 200)) { // player on rectangles
          Floor = 550;
       } 
       //staircase collider
       /*
       if(PlayerX >= (2500 - PlayerX)) {
         MoveRightEnable = false;
       }
       else  {
         MoveRightEnable = true;
       }
       */
  //  }
  
    // The Game ends after the player reaches this point  
    if (PlayerX > 2000) {
     // GameOver();  
    }
  }
}



// Runs when a key is pressed
void keyPressed() {
  if (key == CODED) {
    
    if (GameOver == false){
      if (keyCode == RIGHT && MoveRightEnable == true) {                          // Scroll Right
        PlayerX = PlayerX + 10;
      } 
      else if (keyCode == LEFT && PlayerX > 0 && MoveLeftEnable == true) {       // Scroll Left
        PlayerX = PlayerX - 10;
      }
      if (keyCode == UP) {                             // Jump
        PlayerY = PlayerY - 120;
      }
    } 
    
    // If the game is over, press UP to restart
    else if (GameOver == true) {
      if (keyCode == UP) {
         PlayerX = 0;
         GameOver = false;
      }
    }
  }
}

// Runs when the game is over
void GameOver () {
  background(3,161,252); 
  GameOver = true;
  textSize(128);
  text("GAME OVER", 100, 500);
  textSize(32);
  text("PRESS UP TO CONTINUE", 100, 700);
  fill(255, 255, 255);
  Score = 0;
  EnemyAlive = true;

}
