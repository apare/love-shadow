function love.load()
  img = love.graphics.newImage("a.png")
  shadowShader = love.graphics.newShader("drawShadow.glsl")
  shadow = love.graphics.newCanvas(512, 512)--, "r8")
  font = love.graphics.newFont("OpenSans.ttf", 20);
  text = love.graphics.newText( font )
end


function drawLight(normalMap, heightMap, length, height)
  shadowShader:send('lightZ', height)
  love.graphics.setShader(shadowShader)
  love.graphics.setCanvas(shadow)
  love.graphics.draw(heightMap)
  return shadow;
end

function love.draw()  
  if(img ~= nil) then
    local z = (math.sin(love.timer.getTime()) + 1) / 4 + 0.5;
    local time = love.timer.getTime();
    local shadow = drawLight(nil, img, 250, love.mouse.getY() / love.graphics.getHeight())
    for i = 0, 30 do
      drawLight(nil, img, 250, love.mouse.getY() / love.graphics.getHeight())
    end
    
    love.graphics.setShader()
    love.graphics.setCanvas()
    love.graphics.draw(shadow)
    
    text:set( love.timer.getFPS())
    love.graphics.draw(text)
  end
end