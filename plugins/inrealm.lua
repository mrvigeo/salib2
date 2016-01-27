-- data saved to moderation.json
-- check moderation plugin
do

local function create_group(msg)
        -- superuser and admins only (because sudo are always has privilege)
        if is_sudo(msg) or is_realm(msg) and is_admin(msg) then
                local group_creator = msg.from.print_name
                create_group_chat (group_creator, group_name, ok_cb, false)
                return 'Group [ '..string.gsub(group_name, '_', ' ')..' ] has been created.'
        end
end

local function create_realm(msg)
        -- superuser and admins only (because sudo are always has privilege)
        if is_sudo(msg) or is_realm(msg) and is_admin(msg) then
                local group_creator = msg.from.print_name
                create_group_chat (group_creator, group_name, ok_cb, false)
                return 'Realm [ '..string.gsub(group_name, '_', ' ')..' ] has been created.'
        end
end


local function killchat(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.id)     
  end
end

local function killrealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.id)     
  end
end

local function get_group_type(msg)
  local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
    if not data[tostring(msg.to.id)]['group_type'] then
     return 'No group type available.'
    end
     local group_type = data[tostring(msg.to.id)]['group_type']
     return group_type
  else 
     return 'Chat type not found.'
  end 
end

local function callbackres(extra, success, result)
--vardump(result)
  local user = result.id
  local name = string.gsub(result.print_name, "_", " ")
  local chat = 'chat#id'..extra.chatid
  send_large_msg(chat, user..'\n'..name)
  return user
end

local function set_description(msg, data, target, about)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local data_cat = 'description'
        data[tostring(target)][data_cat] = about
        save_data(_config.moderation.data, data)
        return 'Set group description to:\n'..about
end
 
