g = love.graphics --so instead of typing love.graphics.blahblahblah every time,
k = love.keyboard --you can simply write g.blahblahblah! Yay!

function love.load()
    -- frame size declaration

    width = g.getWidth()
    height = g.getHeight()
    -- ball properties
    ballx, bally = width/2 , height/2
    ballxvelocity, ballyvelocity = -1 , 1
    -- paddle properties
    paddle1, paddle2 = height/2, height/2
    -- sound file 
    wallhit = love.audio.newSource("sounds/wallhit.ogg", "static")
    paddlehit = love.audio.newSource("sounds/paddlehit.ogg", "static")
    lose = love.audio.newSource("sounds/win.ogg", "static")
    -- score
    score1, score2 = 0 , 0

end

function love.draw()
    -- drawing the ball
    g.ellipse( "fill", ballx, bally, 10, 10 )
    -- drawing the paddles
    g.rectangle("fill", 15,paddle1, 10,60)
    g.rectangle("fill", width-15,paddle2, 10,60)
    -- draw the score
    g.print(score1, (width/2)-30, 30)
    g.print(score2, (width/2)+30, 30)
end

function love.update(dt)
    -- ball direction
    ballx = ballx + ballxvelocity
    bally = bally + ballyvelocity
    collider()
    paddlecontrol()
end

function collider()
    if bally > height or bally < 0 then
        ballyvelocity = ballyvelocity * -1
        wallhit:play()
    end
    -- print(bally, paddle1)
    -- verbose conditionals for collision that affirm my interest in learning the physics library
    if ballx >15 and ballx <25 and bally > paddle1 and bally < paddle1 + 60 then
        ballxvelocity = ballxvelocity * -1
        paddlehit:play()
    end
    if ballx >width-25 and ballx <width-15 and bally > paddle2 and bally < paddle2 + 60 then
        ballxvelocity = ballxvelocity * -1
        paddlehit:play()
    end
    -- off screen detection
    if ballx < 0 then
        lose:play()
        ballx = width/2
        bally = height/2
        score2 = score2 + 1
    end
    if ballx > width then 
        lose:play()
        ballx = width/2
        bally = height/2
        score1 = score1 + 1
    end
end

function paddlecontrol()
    if k.isDown("w") then
        paddle1 = paddle1 - 3
    end
    if k.isDown("s") then
        paddle1 = paddle1 + 3
    end
    if k.isDown("up") then
        paddle2 = paddle2 - 3
    end
    if k.isDown("down") then
        paddle2 = paddle2 + 3
    end
end