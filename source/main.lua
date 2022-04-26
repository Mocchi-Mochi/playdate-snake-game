-- SNAKE GAME

import "CoreLibs/graphics"
--import "CoreLibs/object"
local gfx <const> = playdate.graphics

local posX = 0
local posY = 0
local lastButtonPressed = 0 -- 0 RIGHT, 1 LEFT, 2 UP, 3 DOWN

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
	
	gfx.fillRect(posX, posY, 10, 10)
end

function playdate.leftButtonDown() leftDown = true end
function playdate.rightButtonDown() rightDown = true end
function playdate.upButtonDown() upDown = true end
function playdate.downButtonDown() downDown = true end