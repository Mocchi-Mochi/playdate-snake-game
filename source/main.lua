-- SNAKE GAME

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

local posX = 0
local posY = 0
local lastButtonPressed = 0 -- 0 RIGHT, 1 LEFT, 2 UP, 3 DOWN
local velocity = 10 -- This are the FPS. Max 30
local point = {-1 , 0}

function buttonPressed()
	if (playdate.buttonIsPressed(playdate.kButtonRight) and lastButtonPressed ~= 1) then
		lastButtonPressed = 0
	end
	
	if (playdate.buttonIsPressed(playdate.kButtonLeft) and lastButtonPressed ~= 0) then
		lastButtonPressed = 1
	end
	
	if (playdate.buttonIsPressed(playdate.kButtonUp) and lastButtonPressed ~= 3) then
		lastButtonPressed = 2
	end
	
	if (playdate.buttonIsPressed(playdate.kButtonDown) and lastButtonPressed ~= 2) then
		lastButtonPressed = 3
	end
end

function restartGame()
	posX = 0
	posY = 0
	lastButtonPressed = 0
	velocity = 10
end

function setNewPoint()
	point[1] = math.random(39) * 10
	point[2] = math.random(23) * 10
end

function playdate.update()
	gfx.clear()

	buttonPressed()
	
	if (lastButtonPressed == 0) then
		posX += 10
	elseif (lastButtonPressed == 1) then
		posX -= 10
	elseif (lastButtonPressed == 2) then
		posY -= 10
	elseif (lastButtonPressed == 3) then
		posY += 10
	end
	
	if posX < 0 or posX > 400 or posY < 0 or posY > 240 then
		restartGame()
	end
	
	if posX == point[1] and posY == point[2] or point[1] == -1 then
		setNewPoint()
	end
	
	gfx.fillRect(posX, posY, 10, 10) -- This is the snake
	gfx.fillRect(point[1], point[2], 10, 10) -- This is the point the snake has to eat
	
	playdate.display.setRefreshRate(10)
end

function playdate.leftButtonDown() leftDown = true end
function playdate.rightButtonDown() rightDown = true end
function playdate.upButtonDown() upDown = true end
function playdate.downButtonDown() downDown = true end
