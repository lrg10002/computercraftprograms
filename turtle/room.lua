args = {...}

if #args < 3 then
	print("Usage: room <length> <width> <height>")
	print("Place the turtle in the top left corner of the rectangular area")
	return
end

length, width, height = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
cl, cw, ch = 1, 1, 1

----------------------------------------------------------------------------------------------------------------

function checkFuel()
	if turtle.getFuelLevel() < 1 then
		print("Out of fuel! Place fuel in inventory and press enter!")
		while {os.pullEvent("key")}[2] ~= keys.enter do end
		for i=1,16 do
			turtle.select(i)
			turtle.refuel()
		end
		checkFuel()
	end
end

function dig()
	local count = 0
	checkFuel()
	while not turtle.dig() and count < 50 and turtle.detect() do
		checkFuel()
		turtle.attack()
		sleep(0.5)
		count = count + 1
	end
end

function digUp()
	local count = 0
	checkFuel()
	while not turtle.digUp() and count < 50 and turtle.detectUp() do
		checkFuel()
		turtle.attackUp()
		sleep(0.5)
		count = count + 1
	end
end

function digDown()
	local count = 0
	checkFuel()
	while not turtle.digDown() and count < 50 and turtle.detectDown() do
		checkFuel()
		turtle.attackDown()
		sleep(0.5)
		count = count + 1
	end
end

function forward()
	local count = 0
	checkFuel()
	while not turtle.forward() and count < 50 do
		checkFuel()
		turtle.attack()
		if turtle.detect() then
			checkFuel()
			dig()
		end
		sleep(0.5)
		count = count + 1
	end
end

function down()
	local count = 0
	checkFuel()
	while not turtle.down() and count < 50 do
		checkFuel()
		turtle.attackDown()
		if turtle.detectDown() then
			checkFuel()
			digDown()
		end
		sleep(0.5)
		count = count + 1
	end
end

function left()
	checkFuel()
	turtle.turnLeft()
	dig()
	checkFuel()
	forward()
	turtle.turnLeft()
end

function right()
	checkFuel()
	turtle.turnRight()
	dig()
	checkFuel()
	forward()
	turtle.turnRight()
end

-------------------------------------------------------------------------------------------------------------------

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
				right()
			else
				tr = true
				left()
			end
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
		end
		
	end

	if ch < height then
		turtle.turnLeft(); turtle.turnLeft()
		digDown()
		down()
	end

	ch = ch + 1
end
