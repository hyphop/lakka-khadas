
-- ## hyphop ## --

loveis=true
engine=""

if lutro then
    love = lutro
    engine="lutro"
    loveis=false

    BG= {0, 255/2, 0}

else
    engine="love"
    loveis=true

    BG= {0, 0.5 , 0 }

end

key_pressed = ''
p=0

require("conf")

board="Edge"

require("io")

function filecontent(filename,def_val,s,l)
-- filename
-- default value
-- size
-- string limiter

    local a=def_val
    local i
    local f
    i=io.open(filename,"r")
    
    if i == nil then
	return a
    end

    a=i:read("*a"):sub(0,s)

    i:close()

	if l then
	    f = a:find(l)
	    if f then
		return a:sub(0,f-1)
	    end
	end
	
    return a
end

function filestring(filename,def_val)
-- filename
-- default value

    local a=def_val
    local i
    local f
    i=io.open(filename,"r")
    
    if i == nil then
	return a
    end

    a=i:read("*l")
    i:close()

    return a
end

function fileread(filename,def_val)
-- filename
-- default value

    local a=def_val
    local i
    local f
    i=io.open(filename,"r")
    
    if i == nil then
	return a
    end

    a=i:read("*a")
    i:close()

    return a
end

local os_version

function pcontent(pname)

    local a
    local i
    i=io.popen(pname,"r")
    
    if i == nil then
	return "undef"
    end

    a=i:read("*a")

    local l = "\n"
    local f = a:find(l)
	    if f then
		return a:sub(0,f-1)
	    end

    return a

end

function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

print(script_path())


function free_mem()
    os_mem_free=string.match( fileread("/proc/meminfo", "0"), "MemAvailable:%s*(%d+)" )
end


help_text1="HELP: press on gamepad   up/down/left/right A/B/X/Y"
help_text2="keyboard  up/down/left/right z/x/a/s"
help_text3="for EXIT press ENTER or START twice!"

function love.load()


    print(string.format("LOAD (engine: %s)\n", engine))

--    PWD=debug.getinfo(1).source;
--    PWD=debug.getinfo(1).short_src;
--    PWD=io.popen"pwd":read'*l'
--    print(package.path)

    CWD = script_path()

    help_text  = help_text1:upper()
    help_text2 = help_text2:upper()
    help_text3 = help_text3:upper()

    print ("CWD: " .. CWD .. "--")

--    print (io.popen"env":read'*l')

--    os.execute("cat /proc/cmdline")
--    os.execute("cat /proc/version")

-- local ffi = require "ffi"
-- ffi.cdef "unsigned int sleep(unsigned int seconds);"
-- ffi.C.sleep(2)

--    v = "/proc/version"
--    v = "os_version"
--    v = "os_version_test"

    os_version=filecontent("/proc/version","UNDEF", 32,"[\\(|-]"):upper()
    os_cmdline=filestring("/proc/cmdline","UNDEF"):upper()
    os_hostname=filestring("/proc/sys/kernel/hostname","UNDEF"):upper()

    os_device=filestring("/sys/firmware/devicetree/base/model","UNDEF"):upper()

    os_temp="--"


    os_mem_total= string.match( filestring("/proc/meminfo", "0"), "%d+")
    free_mem()
--    os_mem_total=pcontent(CWD .. "/memtotal")
--    os_mem_free=pcontent(CWD .. "/memfree")

    print(string.format("OS : %s HOST: %s  DEV: %s MEM: %s - %s \n", os_version, os_hostname, os_device, os_mem_total, os_mem_free))
    print(string.format("CMD: %s \n", os_cmdline))

    bg_music=love.audio.newSource("assets/bg_music.wav","stream")
    press_key2_sound=love.audio.newSource("assets/coffee.wav","stream")
    press_key_sound=love.audio.newSource("assets/select.wav","stream")

    press_key_sound:setVolume(0.3)

    bg_music:setLooping(true)
