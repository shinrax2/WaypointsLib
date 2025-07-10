local init_original = HUDManager.init
local update_original = HUDManager.update

function HUDManager:init(...)
	init_original(self, ...)
	managers.waypoints:_check_pending_waypoints()
end

function HUDManager:update(t, dt, ...)
	managers.waypoints:update(t, dt)
	return update_original(self, t, dt, ...)
end
