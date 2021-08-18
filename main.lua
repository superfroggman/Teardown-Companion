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

	DebugPrint(VecLength(VecSub(playerPositions[1], playerPositions[stepAmount])))

	local amountWrong = 0
	for i = 1, stepAmount, 1 do
		if (VecLength(VecSub(playerPositions[i], playerPositions[stepAmount])) > VecLength(VecSub(pos, playerPositions[stepAmount]))) then
			DebugPrint("LONG" .. GetTime())
			amountWrong = amountWrong + 1
		else
			break
		end
	end

	if(amountWrong == 0) then
		pos = playerPositions[1]
	else
		pos = VecAdd(pos, VecScale(VecSub(playerPositions[amountWrong+1],pos), 1/amountWrong))
	end
	

	local t = Transform(VecAdd(pos, Vec(0, 0.5, 0)),  GetPlayerTransform().rot)
	DrawSprite(sprite, t, 2, 2, 1, 1, 1, 1, true)

end


