function say_(id, text)
     if string.sub(text, 1, 6) == "!check" then
          for _,i in pairs(player(0,"table")) do
               msg2(id,"# "..i..", "..player(i,"name")..", IP: "..player(i,"ip")..", USGN: "..player(i,"usgn"))
          end
     end
end

addhook("say","say_")