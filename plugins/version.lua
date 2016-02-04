do

function run(msg, matches)
  return 'Bot '.. VERSION .. [[ 
ورژن ربات: 1.5
ایدی سودوها:
@Xx_king_salib_Xx
@Mr_Vigeo
@Xx_minister_salib_xX
]]
end

return {
  description = "Shows bot version", 
  usage = "ورژن: Shows bot version",
  patterns = {
    "^ورژن$"
  }, 
  run = run 
}

end
