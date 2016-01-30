function love.load()
  img = love.graphics.newImage("a.png")
  lightRaysShader = love.graphics.newShader("lightRays.glsl")
  reduceShader = love.graphics.newShader("reduce.glsl")
  computeRaysShader = love.graphics.newShader("computeRays.glsl")
  
  shadowRays = love.graphics.newCanvas(512, 512, "rg8")
  shadow = love.graphics.newCanvas(512, 512, "rg8")
  shadow:setFilter('nearest','nearest');
  shadowReduced = {};
  local width = 512;
  while width > 2 do
    width = width / 2;
    shadowReduced[width] = love.graphics.newCanvas(width, 512, "rg8")
    shadowReduced[width]:setFilter('nearest','nearest');
  end
  shadow2 = love.graphics.newCanvas(512, 512, "rg8")
  shadow2:setFilter('nearest','nearest');
  
  font = love.graphics.newFont("OpenSans.ttf", 20);
  
  text = love.graphics.newText( font )
end


function drawLight(normalMap, lightBlock, length, height)
  love.graphics.setCanvas(shadow)
  love.graphics.clear()
  
  love.graphics.setShader(lightRaysShader)
  love.graphics.draw(lightBlock)
    
  love.graphics.setShader(reduceShader)
  local lastShadowReduced = shadow;
  
  local width = 512;
  while (width > 2) do
    width = width / 2;
    love.graphics.setCanvas(shadowReduced[width])
    love.graphics.draw(lastShadowReduced)
    lastShadowReduced = shadowReduced[width]
  end
  
  love.graphics.setCanvas(shadow)
  love.graphics.setShader(computeRaysShader)
  computeRaysShader:send('shadowTexture', shadowReduced[2]);
  love.graphics.polygon('fill', {0, 0, 512, 0, 512, 512, 0, 512})
  
  return love.mouse.isDown(1) and shadowReduced[256] or shadow
end



function love.draw()  
  if(img ~= nil) then
    local time = love.timer.getTime();
    local shadow = drawLight(nil, img, 250, love.mouse.getY() / love.graphics.getHeight())
    
    love.graphics.setShader()
    love.graphics.setCanvas()
    --love.graphics.scale(10,1)
    love.graphics.draw(shadow)
    --love.graphics.scale(1/10,1)
    
    text:set( love.timer.getFPS()..'-'.. math.max(2, 512 * love.mouse.getX() / love.graphics.getWidth() * love.mouse.getX() / love.graphics.getWidth()))
    love.graphics.draw(text)
  end
end