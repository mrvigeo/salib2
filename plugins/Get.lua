local function get_variables_hash(msg)
  if msg.to.type == 'chat' then
    return 'chat:'..msg.to.id..':variables'
  end
  if msg.to.type == 'user' then
    return 'user:'..msg.from.id..':variables'
  end
end 

local function list_variables(msg)
  local hash = get_variables_hash(msg)
  
  if hash then
    local names = redis:hkeys(hash)
    local text = ''
    for i=1, #names do
      text = '> '..text..names[i]..'\n'
    end
    return text
  end
end

local function get_value(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return'Not found variable'
    else
      return value
    end
  end
end

local function run(msg, matches)
  if matches[2] then
    return get_value(msg, matches[2])
  else
    return list_variables(msg)
  end
end

return {
  description = "View Saved Variables With !set", 
  usage = {
	"/get : view all variables",
	"/get (value) : view variable",
	},
  patterns = {
    "^([!/]get) (.+)$",
    "^[!/]get$"
  },
  run = run
}
