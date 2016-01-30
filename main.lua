function love.load()
  img = love.graphics.newImage("a.png")
  lightRaysShader = love.graphics.newShader("lightRays.glsl")
  shadowShader = love.graphics.newShader("shadow.glsl")
  computeRaysShader = love.graphics.newShader("computeRays.glsl")
  
  lightRays = love.graphics.newCanvas(512, 512, "rg8")
  shadowRays = love.graphics.newCanvas(512, 512, "rg8")
  shadow = love.graphics.newCanvas(512, 512, "r8")
  
  font = love.graphics.newFont("OpenSans.ttf", 20);
  
  text = love.graphics.newText( font )
end


function drawLight(normalMap, heightMap, length, height)
  love.graphics.setShader(lightRaysShader)
  love.graphics.setShader(lightRaysShader)
  love.graphics.setCanvas(lightRays)
  love.graphics.draw(heightMap)
  
  shadowShader:send('lightZ', height)
  love.graphics.setShader(shadowShader)
  love.graphics.setCanvas(shadowRays)
  love.graphics.draw(lightRays)
  
  love.graphics.setShader(computeRaysShader)
  love.graphics.setCanvas(shadow)
  love.graphics.draw(shadowRays)
  
  return shadow;
end



function love.draw()  
  if(img ~= nil) then
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