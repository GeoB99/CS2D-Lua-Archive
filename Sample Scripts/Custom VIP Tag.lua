p = {}

addhook("team","_t")
function _t(id,t)
     if not p[id] then p[id] = 0 end
end

addhook("minute","_m")
function _m()
	for k, v in pairs(player(0, "table")) do
		p[v] = p[v] + 1
		if p[v] == 1 then
			msg("\169255255255"..player(id, "name").." [VIP]: "..text)
		end
	end
end

addhook("leave","_l")
function _l(id)
     if p[id] then p[id] = nil end
end