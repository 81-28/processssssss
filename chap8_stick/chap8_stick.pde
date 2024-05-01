// イライラ棒

void setup() {
    size(960, 540); //画面サイズ
}

int t = 0; //経過時間
int ts = 0; //基準の時間
float c = 0; //色:赤さ
int xo = 480;
int yo = 270; //大円の中心座標(width,height使いたいけどこの階層ではムリ)
int r = 180; //大円の半径
int w = 90; //棒の幅
int v = 8; //角速度
int z = 31; //アウトゾーンの大きさ
int rc = 80; //スタートボタンなどの円の大きさ
int f = 0; //フラグ管理　0/1/2/3/x スタート前/往/復/クリア/ゲームオーバー

float backdist(float x, float y){
    if (abs(x - xo) > r) {
        return abs(y - yo) -(w / 2 -z);
    } //棒との距離
    else if (abs(y - yo) > (w / 2)) {
        return dist(x, y, xo, yo) - (r - z);
    } //大円との距離
    else if (x < xo && y < yo) {
        return z - dist(x, y, xo - r, yo - (w / 2));
    } //左上の角との距離
    else if (x < xo && y >= yo) {
        return z - dist(x, y, xo - r, yo + (w / 2));
    } //左下
    else if (x >= xo && y < yo) {
        return z - dist(x, y, xo + r, yo - (w / 2));
    } //右上
    else {
        return z - dist(x, y, xo + r, yo + (w / 2));
    } //右下
} //マウスの位置と背景との距離、近いほど大きくなる(最大31)

float circledist(float x, float y, float xc, float yc){
    return (r / 2 + z) - dist(x, y, xc, yc);
} //マウスの位置と小円の中心との距離、近いほど大きくなる(最大121)

void draw(){
    float s1 = (t * v % 360) * PI / 180; //円1の中心座標を定める角度
    float s2 = ((t * v + 180) % 360) * PI / 180; //円2の中心座標を定める角度
    float xc1 = xo + r * cos(s1) / 2;
    float yc1 = yo + r * sin(s1) / 2; //円1の中心座標
    float xc2 = xo + r * cos(s2) / 2;
    float yc2 = yo + r * sin(s2) / 2; //円2の中心座標
    float dc1 = 0; //マウスの位置と小円1との距離
    float dc2 = 0; //マウスの位置と小円2との距離

    float dback = backdist(mouseX, mouseY); //マウスの位置と背景との距離
    if (circledist(mouseX, mouseY, xc1, yc1) <= z) {
        dc1 = circledist(mouseX, mouseY, xc1, yc1);
    } //小円1の外側31以内にマウスがあれば距離に応じて数を代入(近いと31)
    else if (f == 1 || f == 2) {
        f = 4;
    } //circledistが32~121つまり小円1の内部にある時、ゲーム中ならゲームオーバーに移行
    if (circledist(mouseX, mouseY, xc2, yc2) <= z) {
        dc2 = circledist(mouseX, mouseY, xc2, yc2);
    }
    else if (f == 1 || f == 2) {
        f = 4;
    } //小円2でも同様に

    if (abs(mouseY - yo) >= (w / 2) && dist(mouseX, mouseY, xo, yo) > r) {
        if (f == 1 || f == 2) {
            f = 4;
        }
    } //背景の黒い(赤い)部分に触れた時、ゲーム中ならゲームオーバーに移行

    if (keyPressed) {
        if (key == 'r') {
            f = 0;
        }
    } //rキーでスタート前に移行

    if (f == 0 || f == 3) {
        c = 0;
    } //ゲーム開始前、クリア後の背景は黒
    else if (f == 1 || f == 2) {
        c = max(dback, dc1, dc2) * 254 / z;
    } //ゲーム中の背景は、アウトゾーンとの最大の近さ(~31)を約8倍して近いほど赤くなる
    else {
        c = 255;
    } //ゲームオーバー時の背景は赤

    background(c, 0, 0); //背景色
    noStroke();
    fill(255);
    rect(0, (height - w) / 2, width, w);
    circle(xo, yo, r * 2); //棒と大円を描画

    fill(c, 0, 0);
    circle(xc1, yc1, r);
    circle(xc2, yc2, r); //小円2つを描画

    textSize(15); //テキストサイズをリセット

    if (f == 0) {
        fill(255, 191, 0);
        circle(50, yo, rc);
        fill(255, 0, 0);
        text("START!", 25, yo);
        ts = t;
        if (dist(mouseX, mouseY, 50, yo) <= (rc / 2)) {
            f = 1;
            ts = t;
        }
    } //スタート前、スタートボタンを表示、往に移行時に経過時間を基準に設定
    else if (f == 1) {
        fill(0, 191, 191);
        circle(910, yo, rc);
        fill(255, 0, 0);
        text("GET!", 895, yo);
        if (dist(mouseX, mouseY, 910, yo) <= (rc / 2)) {
            f = 2;
        }
    } //往路、中間地点を表示
    else if (f == 2) {
        fill(127, 255, 0);
        circle(50, yo, rc);
        fill(255, 0, 0);
        text("GOAL!", 30, yo);
        if (dist(mouseX, mouseY, 50, yo) <= (rc / 2)) {
            f = 3;
        }
    } //復路、ゴールを表示
    else if (f == 3) {
        fill(0);
        circle(170, yo, rc);
        fill(255);
        text("RESTART", 145, yo);
        fill(255, 255, 0);
        textSize(50);
        text("CLEAR!", 640, 100);
        ts ++;
        if (dist(mouseX, mouseY, 170, yo) <= (rc / 2)) {
            f = 1;
            ts = t;
        }
    } //クリア、リスタートボタンを表示、基準の時間も増やし続けることで実質タイマーを停止、リスタートすると現在の経過時間を基準に設定
    else {
        fill(255, 0, 0);
        circle(50, yo, rc);
        fill(255);
        text("RESTART", 25, yo);
        fill(0);
        textSize(50);
        text("GAME OVER", 640, 100);
        ts ++;
        if (dist(mouseX, mouseY, 50, yo) <= (rc / 2)) {
            f = 1;
            ts = t;
        }
    } //ゲームオーバー、クリアと同様

    fill(255);
    textSize(50);
    text((t - ts) / 60.0, 200, 100); //基準の時間からどのくらい経過しているかを秒で表示
    t ++; //時間を経過させる
}
