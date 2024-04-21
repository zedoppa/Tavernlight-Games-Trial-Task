-- Question 3 - Fix or improve the name and the implementation of the below method

function removePartyMember(playerId, membername)
    -- change the global variable to local because it's only used within the function
    local player = Player(playerId)
    local party = player:getParty()

    -- get the player one time in a local variable instead of everytime in the loop to increase performance
    local playerToRemove = Player(membername)

    -- assign party:getMembers() in a variable to make code much cleaner and readable
    local members = party:getMembers()

    for _,v in pairs(members) do
        if v == playerToRemove then
            party:removeMember(playerToRemove)

            -- break the loop if member is already removed
            break
        end
    end
end