//2023/7/22_0:44 最終更新
//最初の変数、上はいじれる,下は定義だけ。
//width,heightを変更せず,球の速さがブロックの幅を越えなければ破綻しない。

int fps_0 = 120; //通常fps
int fpsX = 4; //オートモード時のfps倍率
color bgcolor = color(0, 0, 31); //背景色
int boxX = 8; //横のブロック数
int boxY = 6; //縦のブロック数
int edge = 1; //縁取りの幅(判定に影響なし)
int v = 8; //球の速さ
int ballsize = 10; //球の大きさ(判定に影響なし)
int l = 100; //ガイドの長さ
float th = PI / 36; //ガイドの矢印の位置を決める角度
float barwidth = 160; //板の長さ
int c = 1; //スコア表示秒数の逆数
int p = 6; //ポーズ無効秒数の逆数


int fps = fps_0; //fps
int fps_a = fps_0 * fpsX; //オートモード時のfps
int f = 0; //シーン管理 0/1/2/3/4 スタート前/ゲーム中/ポーズ/クリア/ゲームオーバー
int boxes = boxX * boxY; //総ブロック数
int xbox = 0; //ブロックのx座標(若い方)
int ybox = 0; //ブロックのy座標(若い方)
boolean[] num = new boolean[boxes]; //各ブロックの有無の変数
int colX = v; //x方向の当たり判定の厚さ
int colY = v; //y方向の当たり判定の厚さ
boolean broken = false; //そのフレームで破壊が行われたか否か
float x = 720 / 2; //球のx座標
float y = 800 - (ballsize / 2); //球のy座標
float xp = x; //前のフレームのx座標
float yp = y; //前のフレームのy座標
float vx = 0; //球の速さのx成分
float vy = -v; //球の速さのy成分
float theta = PI / 2; //板で反射した時の角度
float xbar = 720 / 2; //板のx座標
int score = 0; //スコア
int nscore = 0; //最後に追加されたスコア
int max_score = 0; //ハイスコア
float time_score = 0; //タイムスコア
int total_score = 0; //トータルスコア
int max_clear_score = 0; //ハイクリアスコア
boolean preclear = false; //クリアしたことがあるか否か
int count = 0; //破壊ブロック数
int tPlus = fpsX; //1フレームにtに追加される数
int t = 0; //経過時間
int ts = 0; //基準の時間
int tc = fps_a / c; //スコアの表示t
int tsc = 0; //スコアの基準時間
int tp = fps_a / p; //ポーズ無効t
int tsp = 0; //ポーズの基準時間
int combo = 0; //コンボ数
boolean auto = false; //オートモードか否か
int tsa = 0; //オートモード切替基準時間

void setup() {
    size(720, 900);
    frameRate(fps);

    for (int i = 0; i < boxes; ++i) {
        num[i] = true;
    } //ブロックを全てある状態にする
}

