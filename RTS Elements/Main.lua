--Initialize Steamworks (optional)
Steamworks:Initialize()

--Initialize analytics (optional).  Create an account at www.gameamalytics.com to get your game keys
--[[if DEBUG==false then
	Analytics:SetKeys("GAME_KEY_xxxxxxxxx", "SECRET_KEY_xxxxxxxxx")
	Analytics:Enable()
end]]

--Set the application title
title="Workspace"

--Create a window
local windowstyle = Window.Titlebar
windowstyle=windowstyle+Window.FullScreen
window=Window:Create(title,0,0,System:GetProperty("screenwidth","1366"),System:GetProperty("screenheight","768"),windowstyle)

--Create the graphics context
context=Context:Create(window,0)
if context==nil then return end

--Create a world
world=World:Create()
world:SetLightQuality((System:GetProperty("lightquality","2")))

--Load a map
local mapfile = System:GetProperty("map","Maps/RTSTest.map")
if Map:Load(mapfile)==false then return end
prevmapname = FileSystem:StripAll(changemapname)

--Send analytics event
Analytics:SendProgressEvent("Start",prevmapname)

while window:KeyDown(Key.Escape)==false do
	
	--If window has been closed, end the program
	if window:Closed() then break end
	
	--Handle map change
	if changemapname~=nil then
		
		--Pause the clock
		Time:Pause()
		
		--Pause garbage collection
		System:GCSuspend()		
		
		--Clear all entities
		world:Clear()
		
		--Send analytics event
		Analytics:SendProgressEvent("Complete",prevmapname)
		
		--Load the next map
		if Map:Load("Maps/"..changemapname..".map")==false then return end
		prevmapname = changemapname
		
		--Send analytics event
		Analytics:SendProgressEvent("Start",prevmapname)
		
		--Resume garbage collection
		System:GCResume()
		
		--Resume the clock
		Time:Resume()
		
		changemapname = nil
	end	
	
	--Update the app timing
	Time:Update()
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render()
		
	--Render statistics
	context:SetBlendMode(Blend.Alpha)
	if DEBUG then
		context:SetColor(1,0,0,1)
		context:DrawText("Debug Mode",2,2)
		context:SetColor(1,1,1,1)
		context:DrawStats(2,22)
		context:SetBlendMode(Blend.Solid)
	else
		--Toggle statistics on and off
		if (window:KeyHit(Key.F11)) then showstats = not showstats end
		if showstats then
			context:SetColor(1,1,1,1)
			context:DrawText("FPS: "..Math:Round(Time:UPS()),2,2)
		end
	end
	
	--Refresh the screen
	context:Sync(true)
	
end