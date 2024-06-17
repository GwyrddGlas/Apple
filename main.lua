local appleSprite 
local bigFont
local clickCount = 0
local maxInt = 9223372036854775807
local smokeShader
local startTime
local textX = love.graphics.getWidth()/2
local soundEffect 

function love.load()
    soundEffect = love.audio.newSource("sound/ping.mp3", "static")
    appleSprite = love.graphics.newImage("sprites/apple.png")
    smokeShader = love.graphics.newShader("shader/smoke.glsl")
    startTime = love.timer.getTime()
    bigFont = love.graphics.newFont(36)
end

function love.update(dt)
    local currentTime = love.timer.getTime() - startTime * dt
    smokeShader:send("iTime", currentTime/6)
    smokeShader:send("iResolution", {love.graphics.getWidth(), love.graphics.getHeight()})
    if textX > love.graphics.getWidth() then
        textX = -bigFont:getWidth(clickCount)
    end    if textX > love.graphics.getWidth() then
        textX = -bigFont:getWidth(clickCount)
    end
end

function love.mousepressed(x, y, key)
    if key == 1 then
        clickCount = clickCount +1
        soundEffect:play()
    end
end

function love.draw()
    love.graphics.setShader(smokeShader)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader()

    if appleSprite then
        local windowWidth = love.graphics.getWidth()
        local windowHeight = love.graphics.getHeight()

        local textWidth = windowWidth / 2 + bigFont:getWidth(clickCount)
        local textY = (windowHeight - 250) / 2

        love.graphics.setFont(bigFont)

        love.graphics.setColor(1, 1, 1)
        if clickCount < maxInt then
            love.graphics.print(clickCount, textX, textY)    
        else
            love.graphics.print("Max int", textX, textY)
        end

        local scale = 0.5
        local spriteWidth = appleSprite:getWidth() * scale
        local spriteHeight = appleSprite:getHeight() * scale

        local spriteX = (windowWidth - spriteWidth) / 2
        local spriteY = (windowHeight - spriteHeight) / 2 + 70

        love.graphics.draw(appleSprite, spriteX, spriteY, 0, scale, scale)
    end
end