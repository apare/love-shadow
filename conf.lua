function love.conf(conf)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  conf.title = "Love-Game"
  conf.window.width = 512
  conf.window.height = 512
  conf.window.vsync = false
end