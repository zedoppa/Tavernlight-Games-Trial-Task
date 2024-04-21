-- Question 1 - Fix or improve the implementation of the below methods

-- use onLogin instead of onLogout to reset player storage values because it will not work in onLogout function
function onLogin(player)
    if player:getStorageValue(1000) == 1 then
        -- directly set storage value to -1 instead of using addEvent method and extra functions
        player:setStorageValue(1000, -1)
    end
    return true
end