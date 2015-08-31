args = {...}

if #args < 3 then
	print("Usage: box <length> <width> <height>")
	return
end

length, width, height = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])

if height < 3 then
	print("Height must be at least 3!")
	return
end

--------------------------------------------------------------------------------------------

function checkFuel()
	if turtle.getFuelLevel() < 1 then
		print("Out of fuel! Place fuel in inventory and press enter!")
		while true do
			event, k = os.pullEvent("key")
			if k == keys.enter then break end
		end
		for i=1,16 do
			turtle.select(i)
			turtle.refuel()
		end
		checkFuel()
	end
end

function waitForRefill()
	print("Out of materials! Refill and press enter!")
	while true do
		event, k = os.pullEvent("key")
		if k == keys.enter then break end
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

function placeDown()
	local count = 0
	checkFuel()
	while not turtle.placeDown() and not turtle.compareDown() and count < 50 do
		checkFuel()
		turtle.attackDown()
		if turtle.detectDown() then digDown() end
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

function up()
	local count = 0
	checkFuel()
	while not turtle.up() and count < 50 do
		checkFuel()
		turtle.attackUp()
		if turtle.detectUp() then
			checkFuel()
			digUp()
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

function blockAvailable()
	if turtle.getItemCount() < 2 then
		ns = turtle.getSelectedSlot() + 1
		if ns > 16 then waitForRefill(); ns = 1 end
		turtle.select(ns)
	end
end

------------------------------------------------------------------------------------------

tr = true

for w=1,width do

	for l=1,length do
		blockAvailable()

		placeDown()

		if l < length then
			forward()
		end
	end

	if w < width then
		if tr then
			tr = false
			right()
		else
			tr = true
			left()
		end
	end
end

turtle.up()

ol = tr

if tr then
	turtle.turnRight(); turtle.turnRight()
else
	turtle.turnRight()
end

for h=1,height-2 do

	for r=1,4 do
		if ol then
			for l=1,length do
				blockAvailable()
				if l > 1 then placeDown() end
				if l < length then
					forward()
				end
			end
			ol = false
		else
			for w=1,width do
				blockAvailable()
				if w > 1 then placeDown() end
				if w < width then
					forward()
				end
			end
			ol = true
		end
		turtle.turnRight()
	end

	turtle.up()
end

for w=1,width do

	for l=1,length do
		blockAvailable()

		placeDown()

		if l < length then
			forward()
		end
	end

	if w < width then
		if tr then
			tr = false
			right()
		else
			tr = true
			left()
		end
	end
end