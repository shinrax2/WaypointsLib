Hooks:PostHook(CoreWorldCollection, "level_transition_cleanup",
    "WaypointsLib_CoreWorldCollection_level_transition_cleanup",
    function(self)
        if managers.waypoints then
            managers.waypoints:clear_waypoints()
        end
    end
)