--    bg_music:setVolume(0.5)
    bg_music:play()

    fontb = love.graphics.newImageFont('Lutron/Font/FontBold.png', " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*:|=-<>./'\"+")
    font  = love.graphics.newImageFont('Lutron/Font/Sofia24.png', " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    love.graphics.setFont(fontb)

--    circ = love.graphics.newImage("assets/" .. board  ..  ".png")
    logo = love.graphics.newImage("assets/khadas-logo2.png")
    logo_height = logo:getHeight()
    logo_width = logo:getWidth()

    bg = love.graphics.newImage("assets/bg.png")

    bg_height = bg:getHeight()
    bg_width = bg:getWidth()

    bg2 = love.graphics.newImage("assets/nintendo-game-control-svgrepo-com.png")
    bg2_height = bg2:getHeight()
    bg2_width = bg2:getWidth()

    bg3 = love.graphics.newImage("assets/xbox360.png")
    bg3_height = bg3:getHeight()
    bg3_width = bg3:getWidth()

    logo_shape = love.graphics.newQuad(0,0,logo_width,logo_height,logo_width,logo_height)
    bg_shape   = love.graphics.newQuad(0,0,WIDTH,bg_height,WIDTH,bg_height)
    bg2_shape   = love.graphics.newQuad(0,0,bg2_width,HEIGHT,bg2_width,HEIGHT)
    bg3_shape   = love.graphics.newQuad(0,0,bg3_width,bg3_height,bg3_width,bg3_height)
--    circ = love.graphics.newImage("assets/bigcoin.png")
--    circ_shape = love.graphics.newQuad(0,0,32,32,32,32)

    logo:setFilter("nearest","nearest")

    --love.graphics.setBackgroundColor( BG )


end

FPS=".."
os_uptime=0

function love.update(dt)
--    Game:update()

    if START_PRESSED > 2 then
	love.window.close()
    end

    x=x+xx
    y=y+yy
    t=t+1

    if 0 == ( t % 30) then
	FPS = tostring(love.timer.getFPS())

	os_temp=filestring("/sys/class/thermal/thermal_zone0/temp","0")
	os_temp=math.floor(os_temp/1000)

--	print("FPS " .. FPS) 
    end


    if 0 == ( t % 60) then
	FPS = tostring(love.timer.getFPS())
	os_uptime=filestring("/proc/uptime","0"):match"(%d+)"
    end

    if 0 == ( t % 90) then
	free_mem()
    end

    if x < 0 then
	xx = xx * -1
    end

    if y < 0 then
	yy = yy * -1
    end

    if x > WIDTH then
	xx = xx * -1
    end

    if y > HEIGHT then
	yy = yy * -1
    end

end

TEST="KHADAS"
x=WIDTH/2
y=HEIGHT/2
xx=1
yy=2
t=0
d1=1
d2=1

function love.draw()
--    Platform:renderGame()

--    love.graphics.rotate(-t/100)

--      if 0 == t % 3 then
--	return
--      end

      love.graphics.draw(bg,bg_shape,0, (t % bg_height) - bg_height )
      love.graphics.draw(bg,bg_shape,0,t % bg_height )
--      love.graphics.draw(bg2,bg2_shape, (WIDTH - bg2_width) / 2,0 )
      love.graphics.draw(bg3,bg3_shape, d1*WIDTH - d1* ( t % ( 2 * WIDTH))  ,0 )
      love.graphics.draw(bg2,bg2_shape, d2*((t*1.5) % ( 2 * WIDTH)) - d2 * WIDTH ,0 )


      love.graphics.setFont(fontb)
      love.graphics.printf("SYS: " .. os_hostname , 0, 20 + math.sin(t/4)*1.5, WIDTH, "center" )
      love.graphics.printf( os_version, 0, 40, WIDTH, "center" )
      love.graphics.printf( "DEVICE: " .. os_device, 0 + math.sin(t/16)*4, 60, WIDTH, "center" )
      love.graphics.printf( "FPS: " .. FPS  , 0, 100, WIDTH, "center" )

      love.graphics.printf( "TEMP: " .. os_temp  , 0, 120, WIDTH, "center" )
    
      love.graphics.printf( "MEM: " .. os_mem_total .. " FREE: " .. os_mem_free , 0, 80, WIDTH, "center" )

      love.graphics.printf( help_text  , 0, 160, WIDTH, "center" )
      love.graphics.printf( help_text2 , 0, 170, WIDTH, "center" )
      love.graphics.printf( help_text3 , 0, 190, WIDTH, "center" )

      love.graphics.printf( "UPTIME: " .. os_uptime  , 0, 210, WIDTH, "center" )

--[[
      love.graphics.setColor(255, 0, 0, 50)
      love.graphics.circle("line", x, y, 50) -- Draw white circle with 100 segments.
      love.graphics.setColor(250, 100, 0, 255)
      love.graphics.circle("fill", x, y, 25) -- Draw white circle with 100 segments.
]]
      love.graphics.draw(logo,logo_shape,x,y,t/100)

      love.graphics.print( os_cmdline , WIDTH - t*2 % ( WIDTH * 3 ), HEIGHT - 20 )

--      love.graphics.setFont(font)
--      love.graphics.printf( p .. " " .. key_pressed, 0, 100, WIDTH, "center" )
      love.graphics.printf( "KEY: " .. p .. " " .. key_pressed:upper(), 0, 140, WIDTH, "center" )


end

function love.joystickpressed(i, key)

--  p=p+1
--  key_pressed=key
    print("JOY "..key)

end

START_PRESSED=0

function love.gamepadpressed(i, key)

    p=p+1
    key_pressed=key
    print("PAD "..key)

    if key == 'start' then
	press_key_sound:play()
	START_PRESSED = START_PRESSED + 1
	return
    end


    if key == 'up' then
	yy=-1
    press_key_sound:play()
	return
    end
    if key == 'down' then
	yy=1
    press_key_sound:play()
	return
    end
    if key == 'left' then
	xx=-1
    press_key_sound:play()
	return
    end
    if key == 'right' then
	xx=1
    press_key_sound:play()
	return
    end

    if key == 'a' then
	d2=d2*-1
    end

    if key == 'b' then
	d2=d2*-1
    end

    if key == 'x' then
	d1=d1*-1
    end

    if key == 'y' then
	d1=d1*-1
    end

    press_key2_sound:play()

--[[
    if key == 'a' then
	return
    if key == 'b' then
	return
    if key == 'up' then
	return
    if key == 'down' then
	return
    if key == 'left' then
	return
    if key == 'right' then
	return
    if key == 'start' then
	return
    if key == 'y' then
	return
    if key == 'x' then
	return

]]

end

function love.gamepadreleased(i, k)
    -- body
end

function love.keypressed(key, unicode)
    print("KEYP "..key)

    if not loveis then
	return
    end

    p=p+1
    key_pressed=key

    print("PAD "..key)

--    press_key_sound:play()

    if key == 'up' then
	yy=-1
    end
    if key == 'down' then
	yy=1
    end
    if key == 'left' then
	xx=-1
    end
    if key == 'right' then
	xx=1
    end

end

function love.keyreleased(key)
    print("UNPRESS "..key)
end
