
antiarabic = {}-- An empty table for solving multiple kicking problem

do
local function run(msg, matches)
  if is_momod(msg) then -- Ignore mods,owner,admins
    return
  end
  local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)]['settings']['lock_arabic'] then
    if data[tostring(msg.to.id)]['settings']['lock_arabic'] == 'yes' then
      if antiarabic[msg.from.id] == true then 
        return
      end
      send_large_msg("chat#id".. msg.to.id , "Arabic is not allowed here")
      local name = user_print_name(msg.from)
      savelog(msg.to.id, name.." ["..msg.from.id.."] kicked (arabic was locked) ")
      chat_del_user('chat#id'..msg.to.id,'user#id'..msg.from.id,ok_cb,false)
		  antiarabic[msg.from.id] = true
      return
    end
  end
  return
end
local function cron()
  antiarabic = {} -- Clear antiarabic table 
end
return {
  patterns = {
    "([\216-\219][\128-\191])"
    },
  run = run,
	cron = cron
}

end




local function run(msg)
if msg.text == "hi" then
	return "سلام عسلم"
end
if msg.text == "Hi" then
	return "سلام عزیزم"
end
if msg.text == "Hello" then
	return "سلام...  اگه میشه فارسی تایپ کن"
end
if msg.text == "hello" then
	return "Hi honey"
end
if msg.text == "Salam" then
	return "سلام علیکم"
end
if msg.text == "salam" then
	return "و علیکومو سلام"
end
if msg.text == "zac" then
	return "براش بزن ساک"
end
if msg.text == "Zac" then
	return "Barash bezan sak"
end
if msg.text == "ZAC" then
	return "Barash bezan sak"
end
if msg.text == "Umbrella" then
	return "Yes?"
end
if msg.text == "umbrella" then
	return "What?"
end
if msg.text == "bot" then
	return "hum?"
end
if msg.text == "Bot" then
	return "Huuuum?"
end
if msg.text == "?" then
	return "Hum??"
end
if msg.text == "Bye" then
	return "Babay"
end
if msg.text == "bye" then
	return "Bye Bye"
end
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
		"^[Hh]i$",
		"^[Hh]ello$",
		"^[Zz]ac$",
		"^ZAC$",
		"^[Bb]ot$",
		"^[Uu]mbrella$",
		"^[Bb]ye$",
		"^?$",
		"^[Ss]alam$",
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
