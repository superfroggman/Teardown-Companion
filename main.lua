local sprite
local pos
function init()
	sprite = LoadSprite("dog.png")
	pos = GetPlayerTransform().pos
end

function tick()
	local playerPos = GetPlayerTransform().pos
	local posDiff = VecSub(playerPos, pos)
	local posChange = VecScale(posDiff, 1/VecLength(posDiff))

	pos = VecAdd(pos, VecScale(posDiff, 0.01))
	DebugPrint(pos[1])

	local t = Transform(VecAdd(pos, Vec(0, 0.5, 0)),  GetCameraTransform().rot)
	DebugPrint(GetPlayerTransform().rot[2])
	DrawSprite(sprite, t, 2, 2, 1, 1, 1, 1)

end


