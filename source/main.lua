-- SNAKE GAME

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

local posX = 0
local posY = 0
local lastButtonPressed = 0 -- 0 RIGHT, 1 LEFT, 2 UP, 3 DOWN
local velocity = 10 -- This are the FPS. Max 30
local point = {}
local tail = {}

local eatSound = playdate.sound.sampleplayer.new("assets/eat")
local initState = true

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

function restart()
	posX = 0
	posY = 0
	lastButtonPressed = 0
	velocity = 10
	point = {}
	tail = {}
	initState = true
end

function makeSnakeMove()
	if (lastButtonPressed == 0) then
		posX += 10
	elseif (lastButtonPressed == 1) then
		posX -= 10
	elseif (lastButtonPressed == 2) then
		posY -= 10
	elseif (lastButtonPressed == 3) then
		posY += 10
	end
end

function checkIfSnakeIsOutOfScreen()
	if posX < 0 or posX >= 400 or posY < 0 or posY >= 240 then
		restart()
	end
end

function checkIfSnakeHasEatenItself()
	for i = 1, #tail do
		if posX == tail[i][1] and posY == tail[i][2] then
			restart()
			return
		end
	end
end

function checkIfPointWasEaten()
	if posX == point[1] and posY == point[2] or point[1] == nil then
		if initState == false then eatSound:play() end
		initState = false
		point[1] = math.random(39) * 10
		point[2] = math.random(23) * 10
		table.insert(tail, {posX, posY})
		if velocity <= 30 then velocity += 1 end
	end
end

function printTail()
	for i = 1, #tail do
		if i == #tail then
			tail[#tail + 1 - i][1] = posX
			tail[#tail + 1 - i][2] = posY
		else
			tail[#tail + 1 - i][1] = tail[#tail - i][1]
			tail[#tail + 1 - i][2] = tail[#tail - i][2]
		end
	end
	for i = 1, #tail do
	  gfx.fillRect(tail[i][1], tail[i][2], 10, 10)
	end
end

function printOnScreen()
	gfx.clear()
	gfx.fillRect(posX, posY, 10, 10) -- This is the snake's head
	gfx.fillRect(point[1], point[2], 10, 10) -- This is the point the snake has to eat
	
	printTail() -- This is the snake's body
	
end

function playdate.update()
	buttonPressed()
	
	makeSnakeMove()
	
	checkIfSnakeIsOutOfScreen()
	checkIfSnakeHasEatenItself()
	
	checkIfPointWasEaten()
	
	printOnScreen()
	
	playdate.display.setRefreshRate(velocity)
end

function playdate.leftButtonDown() leftDown = true end
function playdate.rightButtonDown() rightDown = true end
function playdate.upButtonDown() upDown = true end
function playdate.downButtonDown() downDown = true end
