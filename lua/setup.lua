-- load classes
dofile(ModPath .. "lua/WaypointManager.lua")
dofile(ModPath .. "lua/CustomWaypoint.lua")

local init_managers_original = Setup.init_managers

function Setup:init_managers(managers, ...)
    init_managers_original(self, managers, ...)
    managers.waypoints = managers.waypoints or WaypointManager:new()
end
