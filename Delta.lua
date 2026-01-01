-- =====================
-- CONFIG
-- =====================
local TARGETS = {
  "mario64guy",
  "Arteth"
}

local MAX_RANGE = 30
local detector = peripheral.wrap("left")

print("Guard turtle online (Player Detector mode)")

local offset = 0

local function getDistance(p)
  if p.distance then
    return p.distance
  end

  if p.x and p.y and p.z then
    return math.sqrt(p.x*p.x + p.y*p.y + p.z*p.z)
  end

  return nil
end

while true do
  local targetDetected = false

  for _,name in ipairs(TARGETS) do
    local player = detector.getPlayer(name)

    if player then
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

