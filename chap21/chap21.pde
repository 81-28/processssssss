//4つ全記述
int panel_0_0 = 1;
int panel_0_1 = 1;
int panel_1_0 = 1;
int panel_1_1 = 1;

int n = 2;
int panelW, panelH;
int b = 5;

int x = 0;
int y = 0;

int score = 0;

void setup() {
    size(600, 600);
    panelW = width / n;
    panelH = height / n;
}

void draw() {
    background(0);
    fill(127);
    

    x = 0;
    y = 0;

    if (mouseX >= (x * panelW) + b && mouseX < ((x + 1) * panelW) - b && mouseY >= (y * panelH) + b && mouseY < ((y + 1) * panelH) - b){
        if(panel_0_0 == 1) {
            score ++;
            panel_0_0 = 0;    
        }
    }
    if(panel_0_0 == 1){
    rect((x * panelW) + b, (y * panelH) + b, panelW - 2 * b, panelH - 2 * b);
    }
    
    x = 0;
    y = 1;

    if (mouseX >= (x * panelW) + b && mouseX < ((x + 1) * panelW) - b && mouseY >= (y * panelH) + b && mouseY < ((y + 1) * panelH) - b){
        if(panel_0_1 == 1) {
            score ++;
            panel_0_1 = 0;    
        }
    }
    if(panel_0_1 == 1){
    rect((x * panelW) + b, (y * panelH) + b, panelW - 2 * b, panelH - 2 * b);
    }

    x = 1;
    y = 0;

    if (mouseX >= (x * panelW) + b && mouseX < ((x + 1) * panelW) - b && mouseY >= (y * panelH) + b && mouseY < ((y + 1) * panelH) - b){
        if(panel_1_0 == 1){
            score ++;
            panel_1_0 = 0;    
        }
    }
    if(panel_1_0 == 1){
    rect((x * panelW) + b, (y * panelH) + b, panelW - 2 * b, panelH - 2 * b);
    }

    x = 1;
    y = 1;

    if (mouseX >= (x * panelW) + b && mouseX < ((x + 1) * panelW) - b && mouseY >= (y * panelH) + b && mouseY < ((y + 1) * panelH) - b){
        if(panel_1_1 == 1){
            score ++;
            panel_1_1 = 0;    
        }
    }
    if(panel_1_1 == 1){
    rect((x * panelW) + b, (y * panelH) + b, panelW - 2 * b, panelH - 2 * b);
    }


    fill(255);
    circle(mouseX, mouseY, 10);
    textSize(50);
    text(score, panelW, panelH);
}
