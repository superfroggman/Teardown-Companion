local sprite
local pos

local playerPositions = {}

local stepAmount = 300

function init()
	sprite = LoadSprite("dog.png")
	pos = GetPlayerTransform().pos

	for i = 1, stepAmount, 1 do
		playerPositions[i] = pos
	end
end

function tick()
	--Shift array
	table.remove(playerPositions, 1)
    table.insert(playerPositions, GetPlayerTransform().pos)

	--Get amount of steps in wrong direction
	local amountWrong = 0
	for i = 1, stepAmount, 1 do
		if (VecLength(VecSub(playerPositions[i], playerPositions[stepAmount])) > VecLength(VecSub(pos, playerPositions[stepAmount]))) then
			amountWrong = amountWrong + 1
		else
			break
		end
	end

	--Smooth movement if it would otherwise move in wrong direction
	if(amountWrong == 0) then
		pos = playerPositions[1]
	else
		pos = VecAdd(pos, VecScale(VecSub(playerPositions[amountWrong+1],pos), 1/amountWrong))
	end

	
	--Set position to always be on the ground
	local hit, d = QueryRaycast(VecAdd(pos, Vec(0, 0.75, 0)), Vec(0, -1, 0), 10)
	if hit then
		pos = VecAdd(pos, Vec(0, 1.2-d, 0))
	end
	
	--Draw sprite
	local t = Transform(VecAdd(pos, Vec(0, 0.5, 0)),  GetPlayerTransform().rot)
	DrawSprite(sprite, t, 2, 2, 1, 1, 1, 1, true)

	--Set position next to you if in a vehicle
	local vehicle = GetPlayerVehicle()
	if vehicle ~= 0 then
		if VecLength(VecSub(pos, GetVehicleTransform(vehicle).pos)) < 5 then
			pos = VecAdd(playerPositions[stepAmount], Vec(0,-2,0))
		end
	end

	for i = 1, stepAmount, 1 do
		DebugCross(playerPositions[i])
	end
end


