// Question 4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);

    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);

    if (!item) {
        return;
    }

    // Assign internalAddItem method into ReturnValue variable to delete the item variable if the ReturnValue variable returns error
    // and stop the function from continue onwards if error occurs
    ReturnValue ret = g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (ret != RET_NOERROR)
    {
        delete item;
        return;
    }

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}