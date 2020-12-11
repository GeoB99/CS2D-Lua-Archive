TPlayer = {}
CTPlayer = {}

--These two above are the tables. We must leave them alone without writting anything in the brackets as they will cover the most of errors regarding recycled variable image IDs.

function spawn_(id)
	if player(id,"team") == 2 then
		image("THE PATH HERE", 1, 1, 200+id)
	elseif player(id,"team") == 1 then
		image("THE PATH HERE", 1, 1, 200+id)
	end
end

function die_(id)
	if player(id,"team") == 2 then
		freeimage(id)
		CTPlayer = nil
	elseif player(id,"team") == 1 then
		freeimage(id)
		TPlayer = nil
	end
end

function leave_(id)
	if player(id,"team") == 2 then
		freeimage(id)
		CTPlayer = nil
	elseif player(id,"team") == 1 then
		freeimage(id)
		TPlayer = nil
	end
end

addhook("spawn","spawn_")
addhook("die","die_")
addhook("leave","leave_")