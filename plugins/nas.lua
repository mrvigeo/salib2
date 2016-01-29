do

local function send_title(cb_extra, success, result)
  if success then
    send_msg(cb_extra[1], cb_extra[2], ok_cb, false)
  end
end

local function run(msg, matches)
  local eq = URL.escape(matches[1])

  local url = "http://http://nastaliqonline.ir/NastaliqOnline.ir.aspx?59027.3737267"
    .."\\dpi{300}%20\\LARGE%20"..eq

  local receiver = get_receiver(msg)
  local title = "Edit LaTeX on http://nastaliqonline.ir/"..eq
  send_photo_from_url(receiver, url, send_title, {receiver, title})
end

return {
  description = "Convert Text to Image",
  usage = {
    "/nas (txt) : convert txt to img"
  },
  patterns = {
    "^[!/]nas(.+)$"
  },
  run = run
}

end
