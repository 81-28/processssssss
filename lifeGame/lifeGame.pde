// life game

// フレームレート
int fps = 60;
// 誕生率の逆数
int birthRate = 12;

// 列数と行数
int cols, rows;
// 1セルの幅
int resolution = 4;
// 配列を定義
int[][] grid;
// 世代数
int gen = 0;

// グリッドをリセット
void resetGrid() {
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            if (floor(random(birthRate)) == 0) {
                // セルを生に設定
                grid[i][j] = 1;
            } else {
                // セルを死に設定
                grid[i][j] = 0;
            }
        }
    }
    gen = 0;
}

// 近傍のセルを数える
int countNeighbors(int x, int y) {
    int sum = 0;
    
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            int col = (x + i + cols) % cols;
            int row = (y + j + rows) % rows;
            sum += grid[col][row];
        }
    }
    
    sum -= grid[x][y];
    return sum;
}

// 新しいグリッドを計算
int[][] nextGrid() {
    int newGrid[][] = new int[cols][rows];
    // 次の世代を計算
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int state = grid[i][j];
            // 近傍のセルを数える
            int neighbors = countNeighbors(i, j);
            
            // ゲームのルールを適用
            if (state == 0 && neighbors == 3) {
                // セルを生に設定
                newGrid[i][j] = 1;
            } else if (state == 1 && (neighbors < 2 || 3 < neighbors)) {
                // セルを死に設定
                newGrid[i][j] = 0;
            } else {
                newGrid[i][j] = state;
            }
        }
    }
    gen++;
    return newGrid;
}

void setup() {
    size(1200, 1000);
    frameRate(fps);

    // 列数を計算
    cols = width / resolution;
    // 行数を計算
    rows = height / resolution;
    // 配列を初期化
    grid = new int[cols][rows];
    
    // グリッドをリセット
    resetGrid();
    
    // テキストのサイズを設定
    textSize(32);
}

void draw() {
    // 背景を白に設定
    background(255);
    
    boolean update = true;
    if (keyPressed) {
        // スペースキーが押されている場合
        if (key == ' ') {
            update = false;
        }
        // rキーが押されている場合
        if (key == 'r') {
            update = false;
            // グリッドをリセット
            resetGrid();
        }
    }
    if (update) {   
        // グリッドを更新
        grid = nextGrid();
    }
    
    // マウスの位置のセルを切り替える
    if (mousePressed) {
        // マウスの位置をセルのインデックスに変換
        int col = mouseX / resolution;
        int row = mouseY / resolution;

        // インデックスがグリッドの範囲内にあることを確認
        if (0 <= col && col < cols && 0 <= row && row < rows) {
            if (mouseButton == LEFT) {
                // 左クリックでセルを生に設定
                grid[col][row] = 1;
            } else if (mouseButton == RIGHT) {
                // 右クリックでセルを死に設定
                grid[col][row] = 0;
            }
        }
    }

    // グリッドを描画
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            float x = i * resolution;
            float y = j * resolution;
            
            if (grid[i][j] == 1) {
                // セルを黒に設定
                fill(0);
                // セルを描画
                rect(x, y, resolution, resolution);
            }
        }
    }
    // 文字色を灰色に設定
    fill(127);
    // 現在の世代数を表示
    text("Generation: " + gen, 10, 30);
}