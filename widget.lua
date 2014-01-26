-- Copyright 2014 Felix Mulder
-- Based off of mokasin's Awesome Pulseaudio Widget
-- This file is part of the Awesome Pulseaudio Widget Text (APWT).
-- 
-- APWT is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- APWT is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with APWT. If not, see <http://www.gnu.org/licenses/>.

-- Configuration variables
local step  = 0.02          -- stepsize for volume change (from 0 to 1)
local mixer = 'pavucontrol' -- mixer command

-- End of configuration

local awful = require("awful")
local wibox = require("wibox")
local pulseaudio = require("apwt.pulseaudio")

local p = pulseaudio:Create()


local pulseWidget = wibox.widget.textbox()
pulseWidget:set_align("right")

local function _update()
  local vol = math.floor(p.Volume * 100 + 0.5)
	if p.Mute then
    pulseWidget:set_markup(vol .. "M")
	else
    pulseWidget:set_markup(vol .. "%")
	end
end

function pulseWidget.SetMixer(command)
	mixer = command
end

function pulseWidget.Up()
	p:SetVolume(p.Volume + step)
	_update()
end	

function pulseWidget.Down()
	p:SetVolume(p.Volume - step)
	_update()
end	


function pulseWidget.ToggleMute()
	p:ToggleMute()
	_update()
end

function pulseWidget.Update()
	p:UpdateState()
	 _update()
end

function pulseWidget.LaunchMixer()
	awful.util.spawn_with_shell( mixer )
end


-- register mouse button actions
pulseWidget:buttons(awful.util.table.join(
		awful.button({ }, 1, pulseWidget.ToggleMute),
		awful.button({ }, 3, pulseWidget.LaunchMixer),
		awful.button({ }, 4, pulseWidget.Up),
		awful.button({ }, 5, pulseWidget.Down)
	)
)


-- initialize
_update()

return pulseWidget
