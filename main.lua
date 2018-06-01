local criss = 1
local cross = 2

-- Basic XY coordinate system
local grid = {
  [1] = {0,0,0},
  [2] = {0,0,0},
  [3] = {0,0,0}
}

-- Player selection variables
local x = 1
local y = 1
local player = 1
local selectedCoordinate = grid[y][x]

function love.keypressed(key, scancode, isrepeat)
  -- Coordinate selector

  if key == "up" then
    if y > 1 then
      y = y - 1
    end
  end

  if key == "down" then
    if y < 3 then
      y = y + 1
    end
  end

  if key == "right" then
    if x < 3 then
      x = x + 1
    end
  end

  if key == "left" then
    if x > 1 then
      x = x - 1
    end
  end
end

function love.update(dt)


end

function love.draw()



  -- Set color to white for line
  love.graphics.setColor(255,255,255)

  -- Draw first horizontal line
  love.graphics.line(1,love.graphics.getHeight()*.33,love.graphics.getWidth(),love.graphics.getHeight()*.33)

  -- Draw second horizontal line
  love.graphics.line(1,love.graphics.getHeight()*.66,love.graphics.getWidth(),love.graphics.getHeight()*.66)

  -- Draw first vertical line
  love.graphics.line(love.graphics.getWidth()*.33,1,love.graphics.getWidth()*.33,love.graphics.getHeight())

  -- Draw second vertical line
  love.graphics.line(love.graphics.getWidth()*.66,1,love.graphics.getWidth()*.66,love.graphics.getHeight())

  -- Select color for selection triangle based on player
  if player == 1 then
    love.graphics.setColor(109,162,255)
  else
    love.graphics.setColor(255,162,109)
  end

  -- Draw selection rectangle
  local xAmp = (x-1)*50
  local yAmp = (y-1)*50
  love.graphics.rectangle("line",(x)*xAmp,(y)*yAmp,100,100)


  love.graphics.print("x: "..x.."\ny: "..y.."\ng: "..grid[x][y],1,1)
end
