-- Tile preset variables

  local tile_criss = 2
  local tile_cross = 1
  local tile_empty = 0


-- Basic XY coordinate system
  local grid = {
    [1] = {0,0,0},
    [2] = {0,0,0},
    [3] = {0,0,0}
  }

-- Player selection variables
  local x = 2
  local y = 2
  local player = 1
  local selectedCoordinate = grid[y][x]

-- Images

  local criss = nil
  local cross = nil

-- Debug stuff
  local debug = true

-- Animation stuff
  local winTimer = 0
  local winner = 0
  local winText = "Player "..winner.." wins!"
  local font = love.graphics.newFont(8)

local function rgbconverter(r,g,b,a)
  -- Simple RGB conversion
  if a then a = a/255 end
  return r/255,g/255,b/255,a or 0
end

local function centerPrint(text,height)
  -- print text dead center
  if not height then
    love.graphics.print(text,((love.graphics.getWidth()/2)-(font:getWidth(text)/2))-20,(love.graphics.getHeight()/2)-(font:getHeight()/2))
  else
    love.graphics.print(text,((love.graphics.getWidth()/2)-(font:getWidth(text)/2))-20,height)
  end

end

local function determineWin(tiles, id)
  if tiles[1][1] == id and tiles[1][2] == id and tiles[1][3] == id -- across the top
  or tiles[2][1] == id and tiles[2][2] == id and tiles[2][3] == id -- across the middle
  or tiles[3][1] == id and tiles[3][2] == id and tiles[3][3] == id -- across the bottom
  or tiles[1][1] == id and tiles[2][1] == id and tiles[3][1] == id -- vertical left
  or tiles[1][2] == id and tiles[2][2] == id and tiles[3][2] == id -- vertical middle
  or tiles[1][3] == id and tiles[2][3] == id and tiles[3][3] == id -- vertical right
  or tiles[1][1] == id and tiles[2][2] == id and tiles[3][3] == id -- diagonal down to right
  or tiles[3][1] == id and tiles[2][2] == id and tiles[1][3] == id -- diagonal down to left
  then
    return true
  else
    return false
  end

end
function love.load()
  criss = love.graphics.newImage("assets/img/criss.png")
  cross = love.graphics.newImage("assets/img/cross.png")
end


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

  -- Set tile is tile = 0, else, ignore.
  if key == "return" then
    if grid[y][x] == 0 and player == 1 then
        grid[y][x] = tile_criss
        player = 2
    elseif grid[y][x] == 0 and player == 2 then
        grid[y][x] = tile_cross
        player = 1
    end
  end
  -- Debug stuff

  if key == "f2" then
    player = 1
    grid = {
      [1] = {0,0,0},
      [2] = {0,0,0},
      [3] = {0,0,0}
    }
    x = 2
    y = 2
  end
  if key == "f3" then
    debug = not debug
  end
end

function love.update(dt)
  -- Game logic
  if determineWin(grid, 1) then
    winner = 1
  end
  if determineWin(grid, 2) then
    winner = 2
  end
  if winner > 0 then winText = "Player "..winner.." wins!" end
end

function love.draw()
  local xAmp = (x-1)*100
  local yAmp = (y-1)*100
  if winner == 0 then
    -- Draw selection rectangle

    -- Select color for selection rectangle based on player
    if player == 1 then
      love.graphics.setColor(rgbconverter(130,196,255,255))
    else
      love.graphics.setColor(rgbconverter(255,196,130,255))
    end
    -- Draw selection rect
    love.graphics.rectangle("fill",xAmp,yAmp,100,100)

    -- Set color to white for line
    love.graphics.setColor(255,255,255,150)


    -- Draw tiles based on grid
    for _x=0, 2, 1 do
      for _y=0, 2, 1 do
        if grid[_y+1][_x+1] == tile_cross then
          love.graphics.draw(cross,_x*100,_y*100)
        end
        if grid[_y+1][_x+1] == tile_criss then
          love.graphics.draw(criss,_x*100,_y*100)
        end
      end
    end




    -- Draw first horizontal line
    love.graphics.line(1,love.graphics.getHeight()*(1/3),love.graphics.getWidth(),love.graphics.getHeight()*(1/3))

    -- Draw second horizontal line
    love.graphics.line(1,love.graphics.getHeight()*(2/3),love.graphics.getWidth(),love.graphics.getHeight()*(2/3))

    -- Draw first vertical line
    love.graphics.line(love.graphics.getWidth()*(1/3),1,love.graphics.getWidth()*(1/3),love.graphics.getHeight())

    -- Draw second vertical line
    love.graphics.line(love.graphics.getWidth()*(2/3),1,love.graphics.getWidth()*(2/3),love.graphics.getHeight())
  else
    centerPrint(winText)
    centerPrint("Press F2 to play again!",love.graphics.getHeight()*.60)
  end

  -- Debug information
  if debug then
    if x == 1 and y == 1 then
      love.graphics.setColor(rgbconverter(0,0,0,255))
    else
      love.graphics.setColor(rgbconverter(255,255,255,255))
    end

    love.graphics.print("x: "..x.."\ny: "..y.."\ng: "..tostring(grid[x][y]).."\nxamp: "..xAmp.."\nyamp: "..yAmp.."\np: "..player,1,1)
  end
end
