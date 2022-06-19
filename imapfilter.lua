options.charset = 'UTF-8'

local server = os.getenv("SERVER")
local username = os.getenv("USERNAME")
local password = os.getenv("PASSWORD")

if not server or not username or not password then
  print("SERVER, USERNAME or PASSWORD is not set")
  os.exit(1)
end

print("login to " .. server .. " as: " .. username .. ":" .. password)
