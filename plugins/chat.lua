local function run(msg)
if msg.text == "ARJ" then
	return " جونم ؟ چی شده؟"
end
if msg.text == "A.R.J" then
	return "بله ، کاری داری ؟"
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
if msg.text == "bashe" then
	return "تکون نخور لاشه"
end
if msg.text == "Bashe" then
	return "بشین چشات وا شه"
end
if msg.text == "bot" then
	return "بله ؟"
end
if msg.text == "sik :D" then
	return " مودب باش رباتِ بی تلبیت"
end
if msg.text == "kooni" then
	return "فحش نده"
end
if msg.text == "suck it" then
	return "مودب باش"
end
if msg.text == "؟" then
	return "بله ؟"
end
if msg.text == "bye" then
	return "بای عشقم"
end
if msg.text == "Bye" then
	return "خدافظ ، مواظب زیباییت باش"
end
if msg.text == "goh nakhor" then
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
