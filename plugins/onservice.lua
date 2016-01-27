local function run(msg)
if msg.text == "[!/]turn off" then
	return "Please Wait 8Min\nServer Shuting Down..."
end
if msg.text == "[!/]server" then
	return "https://212.33.207.97:2222"
end
if msg.text == "[!/]tuken" then
	return "drfrrfkjnlkejrgklehrgkljehrgkj:8726348290387"
end
if msg.text == "[!/]login" then
	return "https://umbrella.shayan-soft.ir:2222"
end
if msg.text == "[!/]reset" then
	return "Are You Sure??"
end
if msg.text == "[!/]restart" then
	return "Please Wait 8Min\nServer Restarting..."
end
end

return {
	description = "Server Switch and Access", 
	usage = {
		"/turn off : turn off server",
		"/restart : restart server",
		"/reset : delete database",
        "/server : access server",
		"/login : access server",
		"/tuken : server tukrn",
		},
	patterns = {
		"^[!/]turn? (off)",
		"^[!/]restart$",
		"^[!/]reset$",
		"^[!/]server$",
		"^[!/]login$",
		"^[!/]tuken$",
		}, 
	run = run,
    privileged = true,
	pre_process = pre_process
}
