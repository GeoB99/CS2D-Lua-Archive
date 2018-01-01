-----------------------------------
-- Player's Country Info
-- Script by ZxC (#99488)
-- Date: 23 - 04 - 2017
-----------------------------------


-----------------------------------
-- Engine & Setup
-----------------------------------


function LookUpIPonJoin(id)

   local handleIPonJoin = io.popen( 'geoiplookup ' .. player(id, 'ip') )
   local resolveIPonJoin = handleIPonJoin:read('*a')

   handleIPonJoin:close()

   if not resolveIPonJoin or resolveIPonJoin == '' then
      return false
   elseif resolveIPonJoin:find('can\'t resolve') ~= nil then
      msg( '\169255255255[SERVER]: ' .. player(id, 'name') .. ' has joined from \169000191255N/A' )
   elseif resolveIPonJoin:find('not found') then
      msg( '\169255255255[SERVER]: ' .. player(id, 'name') .. ' has joined from \169000191255N/A' )
   elseif resolveIPonJoin:find('GeoIP Country Edition:') then -- Just check if the IP has been successfully resolved, same like below

      local resultOnJoin = resolveIPonJoin:match(':[%s]([%w].+)\n')

      msg( '\169255255255[SERVER]: ' .. player(id, 'name') .. ' has joined from ' .. '\169000191255' .. resultOnJoin)
      return resultOnJoin
   end
end

function LookUpIPonLeave(id)

   local handleIPonLeave = io.popen( 'geoiplookup ' .. player(id, 'ip') )
   local resolveIPonLeave = handleIPonLeave:read('*a')

   handleIPonLeave:close()

   if not resolveIPonLeave or resolveIPonLeave == '' then
      return false
   elseif resolveIPonLeave:find('can\'t resolve') ~= nil then
      msg( '\169255255255[SERVER]: ' .. player(id, 'name') .. ' has left from \169000191255N/A' )
   elseif resolveIPonLeave:find('not found') then
      msg( '\169255255255[SERVER]: ' .. player(id, 'name') .. ' has left from \169000191255N/A' )
   elseif resolveIPonLeave:find('GeoIP Country Edition:') then

      local resultOnLeave = resolveIPonLeave:match(':[%s]([%w].+)\n')

      msg( '\169255255255[SERVER]: ' .. player(id, 'name') .. ' has left from ' .. '\169000191255' .. resultOnLeave)
      return resultOnLeave
   end
end


-----------------------------------
-- Hooks
-----------------------------------

addhook('leave', 'LookUpIPonLeave')
addhook('join', 'LookUpIPonJoin')
