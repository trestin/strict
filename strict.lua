--
-- All global variables must be declared througt 'global_variable' function
-- (even asssigning nil will do) before being used.
-- checks duplicate global variable
-- usage : global_variable("a", 1)
--         global_variable("b)
--

local error, rawset = error, rawset

local declared = {}

local mt = getmetatable(_G)
if mt == nil then
  mt = {}
  setmetatable(_G, mt)
end

mt.__newindex = function(t, n, v)
  if not declared[n] and type(v) ~= "function" then
    error("assign to undeclared variable '"..n.."'", 2)
  end
  rawset(t, n, v)
end

function global_variable(n, v)
  if declared[n] then
    error("re-declare variable '"..n.."'", 2)
  end
  declared[n] = true
  rawset(_G, n, v)
end
