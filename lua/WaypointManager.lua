WaypointManager = WaypointManager or class()

function WaypointManager:init()
    self._workspace = managers.gui_data and managers.gui_data:create_fullscreen_workspace()
    self._waypoints = {}
    self._pending_waypoints = {}
end

function WaypointManager:_check_pending_waypoints()
    for id, data in pairs(self._pending_waypoints) do
        self:add_waypoint(id, data.class, data.data, data.overwrite)
    end

    self._pending_waypoints = {}
end

function WaypointManager:update(t, dt)
    local cam = managers.viewport:get_current_camera()

    if alive(self._hud_panel) and alive(self._workspace) and cam then
        local cam_forward = Vector3()

        mrotation.y(managers.viewport:get_current_camera_rotation(), cam_forward)

        for id, wp in pairs(self._waypoints) do
            if wp:is_deleted() then
                wp:_clear()
                self._waypoints[id] = nil
            else
                wp:update(t, dt, cam, cam_forward, self._hud_panel, self._workspace)
            end

        end
    end
    self:_check_pending_waypoints()
end

function WaypointManager:add_waypoint(id, class, data, overwrite)
    self._hud_panel = self._hud_panel or managers.hud and managers.hud:script(PlayerBase.INGAME_HUD_FULLSCREEN) and managers.hud:script(PlayerBase.INGAME_HUD_FULLSCREEN).panel

    if not self._hud_panel then
        self._pending_waypoints[id] = {class = class, data = data, overwrite = overwrite}
    elseif overwrite and self._waypoints[id] then
        self._waypoints[id]:delete()
        self._pending_waypoints[id] = {class = class, data = data, overwrite = overwrite}
    elseif not self._waypoints[id] then
        local item_class = type(class) == "string" and _G[class] or class
        self._waypoints[id] = item_class and item_class:new(id, self._hud_panel, data)
    end

    return self._waypoints[id]
end

function WaypointManager:remove_waypoint(id)
    if self._pending_waypoints[id] then
        self._pending_waypoints[id] = nil
    elseif self._waypoints[id] then
        self._waypoints[id]:delete()
    end
end

function WaypointManager:clear_waypoints()
    self._pending_waypoints = {}
    for id, wp in pairs(self._waypoints) do
        wp:delete()
    end
end

function WaypointManager:add_waypoint_component(id, name, data, order, overwrite)
    if self._pending_waypoints[id] then
        local pending_data = self._pending_waypoints[id].data
        if not pending_data[name] or overwrite then
            pending_data[name] = data
            if pending_data.component_order and order then
                local i, j = unpack(order)
                pending_data.component_order[i] = pending_data.component_order[i] or {}
                j = math.min(j, #pending_data.component_order[i] + 1)
                table.insert(pending_data.component_order[i], j, name)
            end
            self._pending_waypoints[id].data = pending_data
        end
    elseif self._waypoints[id] then
        self._waypoints[id]:add_component(name, data, order, overwrite)
    end
end

function WaypointManager:remove_waypoint_component(id, name)
    if self._pending_waypoints[id] then
        local pending_data = self._pending_waypoints[id].data
        if pending_data[name] then
            pending_data[name] = nil
            if pending_data.component_order then
                for i, vertical_order in ipairs(pending_data.component_order) do
                    for j, component_name in ipairs(vertical_order) do
                        if name == component_name then
                            table.remove(vertical_order, j)
                            break
                        end
                    end
                end
            end
            self._pending_waypoints[id].data = pending_data
        end
    elseif self._waypoints[id] then
        self._waypoints[id]:remove_component(name)
    end
end

function WaypointManager:set_waypoint_duration(id, name, value)
    if self._waypoints[id] then
        self._waypoints[id]:set_duration(name, value)
    end
end

function WaypointManager:set_waypoint_timer(id, name, value, auto_update)
    if self._waypoints[id] then
        self._waypoints[id]:set_timer(name, value, auto_update)
    end
end

function WaypointManager:set_waypoint_timer_pause(id, name, value)
    if self._waypoints[id] then
        self._waypoints[id]:set_timer_pause(name, value)
    end
end

function WaypointManager:set_waypoint_label(id, name, text)
    if self._waypoints[id] then
        self._waypoints[id]:set_label(name, text)
    end
end

function WaypointManager:set_waypoint_icon(id, name, texture, texture_rect)
    if self._waypoints[id] then
        self._waypoints[id]:set_icon(name, texture, texture_rect)
    end
end

function WaypointManager:set_waypoint_setting(id, setting, value)
    if self._waypoints[id] then
        self._waypoints[id]:set_setting(setting, value)
    end
end

function WaypointManager:set_waypoint_component_setting(id, component, setting, value)
    if self._waypoints[id] then
        self._waypoints[id]:set_component_setting(component, setting, value)
    end
end

function WaypointManager:get_waypoint(id)
    if self._waypoints[id] then
        return self._waypoints[id]
    end
end

function WaypointManager:get_waypoint_component(id, component)
    if self._waypoints[id] then
        return self._waypoints[id]:get_component(component)
    end
end
