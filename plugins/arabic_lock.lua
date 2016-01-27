
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






local function run(msg)
if msg.text == "سلام" then
	return "سلام خوبی؟"
end
if msg.text == "Hi" then
	return "سلام ، فارسی تایپ کن"
end
if msg.text == "hi" then
	return "سلام...  اگه میشه فارسی تایپ کن"
end
if msg.text == "hello" then
	return "Hi honey"
end
if msg.text == "Salam" then
	return "سلام علیکم ، فارسی تایپ کن"
end
if msg.text == "salam" then
	return "و علیکومو سلام ، فارسی تایپ کن لطفا"
end
if msg.text == "خسته شدم" then
	return "بس که دلم دنبال یک بهونه گشت"
end
if msg.text == "باشه" then
	return "تکون نخور لاشه"
end
if msg.text == "باوشه" then
	return "بشین چشات وا شه"
end
if msg.text == "ربات" then
	return "بله ؟"
end
if msg.text == "کسکش" then
	return "فحش نده"
end
if msg.text == "کونی" then
	return "فحش نده"
end
if msg.text == "حروم زاده" then
	return "مودب باش"
end
if msg.text == "?" then
	return "بله ؟"
end
if msg.text == "Bye" then
	return "بای عشقم"
end
if msg.text == "بای" then
	return "خدافظ ، مواظب زیباییت باش"
end
if msg.text == "گه نخور" then
        return "تو بخور"
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
end
