boolean[] keys = new boolean[128];

void setup()
{
  size(600,600);
  background(0,255,0);
}

float x = random(width);
float y = random(height);
float speed = 5;

void draw() {
  background(255);
  fill(255);
  
  if (keys['W'] || keys['w'] || keys[UP]) {
    y -= speed; // 上に移動
  }
  if (keys['A'] || keys['a'] || keys[LEFT]) {
    x -= speed; // 左に移動
  }
  if (keys['S'] || keys['s'] || keys[DOWN]) {
    y += speed; // 下に移動
  }
  if (keys['D'] || keys['d'] || keys[RIGHT]) {
    x += speed; // 右に移動
  }
  if (keys[' '] || keys[32]) {
    // スペースキーが押されたときの動作をここに書く
    fill(255, 0, 0);
  }
  
  ellipse(x, y, 50, 50); // プレイヤーキャラクターを描画
}

void keyPressed() {
  if (key < 128) {
    keys[key] = true;
  }
  if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT || keyCode == 32) {
    keys[keyCode] = true;
  }
}

void keyReleased() {
  if (key < 128) {
    keys[key] = false;
  }
  if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT || keyCode == 32) {
    keys[keyCode] = false;
  }
}