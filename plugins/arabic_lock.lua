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
