args = {...}

length, width, height = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
cl, cw, ch = 1, 1, 1

compact = height < 3

function toss()
	for i=1,16 do
		turtle.select(i)
		turtle.dropUp()
	end
end

function dig()
	local count = 0
	while not turtle.dig() and count < 50 and turtle.detect() do
		turtle.attack()
		sleep(0.5)
		count = count + 1
	end
end

function digUp()
	local count = 0
	while not turtle.digUp() and count < 50 and turtle.detectUp() do
		turtle.attackUp()
		sleep(0.5)
		count = count + 1
	end
end

function digDown()
	local count = 0
	while not turtle.digDown() and count < 50 and turtle.detectDown() do
		turtle.attackDown()
		sleep(0.5)
		count = count + 1
	end
end

function forward()
	local count = 0
	while not turtle.forward() and count < 50 do
		turtle.attack()
		if turtle.detect() then
			dig()
		end
		sleep(0.5)
		count = count + 1
	end
end

function down()
	local count = 0
	while not turtle.down() and count < 50 do
		turtle.attackDown()
		if turtle.detectDown() then
			digDown()
		end
		sleep(0.5)
		count = count + 1
	end
end



function left(ud)
	turtle.turnLeft()
	dig()
	forward()
	turtle.turnLeft()
end

function right(ud)
	turtle.turnRight()
	dig()
	forward()
	turtle.turnRight()
end

function dropAll()
	for i=1,16 do
		turtle.select(i)
		turtle.drop()
	end
end

tr = true

while ch <= math.floor(height/3)*3 do
	ch = ch + 2
	digDown()
	down()

	for wwidth=1,width do
		cw = wwidth

		for llength=1,length do
			cl = llength

			if cl < length then
				dig()
				digUp()
				digDown()
				forward()
			end
		end

		digUp()
		digDown()
		if cw < width then
			if tr then
				tr = false
				right(true)
			else
				tr = true
				left(true)
			end
			toss()
		end
		
	end

	if ch < height then
		turtle.turnLeft(); turtle.turnLeft()
		digDown()
		down()
		digDown()
		down()
	end
	ch = ch + 1
end

while ch <= height do
	ch = ch + 1
	print("start, ch " .. ch .. " and height " .. height)

	for wwidth=1,width do
		cw = wwidth

		for llength=1,length do
			cl = llength

			if cl < length then
				dig()
				forward()
			end
		end

		if cw < width then
			if tr then
				tr = false
				right(false)
			else
				tr = true
				left(false)
			end
			toss()
		end
		
	end

	if ch < height then
		turtle.turnLeft(); turtle.turnLeft()
		digDown()
		down()
	end
end

--[[
for hheight=1,height do
	ch = hheight

	for wwidth=1,width do
		cw = wwidth

		for llength=1,length do
			cl = llength

			if cl < length then
				dig()
				forward()
			end
		end

		if cw < width then
			if tr then
				tr = false
				right()
			else
				tr = true
				left()
			end
			toss()
		end
		
	end

	if ch < height then
		turtle.turnLeft(); turtle.turnLeft()
		digDown()
		down()
	end
end
]]--

