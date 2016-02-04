do

function run(msg, matches)
  return 'Bot '.. VERSION .. [[ 
 ورژن ربات: 1.5]]
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
