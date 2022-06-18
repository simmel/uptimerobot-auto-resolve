local server = os.getenv("SERVER")
local user = os.getenv("USERNAME")
local password = os.getenv("PASSWORD")

if not user or not password then
  print("SERVER, USERNAME or PASSWORD is not set")
  os.exit(1)
end

print("login to " .. server .. " as: " .. user .. ":" .. password)
