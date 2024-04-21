-- Question 2 - Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.getResult(string.format(selectGuildQuery, memberCount))

    -- use table variable instead of string variable because the result could be more than one row
    local guildName = {}

    -- put a checking to print the guild names only when the result is not nil
    if resultId then

        -- assign the result in guildName table using loop
        repeat
            guildName[#guildName + 1] = result.getString(resultId, "name")
        until not result.next(resultId)

        -- empty the result after used to avoid data being cached
        result.free(resultId)

        -- print all the guild names if guildName table length is more than 0
        if #guildName > 0 then
            for _, v in pairs(guildName) do
                print(v)
            end
        end
    end
end