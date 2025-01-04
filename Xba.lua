local replicated_storage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local teams = game:GetService("Teams")
local user_input_service = game:GetService("UserInputService")
local run_service = game:GetService("RunService")
local player = players.LocalPlayer
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local window = library:MakeWindow({
    Name = "Batuş Hub - Blue Lock: Rivals",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "batuşhub"
})

local camera = workspace.CurrentCamera
local lock_ball = false
local away_coords = Vector3.new(-232.98773193359375, 11.166533470153809, -64.32842254638672)
local home_coords = Vector3.new(310.09368896484375, 11.166532516479492, -35.67409133911133)
local default_shoot_power = 700
local shoot_power = default_shoot_power

local cursor_image = "rbxassetid://7072729817"
local cursor = Instance.new("ImageLabel")
cursor.Image = cursor_image
cursor.Size = UDim2.new(0, 32, 0, 32)
cursor.BackgroundTransparency = 1
cursor.Visible = false
cursor.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function find_ball()
    local football = workspace:FindFirstChild("Football")
    if football then
        return football:FindFirstChild("BallAnims"):FindFirstChild("BALL") or football:FindFirstChild("BALL")
    end
    return nil
end

local ball = find_ball()

run_service.RenderStepped:Connect(function()
    if user_input_service.MouseEnabled or user_input_service.TouchEnabled then
        local position = user_input_service:GetMouseLocation()
        cursor.Position = UDim2.new(0, position.X, 0, position.Y)
        cursor.Visible = true
    else
        cursor.Visible = false
    end
end)

local function lockb()
    while lock_ball do
        ball = find_ball()
        if ball then
            local ball_position = ball.Position
            local camera_position = camera.CFrame.Position
            local smooth_speed = 0.2
            local camera_offset = Vector3.new(0, 5, -10)
            local target_position = ball_position + camera_offset
            local cla = ball_position
            local ncp = camera.CFrame.Position:Lerp(target_position, smooth_speed)
            camera.CFrame = CFrame.new(ncp, cla)
        end
        task.wait(0.1)
    end
end

local function shoot_ball()
    ball = find_ball()
    if ball then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid_root_part = character:WaitForChild("HumanoidRootPart")
        local team = player.Team
        local target_coords = (team == teams:FindFirstChild("Home")) and home_coords or away_coords
        local direction = (target_coords - ball.Position).unit
        local body_velocity = ball:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity")
        body_velocity.MaxForce = Vector3.new(100000, 100000, 100000)
        body_velocity.Velocity = direction * shoot_power
        body_velocity.Parent = ball
    end
end

local function set_style(desired_style)
    if player:FindFirstChild("PlayerStats") then
        local playerStats = player.PlayerStats
        if playerStats:FindFirstChild("Style") then
            playerStats.Style.Value = desired_style
        end
    end
end

local function set_flow(desired_flow)
    if player:FindFirstChild("PlayerStats") then
        local playerStats = player.PlayerStats
        if playerStats:FindFirstChild("Flow") then
            playerStats.Flow.Value = desired_flow
        end
    end
end

local main_tab = window:MakeTab({ Name = "Main", Icon = "rbxassetid://4483345998" })
main_tab:AddSection({ Name = "Main" })
main_tab:AddToggle({
    Name = "Auto Farm",
    Callback = function()
    
    end
})
main_tab:AddButton({
    Name = "Toggle Ball Lock",
    Callback = function()
        lock_ball = not lock_ball
        if lock_ball then
            task.spawn(lockb)
        end
    end
})
main_tab:AddButton({
	Name = "Inf Stamina",
	Callback = function()
      		local args = {
    [1] = 0/0
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StaminaService"):WaitForChild("RE"):WaitForChild("DecreaseStamina"):FireServer(unpack(args))

  	end    
})

local flow_tab = window:MakeTab({ Name = "Flow", Icon = "rbxassetid://4483345998" })
flow_tab:AddSection({ Name = "! USE THIS FEATURE AT YOUR OWN RISK !" })
flow_tab:AddButton({
	Name = "Flow Gui",
	Callback = function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/BatusBey/Flow/refs/heads/main/Flow"))() 
    end
})

local misc_tab = window:MakeTab({ Name = "Misc", Icon = "rbxassetid://4483345998" })
misc_tab:AddSection({ Name = "Misc" })
misc_tab:AddLabel("Coming Soon...")

local notes_tab = window:MakeTab({ Name = "Info", Icon = "rbxassetid://4483345998" })
notes_tab:AddSection({ Name = "Info" })
notes_tab:AddLabel("Status : WORKING 🟢")
notes_tab:AddLabel("Guis by : mrkayra.exe")
notes_tab:AddLabel("Scripted by : xbatuhan2, mrkayra.exe")
notes_tab:AddLabel("Auto Farm by : Touka")

local credits_tab = window:MakeTab({ Name = "Credits", Icon = "rbxassetid://4483345998" })
credits_tab:AddSection({ Name = "Credits" })
credits_tab:AddLabel("Owner, Head Scripter : xbatuhan2")
credits_tab:AddLabel("Co-Owner, Scripter, Gui Designer: mrkayra.exe")
credits_tab:AddLabel("Bug Fixer : Touka")
credits_tab:AddLabel("Join our server : discord.gg/vBXTpqX4rY")
credits_tab:AddLabel("Join Touka's server : https://discord.gg/ZMqzMFQfy5")

library:Init()
