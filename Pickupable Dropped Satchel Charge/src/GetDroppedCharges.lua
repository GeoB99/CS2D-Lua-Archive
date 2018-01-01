--------------------------------------
-- Pickupable Dropped Satchel Charge
-- Script by ZxC (#99488)
-- Date: 18 - 06 - 2017
--------------------------------------

--------------------------------------
-- Config
--------------------------------------

-- This setting is for whether output the messages or not. Change it to 'false' if you don't want them to be displayed
MsgDisplay = true

-- These are for Alert messages (highlighted in red colour)
MsgNoRemote = '\169240128128[SERVER]: You must have a remote control first!'
MsgFullAmmo = '\169240128128[SERVER]: You can\'t carry any more of these Satchel Charges!'

-- This is the general setting for default message (once a user picks up a satchel charge)
MsgPickCharge = '\169255255255[SERVER]: You have picked the Satchel Charge!'

--------------------------------------
-- Engine & Setup
--------------------------------------

local SatchelCharge = {}

function SatchelChargeGetonUse(id)
  for key, value in pairs( projectilelist(1) ) do

    local Projtype = projectile(value.id, value.player, 'type')
    local ProjX = projectile(value.id, value.player, 'x')
    local ProjY = projectile(value.id, value.player, 'y')
    local PlX = player(id, 'x')
    local PlY = player(id, 'y')

    if ( Projtype == 89 ) then
      if ( PlX >= ProjX - 16 and PlY >= ProjY - 16 and PlX <= ProjX + 16 and PlY <= ProjY + 16 ) then
        if ( player(id, 'weapontype') == Projtype ) then
          SatchelCharge[id] = {value.id, value.player}
          parse('items')
        else
          if ( MsgDisplay ) then
            msg2(id, MsgNoRemote)
          else
          -- Do nothing (don't output the message!)
          end
        end
      end
    end
  end
end

function SatchelAmmoCount(text)
  if ( text:sub(1, 20) == 'Tpl.weapon: #0, pl: ' ) then

    local id, Ammo = text:sub(21, #text):match( '(.+), typ: .+ .+, a: (.+)|.+, m: .+' )

    id, Ammo = tonumber(id), tonumber(Ammo)

    if ( SatchelCharge[id] ) then
      if ( Ammo < 5 ) then
        parse('freeprojectile ' .. SatchelCharge[id][1] .. ' ' .. SatchelCharge[id][2])
        parse('setammo ' .. id .. ' 89 ' .. ( Ammo + 1 ))
        if ( MsgDisplay ) then
          msg2(id, MsgPickCharge)
        else
          -- Do nothing (don't output the message!)
        end
      else
        if ( MsgDisplay ) then
          msg2(id, MsgFullAmmo)
        else
          -- Do nothing (don't output the message!)
        end
      end
      SatchelCharge[id] = nil
    end
    return 1
  end
end

--------------------------------------
-- Hooks
--------------------------------------

addhook('use', 'SatchelChargeGetonUse')
addhook('log', 'SatchelAmmoCount')
