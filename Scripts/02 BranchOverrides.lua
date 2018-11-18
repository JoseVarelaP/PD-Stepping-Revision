Branch.TitleMenu = function() return "Diva_TitleMenu" end
Branch.AfterProfileLoad = function()
    if DIVA:CharactersAllowedToSelect() then
        -- If we find any kind of characters, load the selector.
        return "ScreenDivaSelectCharacter"
    end
    -- Otherwise, go to the playmode selector.
    return "ScreenSelectPlayMode"
end