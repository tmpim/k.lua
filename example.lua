local w = require("w")
local r = require("r")
local k = require("k")
local jua = require("jua")
os.loadAPI(fs.exists("json.lua") and "json.lua" or "json")
local json = _G.json
_G.json = nil
local await = jua.await

r.init(jua)
w.init(jua)
k.init(jua, json, w, r)

local ws

local function prints(...)
  local objs = {...}
  for i, obj in ipairs(objs) do
    print(json.encode(obj))
  end
end

local function printMeta(meta)
  if meta.domain then
    print((meta.name and meta.name.."@" or "")..meta.domain..(meta.message and ": "..meta.message or ""))
  end
end

jua.on("terminate", function()
  if ws then ws.close() end
  jua.stop()
  print("Terminated")
end)

jua.go(function()
  local success, address = await(k.address, "k7as0j87id")
  if success then
    prints(address)
  else
    print("Failed to request address.")
    jua.stop()
  end
  local success, ws = await(k.connect, "test") --a
  if success then
    print("Connected to websocket.")
    ws.on("hello", function(data)
      print("MOTD: "..data.motd)
      local success = await(ws.subscribe, "transactions", function(data)
        local tx = data.transaction
        local meta = k.parseMeta(tx.metadata)
        prints(tx)
        printMeta(meta)
      end)
      if success then
        print("Subscribed successfully.")
      else
        print("Failed to subscribe.")
      end
    end)
  else
    print("Failed to request a websocket url.")
    jua.stop()
  end
end)
