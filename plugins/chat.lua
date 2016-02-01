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
if msg.text == "ربات" then
	return "بله؟"
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
if msg.text == "گه نخور" then
        return "من تو رو نمیخورم"
end
if msg.text == "کس ننت" then
	return "با مِیمَنَت ، اینم سند ، تو شرتو کرستِ ننت"
end
if msg.text == "ببخشید" then
	return "خدا ببخشه"
end
if msg.text == "بای" then
        return "خدافظ ، مراقب زیباییات باش."
end
if msg.text == "کسکش" then
        return "فحش نده 😡"
end
if msg.text == "سلام" then
        return "سلام عزیزم 🌷"
end
if msg.text == "خستم" then
        return "خسته نباشی دلاور"
end
if msg.text == "خیلی خستم" then
        return "خسته نباشی پهلوون"
end
if msg.text == "Difense" then
        return "با عموم چکار داری ؟"
end
if msg.text == "difense" then
        return "با عموم چکار داری ؟"
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
                "^[Gg]oh nakhor$",
                "^sik :D$",
                "^[Bb]ashe$",
                "^ARJ$",
                "^A.R.J$",
                "^[Dd]ifense$",
                "^گه نخور$",
                "^ربات$",
                "^کس ننت$",
                "^ببخشید$",
                "^بای$",
                "^کسکش$",
                "^سلام$",
                "^خستم$",
                "^خیلی خستم$",
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
