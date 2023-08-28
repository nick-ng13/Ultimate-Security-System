-- lua script to automatically run on reset of the ESP8266
-- lua script connects the wifi module to the specified access point
-- author: Nicholas Ng

wifi.setmode(wifi.STATION)
cfg = {}
cfg.ssid = "lua"    -- change the SSID according to your connection
cfg.pwd = "asdfghjkl1"  -- change the Password according to your connection
wifi.sta.config(cfg)
wifi.sta.autoconnect(1)

count = 0

-- create a timer to wait for wifi connection
myTimer = tmr.create()
myTimer:register(1000, tmr.ALARM_SEMI,
function(myTimer) 
    if wifi.sta.getip() == nil then
        print("Waiting for IP...")
        count = count + 1
        if(count < 20) then     -- try for 20 seconds before stopping
            myTimer:start()
        end
    else
        print("IP is "..wifi.sta.getip())
    end
end)

myTimer:start()

t={}
