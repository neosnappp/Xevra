if getgenv().xevra then
	return
end
getgenv().xevra = true

local BASE = "https://github.com/neosnappp/Xevra/blob/main/loader.lua"

local gameScripts = {
	[606849621] = BASE .. "/hub-jailbreak.lua",
}

local ICON = "rbxassetid://6031094667"

local function notify(title, text, duration)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = title,
			Text = text,
			Icon = ICON,
			Duration = duration or 5,
		})
	end)
end

local scriptUrl = gameScripts[game.PlaceId]

if not scriptUrl then
	getgenv().xevra = false
	notify("xevra", "game not supported")
	return
end

local ok, fetchErr = pcall(function()
	local source = game:HttpGet(scriptUrl)
	if type(source) ~= "string" or #source < 32 then
		error("empty response from " .. scriptUrl)
	end
	assert(loadstring(source, "xevra-hub"))()
end)

if not ok then
	getgenv().xevra = false
	notify("xevra", "failed to load: " .. tostring(fetchErr), 6)
	return
end

notify("xevra", "loaded", 3)
