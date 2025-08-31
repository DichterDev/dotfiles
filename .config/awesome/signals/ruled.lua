-- ruled related signals
local ruled = require("ruled")

local R = {} -- TODO: create a script defining the rules

local function createRules(rules)
  local t = {}
  for id, rule in pairs(rules) do
    rule.id = id
    table.insert(t, rule)
  end
  return t
end

ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rules(createRules(R))
end)
