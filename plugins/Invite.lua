-- Invite other user to the chat group.
-- Use !invite name User_name or !invite id id_number
-- The User_name is the print_name (there are no spaces but _)

do

local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
  local user = matches[2]

  -- User submitted a user name
  if matches[1] == "user" then
    user = string.gsub(user," ","_")
  end
  
  -- User submitted an id
  if matches[1] == "id" then
    user = 'User by ID Number '..user
  end

  -- The message must come from a chat group
  if msg.to.type == 'chat' then
    local chat = ''
    chat_add_user(chat, user, callback, false)
    return user.." added"
  else 
    return 'Only work in group'
  end

end

return {
  description = "Invite Members by Username or ID", 
  usage = {
    "/inv user (@user) : invite by username", 
    "/inv id (id) : invite by id number" },
  patterns = {
    "^[!/]inv (user) (.*)$",
    "^[!/]inv (id) (%d+)$"
  }, 
  run = run,
  moderation = true 
}

end
