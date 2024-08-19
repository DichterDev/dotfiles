local dir = {}

dir.home = {
    '.bashrc',
}

dir.config = {
  'wezterm',
  'nvim',
}

-- insert into local config
local function insert (cur, loc)
  os.execute(string.format('cp -r ./%s %s', loc, cur))
end

-- get from local config
local function get (cur, loc)
  local s = string.format('cp -r %s ./%s', cur, loc)
  print(s)
  os.execute(s)
end

local function generate (par, sub)
  if par == "home" then
    return string.format('~/%s', sub)
  elseif par == "config" then
    return string.format('~/.config/%s', sub)
  end
end

local function iterateDirectories (c)
  for k, v in pairs(dir) do
    for j in pairs(v) do
      if c == 1 then
        get(generate(k, v[j]), v[j])
      elseif c == 2 then
        insert(generate(k, v[j]), v[j])
      else
        io.write('Invalid input 1 or 2: ')
        local s = io.read('n')
        iterateDirectories(s)
      end
    end
  end
end

io.write('Do you want to get(1) or insert(2)?: ')
local s = io.read('n')
iterateDirectories(s)
