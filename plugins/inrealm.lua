do

local function check_member(cb_extra, success, result)
   local receiver = cb_extra.receiver
   local data = cb_extra.data
   local msg = cb_extra.msg
   for k,v in pairs(result.members) do
      local member_id = v.id
      if member_id ~= our_id then
          local username = v.username
          data[tostring(msg.to.id)] = {
              moderators = {[tostring(member_id)] = username},
              settings = {
                  set_name = string.gsub(msg.to.print_name, '_', ' '),
                  lock_name = 'no',
                  lock_photo = 'no',
                  lock_member = 'no'
                  }
            }
          save_data(_config.moderation.data, data)
          return send_large_msg(receiver, 'You are moderator for group')
      end
    end
end

local function automodadd(msg)
    local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
      receiver = get_receiver(msg)
      chat_info(receiver, check_member,{receiver=receiver, data=data, msg = msg})
  else
      if data[tostring(msg.to.id)] then
        return 'Group have already moderator list'
      end
      if msg.from.username then
          username = msg.from.username
      else
          username = msg.from.print_name
      end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
          moderators ={[tostring(msg.from.id)] = username},
          settings = {
              set_name = string.gsub(msg.to.print_name, '_', ' '),
              lock_name = 'no',
              lock_photo = 'no',
              lock_member = 'no'
              }
          }
      save_data(_config.moderation.data, data)
      return 'User @'..username..' set to moderator list'
   end
end

local function modadd(msg)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
        return "You are NOT GLOBAL ADMIN"
    end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
    return 'Group have already moderator list'
  end
    -- create data array in moderation.json
  data[tostring(msg.to.id)] = {
      moderators ={},
      settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'no',
          lock_photo = 'no',
          lock_member = 'no'
          }
      }
  save_data(_config.moderation.data, data)

  return 'Moderator list added'
end

local function modrem(msg)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
        return "You are NOT GLOBAL ADMIN"
    end
    local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
  if not data[tostring(msg.to.id)] then
    return 'Group have not moderator list'
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)

  return 'Moderator list removed'
end

local function promote(receiver, member_username, member_id)
    local data = load_data(_config.moderation.data)
    local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'Moderator list added')
  end
  if data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, '@'..member_username..' is already moderator')
    end
    data[group]['moderators'][tostring(member_id)] = member_username
    save_data(_config.moderation.data, data)
    return send_large_msg(receiver, '@'..member_username..' set to moderator list')
end

local function demote(receiver, member_username, member_id)
    local data = load_data(_config.moderation.data)
    local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'Group have not moderator list')
  end
  if not data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, '@'..member_username..' is not moderator')
  end
  data[group]['moderators'][tostring(member_id)] = nil
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, '@'..member_username..' remove from moderator list')
end

local function admin_promote(receiver, member_username, member_id)  
  local data = load_data(_config.moderation.data)
  if not data['admins'] then
    data['admins'] = {}
    save_data(_config.moderation.data, data)
  end

  if data['admins'][tostring(member_id)] then
    return send_large_msg(receiver, '@'..member_username..' is already GLOBAL ADMIN')
  end
  
  data['admins'][tostring(member_id)] = member_username
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, '@'..member_username..' set to GLOBAL ADMIN list')
end

local function admin_demote(receiver, member_username, member_id)
    local data = load_data(_config.moderation.data)
  if not data['admins'] then
    data['admins'] = {}
    save_data(_config.moderation.data, data)
  end

  if not data['admins'][tostring(member_id)] then
    return send_large_msg(receiver, '@'..member_username..' is not GLOBAL ADMIN')
  end

  data['admins'][tostring(member_id)] = nil
  save_data(_config.moderation.data, data)

  return send_large_msg(receiver, '@'..member_username..' remove from GLOBAL ADMIN list')
end

local function username_id(cb_extra, success, result)
   local mod_cmd = cb_extra.mod_cmd
   local receiver = cb_extra.receiver
   local member = cb_extra.member
   local text = 'No @'..member..' in group'
   for k,v in pairs(result.members) do
      vusername = v.username
      if vusername == member then
        member_username = member
        member_id = v.id
        if mod_cmd == 'modset' then
            return promote(receiver, member_username, member_id)
        elseif mod_cmd == 'moddem' then
            return demote(receiver, member_username, member_id)
        elseif mod_cmd == 'adminset' then
            return admin_promote(receiver, member_username, member_id)
        elseif mod_cmd == 'admindem' then
            return admin_demote(receiver, member_username, member_id)
        end
      end
   end
   send_large_msg(receiver, text)
