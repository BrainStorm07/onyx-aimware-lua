--[Onyx] Auto Queue/Reconnect.lua by OurmineOGTv#6846
--Unofficial AIMWARE Discord Server: https://discord.com/invite/5eH69PF

--[Onyx] GUI
local OnyxRef = gui.Reference("Misc", "General", "Extra");
local OnyxAutoFinder = gui.Checkbox(OnyxRef, "onyx.auto.finder", "Auto Game Finder", false)
local OnyxAutoReconnect = gui.Checkbox(OnyxRef, "onyx.auto.reconnect", "Auto Reconnect", false)

--[Onyx] Description
OnyxAutoFinder:SetDescription("Auto find game with current settings.");
OnyxAutoReconnect:SetDescription("Auto reconnect if posibble to last match.");

--[Onyx] Define Auto Finder
local function autoFinder()
    panorama.RunScript([[
        if (!LobbyAPI.IsSessionActive()) {
            LobbyAPI.CreateSession();
        } else {
            var mmStat = LobbyAPI.GetMatchmakingStatusString();
            var pref = "#SFUI_QMM_State_find_"
            if (mmStat == pref + "registering" || mmStat == pref + "heartbeating" || mmStat == pref + "searching" || mmStat == pref + "reserved" || mmStat == pref + "connect") {
            } else {
                LobbyAPI.StartMatchmaking("", "", "", "");
            }
        }
    ]])
end
callbacks.Register("Draw", "AutoFinderToggle", function() if OnyxAutoFinder:GetValue() then autoFinder(); end end)

--[Onyx] Define Auto Reconnect
local function autoReconnect()
    if OnyxAutoReconnect:GetValue() then
        panorama.RunScript([[
            var ongoingMM = CompetitiveMatchAPI.HasOngoingMatch();
            if (ongoingMM == false) {
                CompetitiveMatchAPI.ActionReconnectToOngoingMatch();
            }
        ]])
    end
end
callbacks.Register("Draw", "AutoReconnectToggle", function() if OnyxAutoReconnect:GetValue() then autoReconnect(); end end)
