local function user_print_name(user)
   if user.print_name then
      return user.print_name
   end
   local text = ''
   if user.first_name then
      text = user.last_name..' '
   end
   if user.lastname then
      text = text..user.last_name
   end
   return text
end

local function returnids(cb_extra, success, result)
   local receiver = cb_extra.receiver
   --local chat_id = "chat#id"..result.id
   local chat_id = result.id
   local chatname = result.print_name

   local text = 'Group: '..chatname..' ID: '..chat_id..' Member: '..result.members_num..'\n______________________________\n'
      i = 0
   for k,v in pairs(result.members) do
      i = i+1
      text = text .. i .. "> " .. string.gsub(v.print_name, "_", " ") .. " (" .. v.id .. ")\n"
   end
   send_large_msg(receiver, text)
end

local function username_id(cb_extra, success, result)
   local receiver = cb_extra.receiver
   local qusername = cb_extra.qusername
   local text = 'No '..qusername..' in group'
   for k,v in pairs(result.members) do
      vusername = v.username
      if vusername == qusername then
      	text = 'Username: @'..vusername..'\nID Number: '..v.id
      end
   end
   send_large_msg(receiver, text)
end

local function run(msg, matches)
   local receiver = get_receiver(msg)
   if matches[1] == "!id" then
      local text = 'Your Name: '.. string.gsub(user_print_name(msg.from),'_', ' ') .. '\nYour ID: ' .. msg.from.id
      return text
   elseif matches[1] == "gp" then
      -- !ids? (chat) (%d+)
      if matches[2] and is_sudo(msg) then
         local chat = 'chat#id'..matches[2]
         chat_info(chat, returnids, {receiver=receiver})
      else
         if not is_chat_msg(msg) then
            return "Only work in group"
         end
         local chat = get_receiver(msg)
         chat_info(chat, returnids, {receiver=receiver})
      end
   else
   	if not is_chat_msg(msg) then
   		return "Only work in group"
   	end
   	local qusername = string.gsub(matches[1], "@", "")
   	local chat = get_receiver(msg)
   	chat_info(chat, username_id, {receiver=receiver, qusername=qusername})
   end
end

local function run(msg, matches)
   local receiver = get_receiver(msg)
   if matches[1] == "!gp" then
      if is_chat_msg(msg) then
         text = "Group Name: " .. string.gsub(user_print_name(msg.to), '_', ' ') .. "\nGroup ID: " .. msg.to.id
	  else
	     text = "Only work in group"
      end
      return text
   end
end

return {
   description = "User ID Number and Group ID Number Info",
   usage = {
      "/gp : group name and id",
      "/id : your user and id",
      "/ids gp : all members info in group",
      "/ids gp (id) : members info for other group",
      "/id (@user) : user info"
   },
   patterns = {
      "^[!/]id$",
      "^[!/]ids? (gp) (%d+)$",
      "^[!/]ids? (gp)$",
      "^[!/]id (.*)$",
	  "^[!/]gp$",
   },
   run = run
}
