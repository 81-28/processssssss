// 図形の描画

void setup()
{
    size(540, 540);
    background(255);
}

void draw()
{
    ellipse(270, 270, 540, 540);
    triangle(0, 270, 270, 0, 270, 540);
    triangle(540, 270, 270, 0, 270, 540);
    rect(135, 135, 270, 270);
}
