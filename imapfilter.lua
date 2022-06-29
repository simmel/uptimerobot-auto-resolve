options.charset = 'UTF-8'
-- Setting this true enables cert pinning and that's not what we want. We
-- "trust" the CAs.
options.certificates = false

local server = os.getenv("SERVER")
local username = os.getenv("USERNAME")
local password = os.getenv("PASSWORD")

if not server or not username or not password then
  print("SERVER, USERNAME or PASSWORD is not set")
  os.exit(1)
end

print("login to " .. server .. " as: " .. username .. ":" .. password)

account = IMAP {
  server = server,
  username = username,
  password = password,
  port = 993,
  ssl = 'auto'
}

results = account.INBOX:is_unseen():contain_subject("Monitor is"):contain_from("@uptimerobot.com")

for _, message in ipairs(results) do
  print(message)
  print(mailbox[uid]:fetch_field("subject"))
  local mailbox, uid = table.unpack(message)
end
