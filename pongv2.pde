//git add .  //<>//
//git commit -m ""
//git push

void setup () 
{
  minim = new Minim(this);
  song = minim.loadFile("ding3.wav");
  song.play();
  size(1250, 800);
  background(0);

  delay(100);

  paddleLength = 150;
  paddleWidth = 15;
  paddleX = 125;
  paddleY = 400;

  speed = 4;
  speedPaddle = 5;
  speedBoost = 10;

  ballX = 625;
  ballY = 400;
  ballR = 20;
  directionY = -1;
  directionX = -1;

  paddle2X = width  - 125;
  paddle2Y = height - 400;
  paddle2Width = 15;
  paddle2Length = 150;

  hits = 0;

  if (scoreL == 0 && scoreR == 0) {

    screen = 0;
  }
}

import ddf.minim.*;
Minim minim;
AudioPlayer song;

float stageLine = 350;
float lineLength = 20;

float paddleLength;
float paddleWidth;
float centerY;
float paddleX;
float paddleY;

float speed;
float speedPaddle;
float speedBoost;

float ballX;
float ballY;
float ballR;
float directionX;
float directionY;

float paddle2X;
float paddle2Y;
float paddle2Width;
float paddle2Length;

int scoreL;
int scoreR;

int screen;

int hits;

boolean[] keys = new boolean[2000];

float[] trailX = new float[30];
float[] trailY = new float[30];

void draw() 
{
  smooth();
  frameRate(90);
  mainMenu();

  if (screen == 1) {
    ball();
    stage();
    paddle();
    collision();
    score();
    paddle2();
    gameOver();
  }

  if (screen == 0) {
    startMenu();
  }
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}

void stage() 
{
  stroke(255);
  line(0, height * 0.5f - stageLine, width, height * 0.5f - stageLine);
  stroke(255);
  line(0, height * 0.5f + stageLine, width, height * 0.5f + stageLine);

  for (int i = 0; i < 1000; i += 20) {
    stroke(255);
    line(width * 0.5f, 10 + i, width * 0.5f, i+20);
  }
}

void paddle()
{
  rectMode(CENTER);
  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleLength);

  if (keyPressed)
  {
    if (key == 'w' || key == 'W') 
    {
      keys[0] = true;
      paddleY -= speed;
    }
    if (key == 's' || key == 'S') 
    {
      keys[1] = true;
      paddleY += speed;
    }
  }
}

void paddle2() 
{
  rectMode(CENTER);
  fill(255);
  rect(paddle2X, mouseY, paddle2Width, paddle2Length);
}

void ball()
{
  background(0);
  noStroke();
  fill(255);
  ellipse(ballX, ballY, ballR, ballR);
  ballX = ballX + speed * directionX;
  ballY = ballY + speed * directionY;

  for (int i = 0; i < 29; i++) 
  {
    trailX[i] = trailX[i+1];
    trailY[i] = trailY[i+1];

    ellipse (trailX[i], trailY[i], i, i);
  }
  trailX[29] = ballX;
  trailY[29] = ballY;
}

void collision() 
{
  if (ballX < paddleX + paddleWidth ) {
    if (ballY + ballR < paddleY + paddleLength / 2 && ballY - ballR > paddleY - paddleLength / 2) {
      directionX *= -1;
      minim = new Minim(this);
      song = minim.loadFile("pongHit.wav");
      song.play();
      delay(50);
      paddleLength *= 0.75f;
      hits ++;
    }
  }

  if (ballX > paddle2X - paddleWidth) {
    if (ballY + ballR < mouseY + paddle2Length / 2 && ballY - ballR > mouseY - paddle2Length / 2) {
      directionX *= -1;
      minim = new Minim(this);
      song = minim.loadFile("pongHit.wav");
      song.play();
      delay(50);
      paddle2Length *= 0.75f;
      hits ++;
    }
  }

  if (ballY < height * 0.5f - stageLine) {
    directionY *= -1;
    minim = new Minim(this);
    song = minim.loadFile("pongHit2.wav");
    song.play();
  }

  if (ballY > height * 0.5f + stageLine) {
    directionY *= -1;
    minim = new Minim(this);
    song = minim.loadFile("pongHit2.wav");
    song.play();
  }
}


void score() 
{
  textSize(30);
  stroke(255);
  //score left
  text(" " + scoreL, 150, 30);
  //score right
  stroke(255);
  text(" " + scoreR, width - 150, 30);
  //hits
  stroke(255);
  textAlign(CENTER);
  textSize(30);
  text(" Total Hits: " + hits, width / 2 + 6, 30);

  if (ballX > width)
  {
    scoreL ++;
    setup();
  }

  if (ballX < 0)
  {
    scoreR ++;
    setup();
  }
}


void startMenu () 
{
  textAlign(CENTER);
  textSize(25);
  background (0);
  text(" Press Space To Play! ", width / 2, height / 2 + 250);
  textSize(50);
  text(" PONG v2 ", width / 2, height / 2 - 100);


  if (keyPressed)
  {
    if (key == ' ') 
    {
      minim = new Minim(this);
      song = minim.loadFile("ding.wav");
      song.play();
      screen = 1;
    }
  }
}

void mainMenu() 
{
  if (keyPressed)
  {
    if (key == 'r' || key == 'R') 
    {
      minim = new Minim(this);
      song = minim.loadFile("ding.wav");
      song.play();
      screen = 0;
      scoreL = 0;
      scoreR = 0;
      setup();
    }
  }
}

void gameOver()
{

  if (scoreR == 3) 
  {
    background(0);
    textAlign(CENTER);
    textSize(50);
    stroke(255);
    text("Player 2 Wins!", width / 2, height / 2);
    text("Press 'R' to restart", width / 2, height / 2 + 100);

    directionY = 0;
    directionX = 0;
  }

  if (scoreL == 3) 
  {
    background(0);
    textAlign(CENTER);
    textSize(50);
    stroke(255);
    text("Player 1 Wins!", width / 2, height / 2);
    text("Press 'R' to restart", width / 2, height / 2 + 100);

    directionY = 0;
    directionX = 0;
  }
}