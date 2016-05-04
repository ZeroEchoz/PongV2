//git add .  //<>//
//git commit -m ""
//git push

void setup () 
{
  size(1250, 800);
  smooth();
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

  if (scoreL == 0 && scoreR == 0) {
    screen = 0;
  }
}

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

float paddleTop;
float paddleBottom;

int scoreL;
int scoreR;

int screen;

void draw() 
{
  frameRate(90);
  if (screen == 1) {
    ball();
    stage();
    paddle();
    collision();
    score();
    paddle2();
  }

  if (screen == 0) {
    startMenu();
  }
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
  paddleTop = paddleY - paddleLength/2;
  paddleBottom = paddleY - paddleLength/2;
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
      paddle2Y -= speedPaddle;
    }
    if (key == 'l' || key == 'L') 
    {
      paddle2Y += speedPaddle;
    }
  }
}

void ball()
{
  background(0);
  fill(255);
  ellipse(ballX, ballY, ballR, ballR);
  ballX = ballX + speed * directionX;
  ballY = ballY + speed * directionY;
}

void collision() 
{
  if (ballX < paddleX - paddleWidth ) {
    if (ballY < paddleY + paddleLength + ballR && ballY > paddleY - ballR) {
      directionX *= -1;
      delay(50);
      paddleLength *= 0.75f;
    }
  }

  if (ballX > paddle2X - paddleWidth) {
    if (ballY < paddle2Y + paddle2Length + ballR && ballY > paddle2Y - ballR) {
      directionX *= -1;
      delay(50);
      paddle2Length *= 0.75f;
    }
  }

  if (ballY < height * 0.5f - stageLine) {
    directionY *= -1;
  }

  if (ballY > height * 0.5f + stageLine) {
    directionY *= -1;
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
      screen = 1;
    }
  }
}