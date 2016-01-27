do

function run(msg, matches)
  return "Hello, " .. matches[1]
end

return {
  description = "Says Hello to Someone", 
  usage = "Say Hello to (name)",
  patterns = {
    "^say hello to (.*)$",
    "^Say hello to (.*)$"
  }, 
  run = run 
}

end
