local mime = require("mime")

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

print("login to " .. server .. " as " .. username)

account = IMAP {
  server = server,
  username = username,
  password = password,
  port = 993,
  ssl = 'auto'
}

function uptimerobot()
  results = account.INBOX:is_unseen():contain_subject("Monitor is"):contain_from("@uptimerobot.com")

  for _, message in ipairs(results) do
    local mailbox, uid = table.unpack(message)
    local subject = string.gsub(mailbox[uid]:fetch_field("subject"), "Subject: ", "")
    local success, check = regex_search('^Monitor is UP: (.*)$', subject)
    if success then
      print(check .. " is UP deleting all mails matching")
      local to_delete = results:match_subject("Monitor is (UP|DOWN): " .. check)
      to_delete:mark_deleted()
      -- TODO: Ensure "Monitor is UP" is the latest message and only then delete
      -- the "thread"
    end
  end
end

function healthchecks()
  results = account.INBOX:is_unseen():contain_from("healthchecks.io@healthchecks.io"):match_subject("^(UP|DOWN) \\|")

  for _, message in ipairs(results) do
    local mailbox, uid = table.unpack(message)
    local subject = string.gsub(mailbox[uid]:fetch_field("subject"), "Subject: ", "")
    local success, check = regex_search('^UP \\| (.*)$', subject)
    if success then
      print(check .. " is UP deleting all mails matching")
      local to_delete = results:match_subject("^(UP|DOWN) \\| " .. check)
      to_delete:mark_deleted()
      -- TODO: Ensure "UP | " is the latest message and only then delete the
      -- "thread"
    end
  end
end

function uptimekuma()
  results = account.INBOX:is_unseen():contain_from("Uptime Kuma")

  for _, message in ipairs(results:contain_subject('] [✅ Up]')) do
    local mailbox, uid = table.unpack(message)
    local subject = string.gsub(mailbox[uid]:fetch_field("subject"), "Subject: ", "")
    subject = string.gsub(subject, '%s+', '')
    subject = string.gsub(subject, '_', ' ')
    subject = string.gsub(subject, '=%?UTF%-8%?Q%?', '')
    subject = string.gsub(subject, '%?=', '')
    subject = mime.unqp(subject)

    local success, check = regex_search('^\\[(.*?)\\] \\[✅ Up\\]', subject)
    if success then
      print(check .. " is UP deleting all mails matching")
      local to_delete = results:contain_subject("[" .. check .."] [")
      to_delete:mark_delete()
      -- TODO: Ensure "UP | " is the latest message and only then delete the
      -- "thread"
    end
  end
end

while true do
  uptimerobot()
  healthchecks()
  uptimekuma()
  account.INBOX:enter_idle()
end
