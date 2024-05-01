// 配列判定テスト

int n = 3;
int nary = n - 1;
int panels = 9;
int[] num = {1, 1, 1, 1, 1, 1, 1, 1, 1};

int x = 0;
int y = 0;

int panelW, panelH;
int b = 5;

int score = 0;



void setup() {
    size(600, 600);
    panelW = width / n;
    panelH = height / n;
}


void draw() {
    background(0);
    fill(127);
    for (int i = 0; i < panels; i++) {
        x = i % n;
        y = (i - x) / n;
        if (mouseX >= (x * panelW) + b && mouseX < ((x + 1) * panelW) - b && mouseY >= (y * panelH) + b && mouseY < ((y + 1) * panelH) - b){
            if(num[i] == 1){
                score ++;
                num[i] = 0;    
            }
        }
        if(num[i] == 1){
            rect((x * panelW) + b, (y * panelH) + b, panelW - 2 * b, panelH - 2 * b);
        }
    
    }
    fill(255);
    circle(mouseX, mouseY, 10);
    textSize(50);
    text(score, panelW, panelH);
}
