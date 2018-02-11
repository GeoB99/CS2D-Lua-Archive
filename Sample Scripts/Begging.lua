Begging = {"pls me mod","i want adm pls"}

function _say(id, text)
	for i = 1, #Begging do
		if (string.find(text,Begging[i])) then
			msg("\169240128128"..player(id,"name").." was begging for administration ranks. Kicked!")
			parse("kick "..id.." \"You've begged for administration ranks, therefore you're punished with a kick!\"")
		end
	end
end

addhook("say","_say")
