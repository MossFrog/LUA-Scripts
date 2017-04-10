function Script:Start()
	self.camPivot = Pivot:Create()
	self.camPivot:SetPosition(self.entity:GetPosition(true))

	self.mouseLight = PointLight:Create()
	self.mouseLight:SetRange(6)
	self.mouseLight:SetColor(255,0,150)


    self.pickradius = 0.5 

end



function Script:UpdateWorld()
	 local Win = Window:GetCurrent()
	 -- Forwards
	 if Win:KeyDown(Key.W) then
		self.camPivot:Move(0,0,1)
	 end
	 
	 -- Backwards
	 if Win:KeyDown(Key.S) then
		self.camPivot:Move(0,0,-1)
	 end

	 -- Left
	 if Win:KeyDown(Key.A) then
		self.camPivot:Move(-1,0,0)
	 end
	 
	 -- Right
	 if Win:KeyDown(Key.D) then
		self.camPivot:Move(1,0,0)
	 end

	-- Zoom in and Out
	if Win:KeyDown(Key.Q) then
		self.camPivot:Move(0,1,0)
	end
	
	if Win:KeyDown(Key.E) then
		self.camPivot:Move(0,-1,0)
	end
	
	-- Boundary limitations
	if self.camPivot:GetPosition(true).z > 100 then
		self.camPivot:SetPosition(self.camPivot:GetPosition(true).x, self.camPivot:GetPosition(true).y, 100)
	end

	if self.camPivot:GetPosition(true).z < -120 then
		self.camPivot:SetPosition(self.camPivot:GetPosition(true).x, self.camPivot:GetPosition(true).y, -120)
	end


	-- Boundary limitations
	if self.camPivot:GetPosition(true).x > 150 then
		self.camPivot:SetPosition(150, self.camPivot:GetPosition(true).y, self.camPivot:GetPosition(true).z)
	end

	if self.camPivot:GetPosition(true).x < -150 then
		self.camPivot:SetPosition(-150, self.camPivot:GetPosition(true).y, self.camPivot:GetPosition(true).z)
	end
	
	local pickinfo = PickInfo() 
    if (self.entity:Pick(Win:GetMousePosition().x,Win:GetMousePosition().y,pickinfo,self.pickradius,true)) then
        
        self.mouseLight:SetPosition(pickinfo.position + Vec3(0,3,0))
	end
	
	
	 self.entity:SetPosition(self.camPivot:GetPosition(true))
end


--[[
function Script:UpdatePhysics()
	
end
]]

--[[
--This can be used to select which objects an entity collides with.  This overrides collision types completely.
function Script:Overlap(e)
	return Collision:Collide
end
]]

--[[
function Script:Collision(entity, position, normal, speed)
	
end
]]

--[[
function Script:Draw()
	
end
]]

--[[
function Script:DrawEach(camera)
	
end
]]

--[[
--This function will be called after the world is rendered, before the screen is refreshed.
--Use this to perform any 2D drawing you want the entity to display.
function Script:PostRender(context)
	
end
]]

--[[
--This function will be called when the entity is deleted.
function Script:Detach()
	
end
]]

--[[
--This function will be called when the last instance of this script is deleted.
function Script:Cleanup()
	
end
]]