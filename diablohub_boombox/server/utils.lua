function hasPermissions(xPlayer)
    local playerGroup = xPlayer.getGroup()
    if playerGroup == "best" then
        return true
    end
	return false
end