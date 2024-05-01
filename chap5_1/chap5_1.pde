//　smile

int hue = 0;

void setup()
{
    size(1440, 810);
    background(255);
    colorMode(HSB, 360, 100, 100);
}

void draw() {
}
void keyPressed() {
    if (key == CODED) {
        if (keyCode == SHIFT) {
            hue = (hue + 1) % 360;
            fill(hue, 100, 100);
            ellipse(mouseX, mouseY, 100, 100);

            fill((hue + 180) % 360, 100, 100);
            arc(mouseX, mouseY, 60, 60, radians(hue), radians(hue + 180), PIE);

            fill(255);
            ellipse(mouseX + 25 * cos(((hue + 225) % 360) * PI / 180), mouseY + 25 * sin(((hue + 225) % 360) * PI / 180), 10, 10);
            ellipse(mouseX + 25 * cos(((hue + 315) % 360) * PI / 180), mouseY + 25 * sin(((hue + 315) % 360) * PI / 180), 10, 10);
        }
    }
}
