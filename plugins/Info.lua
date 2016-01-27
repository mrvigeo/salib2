do
local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
  local user = matches[1]
    user = string.gsub(user," ","_")
	if msg.to.type == 'chat' then
    local chat = ''
    return user
  else 
    return 'Only work in group'
  end
end

return {
  description = "Users Information", 
  usage = {
    "/info (@user) : get id by username", },
  patterns = {
    "^[!/]info (.*)$",
  }, 
  run = run,
  moderation = true 
}

end
