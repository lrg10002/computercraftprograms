args = {...}

length, width, height = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
cl, cw, ch = 1, 1, 1

compact = height < 3

function forward()
	count = 0
	while not turtle.forward() and count < 50 do
		turtle.attack()
		sleep(0.5)
		count = count + 1
	end
end

function down()
	count = 0
	while not turtle.down() and count < 50 do
		turtle.attackDown()
		sleep(0.5)
		count = count + 1
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

function left()
	turtle.turnLeft()
	dig()
	move()
	turtle.turnLeft()
end

function right()
	turtle.turnRight()
	dig()
	move()
	turtle.turnRight()
end

function dropAll()
	for i=1,16 do
		turtle.select(i)
		turtle.drop()
	end
end

tr = true

for hheight=1,height-1 do
	ch = hheight

	for wwidth=1,width-1 do
		cw = wwidth

		for llength=1,length-1 do
			cl = llength

			dig()
			forward()
		end

		if tr then
			tr = false
			right()
		else
			tr = true
			left()
		end
		
	end

	turtle.turnLeft(); turtle.turnLeft()
	digDown()
	down()
end