void draw() {
    background(bgcolor);

    if (keyPressed) {
        if (key == 'a') {
            if (t - tsa >= tp) {
                auto = !auto;
                tsa = t;
            }
        }
    } //オートモード切替

    if (auto == true) {
        xbar = random(x - (barwidth / 2 - v) + 1, x + (barwidth / 2 - v));
        fps = fps_a;
        tPlus = 1;
    } else {
        xbar = mouseX;
        fps = fps_0;
        tPlus = fpsX;
    } //板の座標を指定

    frameRate(fps); //fpsを指定

    t += tPlus; //時間を経過させる

    if (x >= xbar - (barwidth / 2) && x < xbar + (barwidth / 2)) {
        theta = (90 - ((x -xbar) / (barwidth / 2)) * 60) * (PI / 180);
    } //(板に当たった時に使う)角度を取得

    if (f == 1) {   
        x += vx;
        y += vy;
    } //ゲーム中ならば球を動かす

    if (x < 0){
        x *= -1;
        vx *= -1;
    } else if (x >= 720) {
        x = width * 2 - x;
        vx *= -1;
    } //左右の壁での反射
    if (y < 0) {
        y *= -1;
        vy *= -1;
    } else if (y >= 800 && y < 800 + v) {
        if (x >= xbar - (barwidth / 2) && x <= xbar + (barwidth / 2)) {
            y = 1600 - y;
            vx = (v * cos(theta));
            vy = -(v * sin(theta));
            combo = 0;
        }
    } else if (y >= height) {
        f = 4;
    } //天井,板の反射と奈落判定

    noStroke();    
    colorMode(HSB, 360, 100, 100);

    int boxW = (width / boxX);
    int boxH = (height / (boxY * 3)); //ブロックの範囲,大きさを指定。void内じゃないとwidth,heightが使えない為ここに配置。
    colX = min(v, boxW);
    colY = min(v, boxH); //当たり判定の厚さを指定

    for (int i = 0; i < boxes; i++) {
        xbox = i % boxX;
        ybox = (i - xbox) / boxX; //x,y方向に何番目かを取得
        
        if(num[i] == true){
            if (x >= xbox * boxW && x < (xbox + 1) * boxW && y >= ybox * boxH && y < ybox * boxH + colY && yp < ybox * boxH){
                broken = true;
                y = 2 * ybox * boxH - y;
                vy *= -1;
            } else if (x >= xbox * boxW && x < (xbox + 1) * boxW && y >= (ybox + 1) * boxH - colY && y < (ybox + 1) * boxH && yp >= (ybox + 1) * boxH){
                broken = true;
                y = 2 * (ybox + 1) * boxH - y;
                vy *= -1;
            }
            if (x >= xbox * boxW && x < xbox * boxW + colX && y >= ybox * boxH && y < (ybox + 1) * boxH && xp < xbox * boxW){
                broken = true;
                x = 2 * xbox * boxW - x;
                vx *= -1;
            } else if (x >= (xbox + 1) * boxW - colX && x < (xbox + 1) * boxW && y >= ybox * boxH && y < (ybox + 1) * boxH && xp >= (xbox + 1) * boxW){
                broken = true;
                x = 2 * (xbox + 1) * boxW - x;
                vx *= -1;
            }
        } //ブロックの上下左右当たり判定
        
        if (broken == true) {
            num[i] = false;
            nscore = -score;
            score += pow(2, combo);
            nscore += score; //nscore = pow(2, combo);とはできなかった。冪乗はint型ではない？ = int(pow(2, combo));とすれば解決できるが、スコア計算式が一つになるので現在のモノを採用。
            tsc = t;
            count ++;
            combo ++;
            broken = false;
        } //破壊が行われていたらスコア,破壊ブロック数,コンボを追加
        if (count == boxes) {
            f = 3;
        } //ブロックが無くなったらクリア
    } //ブロック関係

    for (int i = 0; i < boxes; i++) {
        xbox = i % boxX;
        ybox = (i - xbox) / boxX;
        
        if(num[i] == true){
            if (x >= xbox * boxW && x < (xbox + 1) * boxW && y >= ybox * boxH && y < ybox * boxH + colY && yp < ybox * boxH){
                broken = true;
                y = 2 * ybox * boxH - y;
                vy *= -1;
            } else if (x >= xbox * boxW && x < (xbox + 1) * boxW && y >= (ybox + 1) * boxH - colY && y < (ybox + 1) * boxH && yp >= (ybox + 1) * boxH){
                broken = true;
                y = 2 * (ybox + 1) * boxH - y;
                vy *= -1;
            }
            if (x >= xbox * boxW && x < xbox * boxW + colX && y >= ybox * boxH && y < (ybox + 1) * boxH && xp < xbox * boxW){
                broken = true;
                x = 2 * xbox * boxW - x;
                vx *= -1;
            } else if (x >= (xbox + 1) * boxW - colX && x < (xbox + 1) * boxW && y >= ybox * boxH && y < (ybox + 1) * boxH && xp >= (xbox + 1) * boxW){
                broken = true;
                x = 2 * (xbox + 1) * boxW - x;
                vx *= -1;
            }
        }
        
        if (broken == true) {
            num[i] = false;
            nscore = -score;
            score += pow(2, combo);
            nscore += score;
            tsc = t;
            count ++;
            combo ++;
            broken = false;
        }
        if (count == boxes) {
            f = 3;
        }

        if(num[i] == true){
            fill(xbox * 360 / boxX, 100, 100);
            rect((xbox * boxW) + edge, (ybox * boxH) + edge, boxW - (edge * 2), boxH - (edge * 2));
        } //ブロックを描画
    } //ブロック関係2回目

    xp = x;
    yp = y; //x,y座標を保存

    if (f == 0) {
        x = 720 / 2;
        y = 800 - (ballsize / 2);
        for (int i = 0; i < boxes; ++i) {
            num[i] = true;
        } //球の位置とブロックの有無をリセットし続ける
        if (x >= xbar - (barwidth / 2) && x < xbar + (barwidth / 2)) {
            if (keyPressed) {
                if (key == ' ') {
                    f = 1;
                    tsp = t;
                    vx = (v * cos(theta));
                    vy = -(v * sin(theta));
                }
            } //スペースキーでスタート
            if (f == 0) {
                stroke(60, 100, 100);
                strokeWeight(2);
                line(x + (l * cos(theta)), y - (l * sin(theta)), x, y);
                line(x + (l * cos(theta)), y - (l * sin(theta)), x + (l * cos(theta - th)) * 9 / 10, y - (l * sin(theta - th)) * 9 / 10);
                line(x + (l * cos(theta)), y - (l * sin(theta)), x + (l * cos(theta + th)) * 9 / 10, y - (l * sin(theta + th)) * 9 / 10); //ガイドを描画
            }
        }
        score = 0;
        count = 0;
        combo = 0;
        nscore = 0;
        ts = t;
    } else if (f == 1) {
        if (keyPressed) {
            if (key == 'f') {
                f = 0;
            } else if (key == ' ') {
                if (t - tsp >= tp) {
                    f = 2;
                    tsp = t;
                }
            }
        }
    } else if (f == 2) {
        if (keyPressed) {
            if (key == 'f') {
                f = 0;
            } else if (key == ' ') {
                if (t - tsp >= tp) {
                    f = 1;
                    tsp = t;
                }
            }
        }
        ts += tPlus;
        tsc += tPlus;
    } else if (f == 3) {
        if (keyPressed) {
            if (key == 'f') {
                f = 0;
                count = 0;
            }
        }
        ts += tPlus;
    } else if (f == 4) {
        if (keyPressed) {
            if (key == 'f') {
                f = 0;  
                x = 720 / 2;
                y = 800 - (ballsize / 2);
            }
        }
        ts += tPlus;
    } //シーン移行の処理

    time_score = (t - ts) / float(fps_a);
    total_score = score - int(time_score);
    if (score >= max_score) {
        max_score = score;
    }
    if (f == 3) {
        if (preclear == false || total_score >= max_clear_score) {
            max_clear_score = total_score;
            preclear = true;
        }
    } //スコア関連を記録

    noStroke();

    fill(255);
    rect(xbar - (barwidth / 2), 800, barwidth, 8);
    circle(x, y, ballsize); //板,球の描画

    colorMode(RGB);
    textSize(30);

    if (f == 0) {
        fill(255, 127, 0);
        text("SPACE:START,PAUSE", 255, 450);
        text("F:RESTART", 320, 480);
    } else if (f == 2) {
        fill(0, 127);
        rect(0, 0, width, height);
        fill(255, 127, 0);
        text("SPACE:RESUME", 255, 450);
        text("F:RESTART", 320, 480);
    } else if (f == 3) {
        fill(0, 127);
        rect(0, 0, width, height);
        fill(255, 127, 0);
        text("F:RESTART", 320, 480);
        textSize(60);
        fill(255, 255, 0);
        text("CLEAR!", 250, 400);
    } else if (f == 4) {
        fill(0, 127);
        rect(0, 0, width, height);
        fill(255, 127, 0);
        text("F:RESTART", 320, 480);
        textSize(60);
        fill(255, 0, 0);
        text("GAME OVER", 200, 400);
    }

    textSize(30);
    fill(255);
    text(score, 350, 570);
    text(max_score, 170, 570);
    text(time_score, 495, 570);
    text(total_score, 350, 630);
    if (preclear == false) {
        text("-", 170, 630);
    } else {
        text(max_clear_score, 170, 630);
    }
    textSize(20);
    text("SCORE", 350, 540);
    text("HIGH SCORE", 170, 540);
    text("TIME", 500, 540);
    text("TOTAL SCORE", 350, 600);
    text("HIGH CLEAR SCORE", 170, 600);
    if (nscore > 0 && t - tsc < tc) {
        fill(255, 255, 0);
        text("+", 340, 510);
        text(nscore, 350, 510);
    } //テキストやスコアの描画
}