end

local function modlist(msg)
    local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)] then
    return 'Group have not moderator list'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
    return 'No moderator in group'
  end
  local message = '' .. string.gsub(msg.to.print_name, '_', ' ') .. ' Moderator list:\n______________________________\n'
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message .. '> @'..v..' (' ..k.. ') \n'
  end

  return message
end

local function admin_list(msg)
    local data = load_data(_config.moderation.data)
  if not data['admins'] then
    data['admins'] = {}
    save_data(_config.moderation.data, data)
  end
  if next(data['admins']) == nil then --fix way
    return 'No GLOBAL ADMIN available'
  end
  local message = 'Umbrella Bot GLOBAL ADMINS:\n______________________________\n'
  for k,v in pairs(data['admins']) do
    message = message .. '>> @'.. v ..' ('..k..') \n'
  end
  return message
end

function run(msg, matches)
  if matches[1] == 'debug' then
    return debugs(msg)
  end
  if not is_chat_msg(msg) then
    return "Only work in group"
  end
  local mod_cmd = matches[1]
  local receiver = get_receiver(msg)
  if matches[1] == 'modadd' then
    return modadd(msg)
  end
  if matches[1] == 'modrem' then
    return modrem(msg)
  end
  if matches[1] == 'modset' and matches[2] then
    if not is_momod(msg) then
        return "GLOBAL ADMIN and moderator can set moderator"
    end
  local member = string.gsub(matches[2], "@", "")
    chat_info(receiver, username_id, {mod_cmd= mod_cmd, receiver=receiver, member=member})
  end
  if matches[1] == 'moddem' and matches[2] then
    if not is_momod(msg) then
        return "GLOBAL ADMIN and moderator can demote moderator"
    end
    if string.gsub(matches[2], "@", "") == msg.from.username then
        return "can not demote yourself"
    end
  local member = string.gsub(matches[2], "@", "")
    chat_info(receiver, username_id, {mod_cmd= mod_cmd, receiver=receiver, member=member})
  end
  if matches[1] == 'modlist' then
    return modlist(msg)
  end
  if matches[1] == 'adminset' then
    if not is_admin(msg) then
        return "Only SUDO can set GLOBAL ADMIN"
    end
  local member = string.gsub(matches[2], "@", "")
    chat_info(receiver, username_id, {mod_cmd= mod_cmd, receiver=receiver, member=member})
  end
  if matches[1] == 'admindem' then
    if not is_admin(msg) then
        return "Only SUDO can demote GLOBAL ADMIN"
    end
    local member = string.gsub(matches[2], "@", "")
    chat_info(receiver, username_id, {mod_cmd= mod_cmd, receiver=receiver, member=member})
  end
  if matches[1] == 'adminlist' then
    if not is_admin(msg) then
        return 'You are NOT GLOBAL ADMIN'
    end
    return admin_list(msg)
  end
  if matches[1] == 'chat_add_user' and msg.action.user.id == our_id then
    return automodadd(msg)
  end
  if matches[1] == 'chat_created' and msg.from.id == 0 then
    return automodadd(msg)
  end
end

return {
  description = "Robot and Group Moderation System", 
  usage = {
      moderator = {
          "/modlist : moderator list",
          "/modset (@user) : set moderator",
          "/moddem (@user) : remove moderator",
          },
      admin = {
          "/modadd : add moderation list",
          "/modrem : remove moderation list",
		  "/adminlist : global admin list",
		  "/adminset (@user) : set global admin",
          "/admindem (@user) : remove global admin",
          },
      sudo = {
          "/adminset (@user) : set global admin",
          "/admindem (@user) : remove global admin",
          },
      },
  patterns = {
    "^[!/](modadd)$",
    "^[!/](modrem)$",
    "^[!/](modset) (.*)$",
    "^[!/](moddem) (.*)$",
    "^[!/](modlist)$",
    "^[!/](adminset) (.*)$", -- sudoers only
    "^[!/](admindem) (.*)$", -- sudoers only
    "^[!/](adminlist)$",
    "^!!tgservice (chat_add_user)$",
    "^!!tgservice (chat_created)$",
  }, 
  run = run,
}

end
