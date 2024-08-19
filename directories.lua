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
  print(string.format('%s -> %s%s', loc, cur, loc))
end

-- get from local config
local function get (cur, loc)
  os.execute(string.format('rm -r ./%s', loc))
  local s = string.format('cp -r %s%s ./', cur, loc)
  os.execute(s)
  print(string.format('%s%s -> %s', cur, loc, loc))
end

local function generate (par)
  if par == "home" then
    return string.format('~/')
  elseif par == "config" then
    return string.format('~/.config/')
  end
end

local function iterateDirectories (c)
  for k, v in pairs(dir) do
    for j in pairs(v) do
      if c == 1 then
        get(generate(k), v[j])
      elseif c == 2 then
        insert(generate(k), v[j])
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
