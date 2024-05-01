// 秒数によって色と図形を変える

int NUM = second();

int RED = #ff0000;
int ORANGE = #ff7f00;
int YELLOW = #ffff00;
int LIME = #7fff00;
int GREEN = #00ff00;
int BLUEGREEN = #00ff7f;
int CYAN = #00ffff;
int AZURE = #007fff;
int BLUE = #0000ff;
int PURPLE = #7f00ff;

void setup()
{
    size(960, 540);
    background(0);
}

void draw(){
    switch (NUM % 10 ) {
        case 0: {
            fill(RED);
            break;
        }
        case 1: {
            fill(ORANGE);
            break;
        }
        case 2: {
            fill(YELLOW);
            break;
        }
        case 3: {
            fill(LIME);
            break;
        }
        case 4: {
            fill(GREEN);
            break;
        }
        case 5: {
            fill(BLUEGREEN);
            break;
        }
        case 6: {
            fill(CYAN);
            break;
        }
        case 7: {
            fill(AZURE);
            break;
        }
        case 8: {
            fill(BLUE);
            break;
        }
        case 9: {
            fill(PURPLE);
            break;
        }
    }
    if (NUM % 2 == 0) {
        rect(width/4, height/4, width/2, height/2);
    } else {
        circle(width * 0.5, height * 0.5, width * 0.5);
    }
}
