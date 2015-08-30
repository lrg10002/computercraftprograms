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
	count = 0
	while not turtle.dig() and count < 50 and turtle.detect() do
		turtle.attack()
		sleep(0.5)
		count = count + 1
	end
end

function digUp()
	count = 0
	while not turtle.digUp() and count < 50 and turtle.detectUp() do
		turtle.attackUp()
		sleep(0.5)
		count = count + 1
	end
end

function digDown()
	count = 0
	while not turtle.digDown() and count < 50 and turtle.detectDown() do
		turtle.attackDown()
		sleep(0.5)
		count = count + 1
	end
end

function forward()
	count = 0
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
	count = 0
	while not turtle.down() and count < 50 do
		turtle.attackDown()
		if turtle.detectDown() then
			digDown()
		end
		sleep(0.5)
		count = count + 1
	end
	ch = ch + 1
end



function left(ud)
	turtle.turnLeft()
	dig()
	forward()
	turtle.turnLeft()
	if ud then
		digUp()
		digDown()
	end
end

function right(ud)
	turtle.turnRight()
	dig()
	forward()
	turtle.turnRight()
	if ud then
		digUp()
		digDown()
	end
end

function dropAll()
	for i=1,16 do
		turtle.select(i)
		turtle.drop()
	end
end

tr = true

while ch <= math.ceil(height/3)*3 do
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
	end
end

while ch <= height % 3 do

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

