-- load classes
dofile("mods/WaypointsLib/lua/WaypointManager.lua")
dofile("mods/WaypointsLib/lua/CustomWaypoint.lua")

local init_managers_original = Setup.init_managers

function Setup:init_managers(managers, ...)
    init_managers_original(self, managers, ...)
    managers.waypoints = managers.waypoints or WaypointManager:new()
end



