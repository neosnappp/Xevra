if getgenv().xevra then
	error('xevra is already running !')
end
getgenv().xevra = true

local BASE = "https://raw.githubusercontent.com/KULLANICI/xevra/main"

local gameScripts = {
	[606849621] = BASE .. "/hub-jailbreak.lua",
}

local ICON = "rbxassetid://0000000000"

local function notify(title, text, duration)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = duration or 5,
		})
	end)
end

local scriptUrl = gameScripts[game.PlaceId]

if not scriptUrl then
	getgenv().xevra = false
	notify("Xevra", "Game not supported!")
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
	notify("Xevra", "Failed to load: " .. tostring(fetchErr), 6)
	return
end

notify("Xevra", "Hub loaded", 3)
