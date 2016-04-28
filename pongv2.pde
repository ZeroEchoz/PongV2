//git add .  //<>//
//git commit -m ""
//git push

void setup () 
{
  size(1250, 800);
  smooth();
  background(0);

  paddleLength = 150;
  paddleWidth = 15;
  paddleX = 125;
  paddleY = 400;

  speed = 5;
  speed2 = 5;
  speedBoost = 10;

  ballX = 625;
  ballY = 400;
  ballR = 20;
  ballSpeed = 5;

  paddle2X = width  - 125;
  paddle2Y = height - 400;
  paddle2Width = 15;
  paddle2Length = 150;
}

float stageLine = 350;
float lineLength = 20;

float paddleLength;
float paddleWidth;
float centerY;
float paddleX;
float paddleY;

float speed;
float speed2;
float speedBoost;

float ballX;
float ballY;
float ballR;
float ballSpeed;

float paddle2X;
float paddle2Y;
float paddle2Width;
float paddle2Length;

void draw() 
{
  ball();
  stage();
  paddle();
  collision();
  score();
  paddle2();
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
      paddleY -= speed;
    }
    if (key == 's' || key == 'S') 
    {
      paddleY += speed;
    }
  }
}

void paddle2() 
{
  rectMode(CENTER);
  fill(255);
  rect(paddle2X, paddle2Y, paddle2Width, paddle2Length);
  if (keyPressed)
  {
    if (key == 'o' || key == 'O') 
    {
      paddle2Y -= speed2;
    }
    if (key == 'l' || key == 'L') 
    {
      paddle2Y += speed2;
    }
  }
}

void ball()
{
  background(0);
  fill(255);
  ellipse(ballX, ballY, ballR, ballR);
  ballX -= ballSpeed;
}

void collision() 
{
  if (ballX < paddleX) {
    if (ballY < paddleY + paddleLength + ballR && ballY > paddleY - ballR) {
      ballSpeed *= -1;
      paddleLength *= 0.75f;
    }
  }
  if (ballX > paddle2X) {
    if (ballY < paddle2Y + paddle2Length + ballR && ballY > paddle2Y - ballR) {
      ballSpeed *= -1;
      paddle2Length *= 0.75f;
    }
  }
}

void score() 
{
  if (ballX > width)
  {
    setup();
  }
}