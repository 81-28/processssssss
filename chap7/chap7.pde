void setup() {
    size(800, 800);
    background(255);
    colorMode(HSB, 360, 100, 100);
}

float brightness = 0.000;   // 明度
int xnow = mouseX;
int ynow = mouseY;
int n = 200;

void draw() {
    if (width % n == 0 && height % n == 0) {
        noStroke();
        int boxW = (width / n);  // 長方形の幅
        int boxH = (height / n); // 長方形の高さ
        xnow = (9 * xnow + mouseX) / 10;
        ynow = (9 * ynow + mouseY) / 10;
        int xn = (xnow - (xnow % boxW)) / boxW;
        int yn = (ynow - (ynow % boxH)) / boxH;
        for (int x = 0; x < n; x++) {
            for (int y = 0; y < n; y++) {
                brightness = (1000 - sq(xn - x) - sq(yn - y)) / 10;
                fill(45, 90, brightness);
                rect(x * boxW, y * boxH, boxW, boxH);
            }
        }
    }
    else {
    println("Width or Height value is not available.");
    exit();
    }
}
