
do

  local function scan_name(extra, success, result)
    local founds = {}
    for k,member in pairs(result.members) do
      if extra.name then
        gp_member = extra.name
        fields = {'first_name', 'last_name', 'print_name'}
      elseif extra.user then
        gp_member = string.gsub(extra.user, '@', '')
        fields = {'username'}
      end
      for k,field in pairs(fields) do
        if member[field] and type(member[field]) == 'string' then
          if member[field]:match(gp_member) then
            founds[tostring(member.id)] = member
          end
        end
      end
    end
    if next(founds) == nil then -- Empty table
      send_large_msg(extra.receiver, (extra.name or extra.user)..' not found on this chat.')
    else
      local text = ''
      for k,user in pairs(founds) do
        text = text..'Name: '..(user.first_name or '')..' '..(user.last_name or '')..'\n'
               ..'نام: '..(user.first_name or '')..'\n'
               ..'فامیلی: '..(user.last_name or '')..'\n'
               ..'ایدی: @'..(user.username or '')..'\n'
               ..'ایدی عددی: '..(user.id  or '')..'\n\n'
      end
      send_large_msg(extra.receiver, text)
    end
  end

  local function action_by_reply(extra, success, result)
    local text = 'Name: '..(result.from.first_name or '')..' '..(result.from.last_name or '')..'\n'
                 ..'نام: '..(result.from.first_name or '')..'\n'
                 ..'فامیلی: '..(result.from.last_name or '')..'\n'
                 ..'ایدی: @'..(result.from.username or '')..'\n'
                 ..'ایدی عددی: '..result.from.id
    send_large_msg(extra.receiver, text)
  end

  local function returnids(extra, success, result)
    local chat_id = extra.msg.to.id
    local text = '['..result.id..'] '..result.title..'.\n'
                 ..result.members_num..' members.\n\n'
    i = 0
    for k,v in pairs(result.members) do
      i = i+1
      if v.username then
        user_name = ' @'..v.username
      else
        user_name = ''
      end
      text = text..i..'. ['..v.id..'] '..user_name..' '..(v.first_name or '')..(v.last_name or '')..'\n'
    end
    if extra.matches == 'pm' then
      send_large_msg('user#id'..extra.msg.from.id, text)
    elseif extra.matches == 'txt' or extra.matches == 'pmtxt' then
      local textfile = '/tmp/chat_info_'..chat_id..'_'..os.date("%y%m%d.%H%M%S")..'.txt'
      local file = io.open(textfile, 'w')
      file:write(text)
      file:flush()
      file:close()
      if extra.matches == 'txt' then
        send_document('chat#id'..chat_id, textfile, rmtmp_cb, {file_path=textfile})
      elseif extra.matches == 'pmtxt' then
        send_document('user#id'..extra.msg.from.id, textfile, rmtmp_cb, {file_path=textfile})
      end
    elseif not extra.matches then
      send_large_msg('chat#id'..chat_id, text)
    end
  end

  local function run(msg, matches)
    local receiver = get_receiver(msg)
    if is_chat_msg(msg) then
      if msg.text == '!info' then
        if msg.reply_id then
          if is_mod(msg) then
            msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver})
          end
        else
          local text = 'Name: '..(msg.from.first_name or '')..' '..(msg.from.last_name or '')..'\n'
                       ..'First name: '..(msg.from.first_name or '')..'\n'
                       ..'Last name: '..(msg.from.last_name or '')..'\n'
                       ..'User name: @'..(msg.from.username or '')..'\n'
                       ..'ID: ' .. msg.from.id
          local text = text..'\n\nYou are in group '
                       ..msg.to.title..' (ID: '..msg.to.id..')'
          return text
        end
      elseif is_mod(msg) and matches[1] == 'chat' then
        if matches[2] == 'pm' or matches[2] == 'txt' or matches[2] == 'pmtxt' then
          chat_info(receiver, returnids, {msg=msg, matches=matches[2]})
        else
          chat_info(receiver, returnids, {msg=msg})
        end
      elseif is_mod(msg) and string.match(matches[1], '^@.+$') then
        chat_info(receiver, scan_name, {receiver=receiver, user=matches[1]})
      elseif is_mod(msg) and string.gsub(matches[1], ' ', '_') then
        user = string.gsub(matches[1], ' ', '_')
        chat_info(receiver, scan_name, {receiver=receiver, name=matches[1]})
      end
    else
      return 'You are not in a group.'
    end
  end

  return {
    description = 'Know your id or the id of a chat members.',
    usage = {
      user = {
        '!info: will show your id and group id .'
      },
      moderator = {
        '!info : will give you the id of member or yourself',
        '!info chat : the ids of chat',
        '!info chat txt : will give the ids of chat in text file',
        '!info chat pm : will give chat ids in Private ',
        '!info chat pmtxt : will give chat ids in text file to your privat',
        '!info <id> : will shot the ids of chat group',
        '!info @<user_name> : will return the info of username ',
        '!info <text> : will return the info of that name or last name'
      },
    },
    patterns = {
      "^info$",
      "^info (chat) (.*)$",
	  "^info (chat) (.*)$",
      "^info (.*)$"
    },
    run = run
  }

end
