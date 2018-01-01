yates.plugin['Country_Location']['title'] = 'Player\'s Country Info'
yates.plugin['Country_Location']['author'] = 'ZxC'
yates.plugin['Country_Location']['usgn'] = '99488'
yates.plugin['Country_Location']['version'] = '1.0'
yates.plugin['Country_Location']['description'] = 'Detects and displays player\'s country during joining or leaving the server'

dofileLua(yates.plugin['Country_Location']['dir'] .. 'actions.lua')
