-----------------
-- Score & Deaths register by ZxC
-- U.S.G.N. ID #99488
-- Date: 11 - 06 - 2016
-----------------


-- Setup & Core

local Player = {}

for id = 1, 32 do
	Player[id] = {
		Score = 0,
		Deaths = 0
	}
end

function JoinSetup(id)
	Player[id].Score = 0
	Player[id].Deaths = 0
end

function DataSetup(id)
	parse('setscore ' .. id .. ' ' .. Player[id].Score .. '; setdeaths ' .. id .. ' ' .. Player[id].Deaths, 0)
end

function DataRegister(killer, victim)
	if ( Player[killer] and Player[victim] ) then
		Player[killer].Score = Player[killer].Score + 1
		Player[victim].Deaths = Player[victim].Deaths + 1
	end
end

function DataCheck(id, msg)
	if ( msg:sub(1, 12) == 'sv_scorespec' ) then
		local TargetID = tonumber( msg:sub(14, #msg) )
		if ( TargetID and player(TargetID, 'exists') and player(TargetID, 'team') == 0) then
			msg2(id, '\169128128128[SERVER]: \169135206250' .. player(TargetID, 'name') .. ' has ' .. Player[TargetID].Score .. ' as score frags and ' .. Player[TargetID].Deaths .. ' as deaths.')
		else
			msg2(id, '\169128128128[SERVER]: \169240128128The specific player doesn\'t exist or there must be ID parameter or the player isn\'t a Spectator!')
		end
		return 1
	end
end

function DataObliterate(id)
	Player[id].Score = 0
	Player[id].Deaths = 0
end

function DataReset(mode)
	for _, id in pairs( player(0, 'table') ) do
		if (mode == 5 or mode == 3) then
			Player[id].Score = 0
			Player[id].Deaths = 0
		end
	end
end

-- Hooks

addhook('join', 'JoinSetup')
addhook('team', 'DataSetup')
addhook('kill', 'DataRegister')
addhook('say', 'DataCheck')
addhook('leave', 'DataObliterate')
addhook('endround', 'DataReset')