local function set_rules(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local data_cat = 'rules'
        data[tostring(target)][data_cat] = rules
        save_data(_config.moderation.data, data)
        return 'Set group rules to:\n'..rules
end
-- lock/unlock group name. bot automatically change group name when locked
local function lock_group_name(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_name_set = data[tostring(target)]['settings']['set_name']
    local group_name_lock = data[tostring(target)]['settings']['lock_name']
        if group_name_lock == 'yes' then
            return 'Group name is already locked'
        else
            data[tostring(target)]['settings']['lock_name'] = 'yes'
                save_data(_config.moderation.data, data)
                rename_chat('chat#id'..target, group_name_set, ok_cb, false)
        return 'Group name has been locked'
        end
end
 
local function unlock_group_name(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_name_set = data[tostring(target)]['settings']['set_name']
    local group_name_lock = data[tostring(target)]['settings']['lock_name']
        if group_name_lock == 'no' then
            return 'Group name is already unlocked'
        else
            data[tostring(target)]['settings']['lock_name'] = 'no'
            save_data(_config.moderation.data, data)
        return 'Group name has been unlocked'
        end
end
--lock/unlock group member. bot automatically kick new added user when locked
local function lock_group_member(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_member_lock = data[tostring(target)]['settings']['lock_member']
        if group_member_lock == 'yes' then
            return 'Group members are already locked'
        else
            data[tostring(target)]['settings']['lock_member'] = 'yes'
            save_data(_config.moderation.data, data)
        end
        return 'Group members has been locked'
end
 
local function unlock_group_member(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_member_lock = data[tostring(target)]['settings']['lock_member']
        if group_member_lock == 'no' then
            return 'Group members are not locked'
        else
            data[tostring(target)]['settings']['lock_member'] = 'no'
            save_data(_config.moderation.data, data)
        return 'Group members has been unlocked'
        end
end
 
--lock/unlock group photo. bot automatically keep group photo when locked
local function lock_group_photo(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
        if group_photo_lock == 'yes' then
            return 'Group photo is already locked'
        else
            data[tostring(target)]['settings']['set_photo'] = 'waiting'
            save_data(_config.moderation.data, data)
        end
        return 'Please send me the group photo now'
end
 
local function unlock_group_photo(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
        if group_photo_lock == 'no' then
            return 'Group photo is not locked'
        else
            data[tostring(target)]['settings']['lock_photo'] = 'no'
            save_data(_config.moderation.data, data)
        return 'Group photo has been unlocked'
        end
end
 
local function lock_group_flood(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_flood_lock = data[tostring(target)]['settings']['flood']
        if group_flood_lock == 'yes' then
            return 'Group flood is locked'
        else
            data[tostring(target)]['settings']['flood'] = 'yes'
            save_data(_config.moderation.data, data)
        return 'Group flood has been locked'
        end
end
 
local function unlock_group_flood(msg, data, target)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local group_flood_lock = data[tostring(target)]['settings']['flood']
        if group_flood_lock == 'no' then
            return 'Group flood is not locked'
        else
            data[tostring(target)]['settings']['flood'] = 'no'
            save_data(_config.moderation.data, data)
        return 'Group flood has been unlocked'
        end
end
-- show group settings
local function show_group_settings(msg, data, target)
    local data = load_data(_config.moderation.data, data)
    if not is_admin(msg) then
        return "For admins only!"
    end
    local settings = data[tostring(target)]['settings']
    local text = "Group settings:\nLock group name : "..settings.lock_name.."\nLock group photo : "..settings.lock_photo.."\nLock group member : "..settings.lock_member
    return text
end

local function returnids(cb_extra, success, result)
 
        local receiver = cb_extra.receiver
    local chat_id = "chat#id"..result.id
    local chatname = result.print_name
    local text = 'Users in '..string.gsub(chatname,"_"," ")..' ('..result.id..'):'..'\n'..''
    for k,v in pairs(result.members) do
    	if v.print_name then
        	local username = ""
        	text = text .. "- " .. string.gsub(v.print_name,"_"," ") .. "  (" .. v.id .. ") \n"
        end
    end
    send_large_msg(receiver, text)
        local file = io.open("./groups/lists/"..result.id.."memberlist.txt", "w")
        file:write(text)
        file:flush()
        file:close()
end
 
local function returnidsfile(cb_extra, success, result)
    local receiver = cb_extra.receiver
    local chat_id = "chat#id"..result.id
    local chatname = result.print_name
    local text = 'Users in '..string.gsub(chatname,"_"," ")..' ('..result.id..'):'..'\n'..''
    for k,v in pairs(result.members) do
    	if v.print_name then
        	local username = ""
        	text = text .. "- " .. string.gsub(v.print_name,"_"," ") .. "  (" .. v.id .. ") \n"
        end
    end
        local file = io.open("./groups/lists/"..result.id.."memberlist.txt", "w")
        file:write(text)
        file:flush()
        file:close()
        send_document("chat#id"..result.id,"./groups/lists/"..result.id.."memberlist.txt", ok_cb, false)
end
 
local function admin_promote(msg, admin_id)
        if not is_sudo(msg) then
        return "Access denied!"
    end
        local admins = 'admins'
        if not data[tostring(admins)] then
                data[tostring(admins)] = {}
                save_data(_config.moderation.data, data)
        end
        if data[tostring(admins)][tostring(admin_id)] then
                return admin_name..' is already an admin.'
        end
        data[tostring(admins)][tostring(admin_id)] = admin_id
        save_data(_config.moderation.data, data)
        return admin_id..' has been promoted as admin.'
end

local function admin_demote(msg, admin_id)
    if not is_sudo(msg) then
        return "Access denied!"
    end
    local data = load_data(_config.moderation.data)
        local admins = 'admins'
        if not data[tostring(admins)] then
                data[tostring(admins)] = {}
                save_data(_config.moderation.data, data)
        end
        if not data[tostring(admins)][tostring(admin_id)] then
                return admin_id..' is not an admin.'
        end
        data[tostring(admins)][tostring(admin_id)] = nil
        save_data(_config.moderation.data, data)
        return admin_id..' has been demoted from admin.'
end
 
local function admin_list(msg)
    local data = load_data(_config.moderation.data)
        local admins = 'admins'
        if not data[tostring(admins)] then
        data[tostring(admins)] = {}
        save_data(_config.moderation.data, data)
        end
        local message = 'List for Realm admins:\n'
        for k,v in pairs(data[tostring(admins)]) do
                message = message .. '- (at)' .. v .. ' [' .. k .. '] ' ..'\n'
        end
        return message
end
 
local function groups_list(msg)
    local data = load_data(_config.moderation.data)
        local groups = 'groups'
        if not data[tostring(groups)] then
                return 'No groups at the moment'
        end
        local message = 'List of groups:\n'
        for k,v in pairs(data[tostring(groups)]) do
                local settings = data[tostring(v)]['settings']
                for m,n in pairs(settings) do
                        if m == 'set_name' then
                                name = n
                        end
                end
                local group_owner = "No owner"
                if data[tostring(v)]['set_owner'] then
                        group_owner = tostring(data[tostring(v)]['set_owner'])
                end
                local group_link = "No link"
                if data[tostring(v)]['settings']['set_link'] then
			group_link = data[tostring(v)]['settings']['set_link']
		end

                message = message .. '- '.. name .. ' (' .. v .. ') ['..group_owner..'] \n {'..group_link.."}\n"
             
               
        end
        local file = io.open("./groups/lists/groups.txt", "w")
        file:write(message)
        file:flush()
        file:close()
        return message
       
end
local function realms_list(msg)
    local data = load_data(_config.moderation.data)
        local realms = 'realms'
        if not data[tostring(realms)] then
                return 'No Realms at the moment'
        end
        local message = 'List of Realms:\n'
        for k,v in pairs(data[tostring(realms)]) do
                local settings = data[tostring(v)]['settings']
                for m,n in pairs(settings) do
