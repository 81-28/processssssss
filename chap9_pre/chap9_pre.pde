//2023_7/15_16:48 変数に変数を使用できた。あとは判定だけ。
int fps = 120;
color bgcolor = color(0, 0, 31);
int f = 0; //フラグ管理 0/1/2/3/4 スタート前/ゲーム中/ポーズ/クリア/ゲームオーバー
int x = 720 / 2;
int y = 795;
int v = 4;
float theta = PI / 2;
int l = 100;
float vx = 0;
float vy = -v;
int ballsize = 10;
float xbar = 720 / 2;
float vbar = 3;
float barwidth = 160;
int boxX = 10;
int boxY = 6;
int boxes = boxX * boxY;
int xbox = 0;
int ybox = 0;
int[] num = new int[boxes];
int edge = 1;
int collision = 10;
int score = 0;
int combo = 0;

void setup() {
    size(720, 900);
    frameRate(fps);
    colorMode(HSB, 360, 100, 100);
    
    for (int i = 0; i < boxes; ++i) {
        num[i] = 1;
    }
}

void draw() {
    background(bgcolor);
    stroke(60, 100, 100);
    strokeWeight(2);
    
    if (keyPressed) {
        if (keyCode == LEFT) {
            xbar -= vbar;
        }
        else if (keyCode == RIGHT) {
            xbar += vbar;
        }
    }

    if (x >= xbar - (barwidth / 2) && x <= xbar + (barwidth / 2)) {
        theta = (90 - ((x -xbar) / (barwidth / 2)) * 60) * (PI / 180);
    }

    if (f == 0) {
        if (x >= xbar - (barwidth / 2) && x <= xbar + (barwidth / 2)) {
            fill(60, 100, 100);
            line(x, y, x + (l * cos(theta)), y - (l * sin(theta)));

            if (keyPressed) {
                if (key == ' ') {
                    f = 1;
                    vx = (v * cos(theta));
                    vy = -(v * sin(theta));
                }
            }

        }
    }
    else if (f == 1) {   
        x += vx;
        y += vy;
    }

    if (x < 0){
        x = -x;
        vx = -vx;
    } else if (x > 720) {
        x = width * 2 - x;
        vx = -vx;
    }
    if (y < 0) {
        y = -y;
        vy = -vy;
    }

    noStroke();

    int boxW = (width / boxX);
    int boxH = (height / (boxY * 3));

    for (int i = 0; i < boxes; i++) {
        xbox = i % boxX;
        ybox = (i - xbox) / boxX;



        
        if (mouseX >= (xbox * boxW) + edge && mouseX < ((xbox + 1) * boxW) - edge && mouseY >= (ybox * boxH) + edge && mouseY < ((ybox + 1) * boxH) - edge){
            if(num[i] == 1){
                score ++;
                num[i] = 0;    
            }
        }



        if(num[i] == 1){
            fill(xbox * 36, 100, 100);
            rect((xbox * boxW) + edge, (ybox * boxH) + edge, boxW - (edge * 2), boxH - (edge * 2));
        }
    }

    fill(255);
    rect(xbar - (barwidth / 2), 800, barwidth, 8);

    circle(x, y, ballsize);

    

    textSize(50);
    text(score, width / 2, height / 2);
}