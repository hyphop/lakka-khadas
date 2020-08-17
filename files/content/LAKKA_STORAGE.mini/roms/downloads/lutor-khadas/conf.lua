

HEIGHT= 320
WIDTH= HEIGHT * 16 / 9

--HEIGHT=600

function love.conf(t)

    print("CONF")
    t.identity = "iyfct"

--    t.version = "0.9.1"
--    t.console = false

    if t.window then

    t.window.title = "Khadas game"
    t.window.icon = nil
    t.window.borderless = false
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.vsync = true
    t.window.usedpiscale = true

    t.window.width = WIDTH
    t.window.height = HEIGHT

    end

    t.width = WIDTH
    t.height = HEIGHT

--    t.modules.joystick = false
--    t.modules.mouse = false
--    t.modules.physics = false

end


