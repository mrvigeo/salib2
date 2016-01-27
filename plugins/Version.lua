do

function run(msg, matches)
  return 'Umbrella Telegram Bot v1.5'.. [[ 
  
  Website:
  http://Umbrella.shayan-soft.IR
  Antispam Bot: @UmbrellaTG
  Channel: @UmbrellaTeam
  Sudo (Admin): @shayansoft
  
  Powered by:
  shayan soft Co. Group
  Engineer Shayan Ahmadi
  http://shayan-soft.IR]]
end

return {
  description = "Robot and Creator About", 
  usage = "/ver : robot info",
  patterns = {
    "^[!/]ver$"
  }, 
  run = run 
}

end
