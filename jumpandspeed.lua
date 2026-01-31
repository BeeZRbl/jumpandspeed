<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trò Chơi Nhảy Cao - UI Tối</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
            color: #e0e0e0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            width: 100%;
            padding: 20px;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            border-bottom: 1px solid #333;
        }

        h1 {
            font-size: 2.5rem;
            color: #00ff9d;
            text-shadow: 0 0 10px rgba(0, 255, 157, 0.5);
            margin-bottom: 10px;
        }

        .subtitle {
            color: #8a8a8a;
            font-size: 1.1rem;
        }

        .game-area {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 30px;
        }

        .game-container {
            flex: 2;
            min-width: 300px;
            background-color: #121212;
            border-radius: 15px;
            padding: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border: 1px solid #333;
        }

        .game-canvas-container {
            position: relative;
            width: 100%;
            height: 400px;
            overflow: hidden;
            border-radius: 10px;
            background-color: #0a0a0a;
        }

        #gameCanvas {
            width: 100%;
            height: 100%;
            display: block;
        }

        .controls-container {
            flex: 1;
            min-width: 250px;
            background-color: #121212;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border: 1px solid #333;
        }

        .control-group {
            margin-bottom: 25px;
        }

        h2 {
            color: #00ff9d;
            font-size: 1.5rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #333;
        }

        .slider-container {
            margin-bottom: 20px;
        }

        .slider-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .slider-label span {
            font-weight: 600;
        }

        .slider-value {
            color: #00ff9d;
            font-weight: bold;
        }

        .slider {
            width: 100%;
            height: 8px;
            -webkit-appearance: none;
            appearance: none;
            background: #333;
            border-radius: 4px;
            outline: none;
        }

        .slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #00ff9d;
            cursor: pointer;
            box-shadow: 0 0 10px rgba(0, 255, 157, 0.7);
        }

        .slider::-moz-range-thumb {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #00ff9d;
            cursor: pointer;
            border: none;
            box-shadow: 0 0 10px rgba(0, 255, 157, 0.7);
        }

        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        button {
            flex: 1;
            padding: 14px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        #jumpBtn {
            background-color: #00ff9d;
            color: #121212;
        }

        #jumpBtn:hover {
            background-color: #00cc7a;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 255, 157, 0.3);
        }

        #resetBtn {
            background-color: #333;
            color: #e0e0e0;
        }

        #resetBtn:hover {
            background-color: #444;
            transform: translateY(-3px);
        }

        .game-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding: 15px;
            background-color: #0a0a0a;
            border-radius: 10px;
            border: 1px solid #333;
        }

        .stat {
            text-align: center;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: #00ff9d;
            line-height: 1;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #8a8a8a;
            margin-top: 5px;
        }

        .instructions {
            margin-top: 30px;
            padding: 20px;
            background-color: #121212;
            border-radius: 15px;
            border: 1px solid #333;
        }

        .instructions h2 {
            margin-bottom: 15px;
        }

        .instructions ul {
            padding-left: 20px;
            line-height: 1.6;
        }

        .instructions li {
            margin-bottom: 8px;
        }

        .instructions strong {
            color: #00ff9d;
        }

        .game-character {
            position: absolute;
            bottom: 0;
            left: 50px;
            width: 60px;
            height: 80px;
            transition: bottom 0.3s ease;
        }

        .character-body {
            position: absolute;
            bottom: 0;
            left: 10px;
            width: 40px;
            height: 60px;
            background-color: #00ff9d;
            border-radius: 20px 20px 10px 10px;
        }

        .character-head {
            position: absolute;
            bottom: 60px;
            left: 15px;
            width: 30px;
            height: 30px;
            background-color: #ffcc80;
            border-radius: 50%;
        }

        .obstacle {
            position: absolute;
            bottom: 0;
            width: 30px;
            height: 40px;
            background-color: #ff4d4d;
            border-radius: 5px;
        }

        .ground {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 20px;
            background-color: #444;
        }

        @media (max-width: 768px) {
            .game-area {
                flex-direction: column;
            }
            
            h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>TRÒ CHƠI NHẢY CAO</h1>
            <p class="subtitle">Điều chỉnh tốc độ và độ cao nhảy - Giao diện tối</p>
        </header>

        <div class="game-area">
            <div class="game-container">
                <div class="game-canvas-container">
                    <canvas id="gameCanvas"></canvas>
                    <div id="gameCharacter" class="game-character">
                        <div class="character-head"></div>
                        <div class="character-body"></div>
                    </div>
                    <div id="ground" class="ground"></div>
                </div>
                
                <div class="game-stats">
                    <div class="stat">
                        <div class="stat-value" id="jumpCount">0</div>
                        <div class="stat-label">Số lần nhảy</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" id="maxHeight">0m</div>
                        <div class="stat-label">Độ cao tối đa</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" id="gameSpeed">1.0x</div>
                        <div class="stat-label">Tốc độ</div>
                    </div>
                </div>
            </div>

            <div class="controls-container">
                <h2>ĐIỀU KHIỂN</h2>
                
                <div class="control-group">
                    <div class="slider-container">
                        <div class="slider-label">
                            <span>Tốc độ trò chơi</span>
                            <span class="slider-value" id="speedValue">1.0</span>
                        </div>
                        <input type="range" min="0.5" max="3.0" step="0.1" value="1.0" class="slider" id="speedSlider">
                    </div>
                    
                    <div class="slider-container">
                        <div class="slider-label">
                            <span>Độ cao nhảy</span>
                            <span class="slider-value" id="heightValue">300</span>
                        </div>
                        <input type="range" min="100" max="500" step="10" value="300" class="slider" id="heightSlider">
                    </div>
                    
                    <div class="slider-container">
                        <div class="slider-label">
                            <span>Trọng lực</span>
                            <span class="slider-value" id="gravityValue">0.5</span>
                        </div>
                        <input type="range" min="0.1" max="1.5" step="0.1" value="0.5" class="slider" id="gravitySlider">
                    </div>
                </div>
                
                <div class="buttons">
                    <button id="jumpBtn">NHẢY!</button>
                    <button id="resetBtn">ĐẶT LẠI</button>
                </div>
                
                <div class="instructions">
                    <h3>Cách chơi</h3>
                    <ul>
                        <li>Nhấn nút <strong>NHẢY!</strong> hoặc phím <strong>SPACE</strong> để nhảy</li>
                        <li>Điều chỉnh thanh trượt để thay đổi tốc độ và độ cao nhảy</li>
                        <li>Tránh các chướng ngại vật màu đỏ</li>
                        <li>Mục tiêu: đạt độ cao tối đa và vượt qua nhiều chướng ngại vật nhất</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Lấy các phần tử DOM
        const gameCanvas = document.getElementById('gameCanvas');
        const gameCharacter = document.getElementById('gameCharacter');
        const ground = document.getElementById('ground');
        const jumpBtn = document.getElementById('jumpBtn');
        const resetBtn = document.getElementById('resetBtn');
        const speedSlider = document.getElementById('speedSlider');
        const heightSlider = document.getElementById('heightSlider');
        const gravitySlider = document.getElementById('gravitySlider');
        const speedValue = document.getElementById('speedValue');
        const heightValue = document.getElementById('heightValue');
        const gravityValue = document.getElementById('gravityValue');
        const jumpCountElement = document.getElementById('jumpCount');
        const maxHeightElement = document.getElementById('maxHeight');
        const gameSpeedElement = document.getElementById('gameSpeed');
        
        const ctx = gameCanvas.getContext('2d');
        
        // Thiết lập kích thước canvas
        function resizeCanvas() {
            const container = gameCanvas.parentElement;
            gameCanvas.width = container.clientWidth;
            gameCanvas.height = container.clientHeight;
        }
        
        window.addEventListener('resize', resizeCanvas);
        resizeCanvas();
        
        // Biến trò chơi
        let game = {
            isJumping: false,
            jumpHeight: 0,
            jumpCount: 0,
            maxHeight: 0,
            speed: 1.0,
            jumpPower: 300,
            gravity: 0.5,
            velocity: 0,
            obstacles: [],
            gameRunning: true,
            lastObstacleTime: 0,
            obstacleInterval: 2000
        };
        
        // Khởi tạo trò chơi
        function initGame() {
            game.isJumping = false;
            game.jumpHeight = 0;
            game.jumpCount = 0;
            game.maxHeight = 0;
            game.speed = parseFloat(speedSlider.value);
            game.jumpPower = parseInt(heightSlider.value);
            game.gravity = parseFloat(gravitySlider.value);
            game.velocity = 0;
            game.obstacles = [];
            game.gameRunning = true;
            game.lastObstacleTime = 0;
            
            // Cập nhật hiển thị
            updateDisplay();
            
            // Đặt lại vị trí nhân vật
            gameCharacter.style.bottom = '0px';
            
            // Bắt đầu vòng lặp trò chơi
            requestAnimationFrame(gameLoop);
        }
        
        // Vòng lặp trò chơi
        function gameLoop(timestamp) {
            if (!game.gameRunning) return;
            
            // Xóa canvas
            ctx.clearRect(0, 0, gameCanvas.width, gameCanvas.height);
            
            // Vẽ nền
            drawBackground();
            
            // Cập nhật vật cản
            updateObstacles(timestamp);
            
            // Vẽ vật cản
            drawObstacles();
            
            // Cập nhật nhảy
            if (game.isJumping) {
                updateJump();
            }
            
            // Kiểm tra va chạm
            checkCollisions();
            
            // Tiếp tục vòng lặp
            requestAnimationFrame(gameLoop);
        }
        
        // Vẽ nền
        function drawBackground() {
            // Vẽ nền sao
            ctx.fillStyle = '#0a0a0a';
            ctx.fillRect(0, 0, gameCanvas.width, gameCanvas.height);
            
            // Vẽ một số ngôi sao
            ctx.fillStyle = '#444';
            for (let i = 0; i < 50; i++) {
                const x = (i * 37) % gameCanvas.width;
                const y = (i * 23) % gameCanvas.height;
                const size = (i % 3) + 1;
                ctx.fillRect(x, y, size, size);
            }
        }
        
        // Cập nhật vật cản
        function updateObstacles(timestamp) {
            // Tạo vật cản mới
            if (timestamp - game.lastObstacleTime > game.obstacleInterval / game.speed) {
                game.obstacles.push({
                    x: gameCanvas.width,
                    width: 30,
                    height: 30 + Math.random() * 30,
                    speed: 3 * game.speed
                });
                game.lastObstacleTime = timestamp;
            }
            
            // Di chuyển vật cản
            for (let i = game.obstacles.length - 1; i >= 0; i--) {
                const obstacle = game.obstacles[i];
                obstacle.x -= obstacle.speed;
                
                // Xóa vật cản đã ra khỏi màn hình
                if (obstacle.x + obstacle.width < 0) {
                    game.obstacles.splice(i, 1);
                }
            }
        }
        
        // Vẽ vật cản
        function drawObstacles() {
            game.obstacles.forEach(obstacle => {
                // Tạo hiệu ứng gradient cho vật cản
                const gradient = ctx.createLinearGradient(
                    obstacle.x, 
                    gameCanvas.height - obstacle.height, 
                    obstacle.x + obstacle.width, 
                    gameCanvas.height
                );
                gradient.addColorStop(0, '#ff4d4d');
                gradient.addColorStop(1, '#cc0000');
                
                ctx.fillStyle = gradient;
                ctx.fillRect(obstacle.x, gameCanvas.height - obstacle.height, obstacle.width, obstacle.height);
                
                // Thêm hiệu ứng bóng
                ctx.fillStyle = 'rgba(0, 0, 0, 0.2)';
                ctx.fillRect(obstacle.x, gameCanvas.height - obstacle.height, obstacle.width, 5);
            });
        }
        
        // Cập nhật nhảy
        function updateJump() {
            // Áp dụng trọng lực
            game.velocity -= game.gravity;
            game.jumpHeight += game.velocity;
            
            // Nếu chạm đất
            if (game.jumpHeight <= 0) {
                game.jumpHeight = 0;
                game.isJumping = false;
                game.velocity = 0;
            }
            
            // Cập nhật độ cao tối đa
            if (game.jumpHeight > game.maxHeight) {
                game.maxHeight = game.jumpHeight;
            }
            
            // Cập nhật vị trí nhân vật
            gameCharacter.style.bottom = game.jumpHeight + 'px';
            
            // Cập nhật hiển thị
            updateDisplay();
        }
        
        // Kiểm tra va chạm
        function checkCollisions() {
            const characterBottom = game.jumpHeight;
            const characterLeft = 50;
            const characterRight = 110;
            const characterTop = characterBottom + 80;
            
            for (const obstacle of game.obstacles) {
                const obstacleLeft = obstacle.x;
                const obstacleRight = obstacle.x + obstacle.width;
                const obstacleTop = gameCanvas.height - obstacle.height;
                
                // Kiểm tra va chạm
                if (
                    characterRight > obstacleLeft &&
                    characterLeft < obstacleRight &&
                    characterTop > obstacleTop
                ) {
                    // Va chạm xảy ra
                    game.gameRunning = false;
                    alert(`Trò chơi kết thúc! Bạn đã nhảy ${game.jumpCount} lần và đạt độ cao tối đa ${Math.round(game.maxHeight)}px.`);
                    initGame(); // Khởi động lại trò chơi
                    break;
                }
            }
        }
        
        // Thực hiện nhảy
        function jump() {
            if (!game.isJumping && game.gameRunning) {
                game.isJumping = true;
                game.velocity = game.jumpPower / 50;
                game.jumpCount++;
                updateDisplay();
            }
        }
        
        // Cập nhật hiển thị
        function updateDisplay() {
            jumpCountElement.textContent = game.jumpCount;
            maxHeightElement.textContent = Math.round(game.maxHeight) + 'px';
            gameSpeedElement.textContent = game.speed.toFixed(1) + 'x';
        }
        
        // Sự kiện thanh trượt
        speedSlider.addEventListener('input', function() {
            game.speed = parseFloat(this.value);
            speedValue.textContent = this.value;
            gameSpeedElement.textContent = game.speed.toFixed(1) + 'x';
        });
        
        heightSlider.addEventListener('input', function() {
            game.jumpPower = parseInt(this.value);
            heightValue.textContent = this.value;
        });
        
        gravitySlider.addEventListener('input', function() {
            game.gravity = parseFloat(this.value);
            gravityValue.textContent = this.value;
        });
        
        // Sự kiện nút nhảy
        jumpBtn.addEventListener('click', jump);
        
        // Sự kiện nút đặt lại
        resetBtn.addEventListener('click', initGame);
        
        // Sự kiện bàn phím
        document.addEventListener('keydown', function(event) {
            if (event.code === 'Space') {
                event.preventDefault();
                jump();
            }
        });
        
        // Khởi tạo trò chơi
        initGame();
    </script>
</body>
</html>
