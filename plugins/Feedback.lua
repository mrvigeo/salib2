do

function run(msg, matches)

local fuse = '#DearAdmin😜 we have recived a new feedback just now : #newfeedback \n\nID▶️ : ' .. msg.from.id .. '\n\nName▶ : ' .. msg.from.print_name ..'\n\nusername▶️ :@ ' .. msg.from.username  ..'\n\n🅿️♏️ :\n\n\n' .. matches[1] 
local fuses = '!printf user#id' .. msg.from.id


    local text = matches[1]
 bannedidone = string.find(msg.from.id, '123')
        bannedidtwo =string.find(msg.from.id, '465')       
   bannedidthree =string.find(msg.from.id, '678')  


        print(msg.to.id)

        if bannedidone or bannedidtwo or bannedidthree then                    --for banned people
                return 'You are banned to send a feedback'
 else


                 local sends0 = send_msg('chat#107855523', fuse, ok_cb, false)

 return 'پیام شما با موفقیت به تیم قدرتمند صلیب فرستاده شد.'

     

end

end
return {
  description = "Feedback",

  usage = "feedback : پیام خودرا ارسال کنید",
  patterns = {
    "^[Ff]eedback (.*)$"

  },
  run = run
}

end
