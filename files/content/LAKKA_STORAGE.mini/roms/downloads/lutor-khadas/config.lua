
-- Libretro joypad buttons const
RETRO_DEVICE_ID_JOYPAD_B        = 1
RETRO_DEVICE_ID_JOYPAD_Y        = 2
RETRO_DEVICE_ID_JOYPAD_SELECT   = 3
RETRO_DEVICE_ID_JOYPAD_START    = 4
RETRO_DEVICE_ID_JOYPAD_UP       = 5
RETRO_DEVICE_ID_JOYPAD_DOWN     = 6
RETRO_DEVICE_ID_JOYPAD_LEFT     = 7
RETRO_DEVICE_ID_JOYPAD_RIGHT    = 8
RETRO_DEVICE_ID_JOYPAD_A        = 9
RETRO_DEVICE_ID_JOYPAD_X        = 10
RETRO_DEVICE_ID_JOYPAD_L        = 11
RETRO_DEVICE_ID_JOYPAD_R        = 12
RETRO_DEVICE_ID_JOYPAD_L2       = 13
RETRO_DEVICE_ID_JOYPAD_R2       = 14
RETRO_DEVICE_ID_JOYPAD_L3       = 15
RETRO_DEVICE_ID_JOYPAD_R3       = 16

default_config = {
	scale = 3,
	fullscreen = 0,
	vsync = true,
	sfx_volume = 1.0,
	music_volume = 0.5
	,keys = {
	up = "up", down = "down", left = "left", right = "right",
	select = "p",
	start = "return",
	L = "q",
	R = "w",
	B = "s",
	A = "a",
	X = "x",
	Y = "z",
	}
	,pads = {
	up = RETRO_DEVICE_ID_JOYPAD_UP,
	down = RETRO_DEVICE_ID_JOYPAD_DOWN,
	left = RETRO_DEVICE_ID_JOYPAD_LEFT,
	right = RETRO_DEVICE_ID_JOYPAD_RIGHT,
	select = RETRO_DEVICE_ID_JOYPAD_SELECT,
	start = RETRO_DEVICE_ID_JOYPAD_START,
	B = RETRO_DEVICE_ID_JOYPAD_B,
	A = RETRO_DEVICE_ID_JOYPAD_A,
	X = RETRO_DEVICE_ID_JOYPAD_X,
	Y = RETRO_DEVICE_ID_JOYPAD_Y,
	L = RETRO_DEVICE_ID_JOYPAD_L,
	R = RETRO_DEVICE_ID_JOYPAD_R,

--RETRO_DEVICE_ID_JOYPAD_B        = 1,
--RETRO_DEVICE_ID_JOYPAD_Y        = 2,
--RETRO_DEVICE_ID_JOYPAD_SELECT   = 3,
--RETRO_DEVICE_ID_JOYPAD_START    = 4,
--RETRO_DEVICE_ID_JOYPAD_UP       = 5,
--RETRO_DEVICE_ID_JOYPAD_DOWN     = 6,
--RETRO_DEVICE_ID_JOYPAD_LEFT     = 7,
--RETRO_DEVICE_ID_JOYPAD_RIGHT    = 8,
--RETRO_DEVICE_ID_JOYPAD_A        = 9,
--RETRO_DEVICE_ID_JOYPAD_X        = 10,
--RETRO_DEVICE_ID_JOYPAD_L        = 11,
--RETRO_DEVICE_ID_JOYPAD_R        = 12,

--[[
RETRO_DEVICE_ID_JOYPAD_L2       = 13,
RETRO_DEVICE_ID_JOYPAD_R2       = 14,

RETRO_DEVICE_ID_JOYPAD_L3       = 15,
RETRO_DEVICE_ID_JOYPAD_R3       = 16
]]

	}
--	,joykeys = {
--	jump = 1, shoot = 3, action = 2, pause = 8
--	}
}

--keynames = {"up","down","left","right","jump","shoot","action1","action2","action3","action4","quit","pause"}
--joykeynames = {"jump","shoot","action","pause"}

highscores = { {}, {}, {} }

stats = { 0, 0, 0, 0, 0, 0 }

keystate = {
--	oldaxis1 = 0, oldaxis2 = 0
}

function loadConfig()
	-- Read default settings first
	print("loadConfig")
	config = {}
	for i,v in pairs(default_config) do
		if type(v) == "table" then
			config[i] = {}
			for j,w in pairs(v) do
				config[i][j] = w
			end
		else
			config[i] = v
		end
	end
--	if love.filesystem.getInfo("settings")~= nil then
--		local data = love.filesystem.read("settings")
--		local file = TSerial.unpack(data)
--		for i,v in pairs(file) do
--			config[i] = v
--		end
--	end
	-- Avoid crash if fullscreen is a boolean from old version
--	if type(config.fullscreen) == "boolean" then
--		config.fullscreen = 0
--	end
end

function loadHighscores()
	if love.filesystem.getInfo("highscores")~= nil then
		local data = love.filesystem.read("highscores")
		local file = TSerial.unpack(data)
		for i=1,3 do
			if file[i] then
				highscores[i] = file[i]
			end
		end
	end
end

function loadStats()
	if love.filesystem.getInfo("stats")~= nil then
		local data = love.filesystem.read("stats")
		stats = TSerial.unpack(data)
	end
end

function saveConfig()
	local data = TSerial.pack(config)
	love.filesystem.write("settings", data)
end

function saveHighscores()
	local data = TSerial.pack(highscores)
	love.filesystem.write("highscores", data)
end

function saveStats()
	local data = TSerial.pack(stats)
	love.filesystem.write("stats", data)
end

function setMode()
	if config.fullscreen == 0 then
		love.window.setMode(WIDTH*config.scale, HEIGHT*config.scale, {fullscreen=false, vsync=config.vsync})
		love.graphics.setScissor()
	elseif config.fullscreen > 0 and config.fullscreen <= 3 then
		love.window.setMode(0,0, {fullscreen=true, vsync=config.vsync})
		love.window.setMode(love.graphics.getWidth(), love.graphics.getHeight(), {fullscreen=true, vsync=config.vsync})
	end
	fs_translatex = (love.graphics.getWidth()-WIDTH*config.scale)/2
	fs_translatey = (love.graphics.getHeight()-HEIGHT*config.scale)/2
end

function toggleVSync()
	config.vsync = not config.vsync
	setMode()
end

function defaultKeys()
	for i,v in pairs(default_config.keys) do
		config.keys[i] = v
	end
end

function defaultJoyKeys()
	for i,v in pairs(default_config.joykeys) do
		config.joykeys[i] = v
	end
end
