---------------------------------------------------------------
-- Custom Disconnect Reason by Fraizeraust
-- U.S.G.N. ID #99488
-- Date: 08 - 10 - 2018
---------------------------------------------------------------

---------------------------------------------------------------
-- Config
---------------------------------------------------------------

-- Change the server tag to whatever you want, the default is [SERVER]
local ServerTag = '[SERVER]:'

-- The default colour is white, you can change it to what you want
local ColourOutput = '\169255255255'
local ColourOutputWarning = '\169240128128'

---------------------------------------------------------------
-- Setup & Core
---------------------------------------------------------------

-- This table is used to gather the user's reason input
-- DO NOT alter the table, keep it AS IS!
ReasonInput = {}

function TableCommands(text, match)

  -- Set the local table which will hold the input's commands
  local Command = {}

  -- If the "match" parameter doesn't hold anything, make it so
  if ( not match ) then 
    match = '[^%s]+'
  end

  for word in string.gmatch(text, match) do
    table.insert(Command, word)
  end

  -- If things went good, terminate the function
  return Command
end

function SayDisconnectReason(id, message)
  -- Append the variable input to the function
  Command = TableCommands(message)
  
  if ( Command[1] == '!disconnect' ) then
    -- Retrieve the second argument of the command
    -- We'll use it to store in the ReasonInput table
    local ReasonParam = message:sub(12, #message)
    
    -- Check if the user provided a reason argument
    -- If not, then output a message and bail out
    if ( ReasonParam ~= ' ' ) then
      -- Parameter has been given. Save it!
      ReasonInput[id] = ReasonParam
      msg2(id, ColourOutput .. '' .. ServerTag .. ' You\'ve set your disconnect reason successfully!')
      msg2(id, ColourOutput .. '' .. ServerTag .. ' It\'ll be displayed once you leave the server!')
    else
      msg2(id, ColourOutputWarning .. '' .. ServerTag .. ' Please specify a reason!')
    end
  end
  
  return 1
end

function LeaveDisplayDisconnectReason(id)
  if ( ReasonInput[id] ) then
    -- Display the reason and set the ReasonInput table to nil
    msg(ColourOutput .. '' .. ServerTag .. ' ' .. player(id, 'name') .. ' has left the game. Reason:' .. ReasonInput[id])
    ReasonInput[id] = nil
  end
end

---------------------------------------------------------------
-- Hooks
---------------------------------------------------------------
addhook('say', 'SayDisconnectReason')
addhook('leave', 'LeaveDisplayDisconnectReason')