-- Made by GuglioIsStupid
-- Some code was referenced from https://github.com/GuglioIsStupid/pong-love2d

function create()
    dofile(formCompletePath("input.lua"))
    dofile(formCompletePath("spriteFrame.lua"))

    SpriteFrame.create()

    input.new(
        {
            space = 32,

            -- shop stuff
            ["Clicker"] = 49,
            ["Grandma"] = 50,
            ["Farm"] = 51,
            ["Mine"] = 52,
            ["Factory"] = 53,
            ["Bank"] = 54,
            ["Temple"] = 55,
            ["Wizard tower"] = 56,
            ["Shipment"] = 57,
            ["Alchemy lab"] = 48,
            ["Portal"] = 113,
            ["Time machine"] = 119,
            ["Antimatter condenser"] = 101,
            ["Prism"] = 114,
            ["Chancemaker"] = 116,
            ["Fractal engine"] = 121,
            ["Javascript console"] = 117,
            ["Idleverse"] = 105
        }
    )

    -- Cookie clicker
    cookies = 0
    cookiesPerSecond = 0
    cookiesTimer = 0

    CookieText = Text:new("cookieText", "arial", "Cookies: 0", 24, 575, 10)
    CPSText = Text:new("CPSText", "arial", "Cookies per second: 0", 24, 575, 40)
    CookieSpr = createSprite("cookie", "cookie", 375, 100)

    shop = {
        ["Clicker"] = {price=10,cps=1,input="1"},
        ["Grandma"] = {price=100,cps=10,input="2"},
        ["Farm"] = {price=500,cps=50,input="3"},
        ["Mine"] = {price=3000,cps=100,input="4"},
        ["Factory"] = {price=10000,cps=500,input="5"},
        ["Bank"] = {price=40000,cps=1000,input="6"},
        ["Temple"] = {price=200000,cps=5000,input="7"},
        ["Wizard tower"] = {price=1666666,cps=40000,input="8"},
        ["Shipment"] = {price=123456789,cps=1000000,input="9"},
        ["Alchemy lab"] = {price=3999999999,cps=4000000,input="0"},
        ["Portal"] = {price=75000000000,cps=7500000,input="q"},
        ["Time machine"] = {price=999999999999,cps=9999999,input="w"},
        ["Antimatter condenser"] = {price=4000000000000,cps=40000000,input="e"},
        ["Prism"] = {price=75000000000000,cps=75000000,input="r"},
        ["Chancemaker"] = {price=999999999999999,cps=99999999,input="t"},
        ["Fractal engine"] = {price=4000000000000000,cps=400000000,input="y"},
        ["Javascript console"] = {price=75000000000000000,cps=750000000,input="u"},
        ["Idleverse"] = {price=999999999999999999,cps=999999999,input="i"}
    }

    shopItems = {
        "Clicker", "Grandma", "Farm", "Mine", "Factory", "Bank", 
        "Temple", "Wizard tower", "Shipment", "Alchemy lab", "Portal", 
        "Time machine", "Antimatter condenser", "Prism", "Chancemaker", 
        "Fractal engine", "Javascript console", "Idleverse"
    }

    -- Screen
    SCREEN_X_0 = -1280/2
    SCREEN_X_1280 = 1280/2

    shopText = Text:new(
        "shopText", "arial", 
        "Shop",24,20,0
    )
    
    shops = {}
    for item = 1, #shopItems do
        shops[shopItems[item]] = Text:new(
            shopItems[item] .. "Text", "arial", 
            "[" .. shop[shopItems[item]].input .. "] " .. shopItems[item] .. ": " .. shop[shopItems[item]].price .. " cookies",24,0,item < 12 and 20 + (item * 24) or 500 + ((item - 12) * 24)
        )
    end

    -- Deltatime
    time = 0
    lastTime = 0
    deltaTime = 0
end

function update(beat)
    time = getTime()
    deltaTime = (time - lastTime) / 1000
    globalBeat = beat -- make the beat global so we can use it in other functions, ended up unused... For now...

    -- main loop
    cookiesTimer = cookiesTimer + deltaTime
    if cookiesTimer >= 1 then
        cookies = cookies + cookiesPerSecond
        cookiesTimer = 0
        CookieText.text = 'Cookies: ' .. cookies
    end

    if input.pressed("space") then
        cookies = cookies + 1
        CookieText.text = 'Cookies: ' .. cookies
    end

    -- shop inputs
    for item = 1, #shopItems do
        if input.pressed(shopItems[item]) then
            if cookies >= shop[shopItems[item]].price then
                cookies = cookies - shop[shopItems[item]].price
                shop[shopItems[item]].price = math.floor(shop[shopItems[item]].price * 1.15)
                cookiesPerSecond = cookiesPerSecond + shop[shopItems[item]].cps
                CookieText.text = 'Cookies: ' .. cookies
                CPSText.text = 'Cookies per second: ' .. cookiesPerSecond
                shops[shopItems[item]].text = "[" .. shop[shopItems[item]].input .. "] " .. shopItems[item] .. ": " .. shop[shopItems[item]].price .. " cookies"
            end
        end
    end

    lastTime = time

    input.update()
end

function key_pressed(key)
    input.key_pressed(key)
end

function key_released(key)
    input.key_released(key)
end