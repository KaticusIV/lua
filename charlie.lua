-- =====================
-- CONFIG
-- =====================
local TARGETS = {
  mario64guy = true,
  Arteth = true
}

local MAX_RANGE = 30
local detector = peripheral.wrap("left")

print("Guard turtle online (Player Detector mode)")

local offset = 0

local function getDistance(p)
  if p.dx and p.dy and p.dz then
    return math.sqrt(p.dx*p.dx + p.dy*p.dy + p.dz*p.dz)
  end

  if p.x and p.y and p.z then
    return math.sqrt(p.x*p.x + p.y*p.y + p.z*p.z)
  end

  if p.position and p.position.x then
    local x = p.position.x
    local y = p.position.y or 0
    local z = p.position.z
    return math.sqrt(x*x + y*y + z*z)
  end

  return nil
end

while true do
  local targetDetected = false
  local players = detector.getPlayers()

  for name,player in pairs(players) do
    if TARGETS[name] then
      local dist = getDistance(player)

      if dist and dist <= MAX_RANGE then
        targetDetected = true
        print("Engaging:", name, "Dist:", math.floor(dist))

        turtle.attack()
        if turtle.forward() then
          offset = offset + 1
        end

        break
      end
    end
  end

  if not targetDetected and offset > 0 then
    turtle.back()
    offset = offset - 1
  end

  sleep(0.3)
end

