--[Onyx] Auto Accept by OurmineOGTv#6846

local function AutoAcceptFunction()
	panorama.RunScript([[
    	function autoaccept() {
        	$.Schedule(1, autoaccept)

       	if (!LobbyAPI.IsSessionActive() || LobbyAPI.GetReadyTimeRemainingSeconds() == 0) {
           	 return;
        	}

        	LobbyAPI.SetLocalPlayerReady('accept');
    	}

    	autoaccept();
	]])
end

local AutoAccept = gui.Checkbox(gui.Reference("Misc", "Enhancement","Appearance"), "misc.auto.accept", "Auto Accept", false);

function check()
	if  AutoAccept:GetValue() == false then
		print("Auto accept: OFF")
	elseif AutoAccept:GetValue() == true then
		print("Auto accept: ON")
		AutoAcceptFunction();
	end
end
check()

local t = gui.Button(gui.Reference("Misc", "Enhancement","Appearance"), "Auto Accept Refresh", check) 
