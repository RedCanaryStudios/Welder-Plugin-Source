local toolbar = plugin:CreateToolbar("Weld")
local selection = game:GetService("Selection")

local Weld = toolbar:CreateButton("Weld All", "Weld all parts", "rbxassetid://4458901886")
local destroyWelds = toolbar:CreateButton("Destroy Welds", "Destroys all welds", "rbxassetid://4458901886")

local weld 
    
weld = function(sel)
    sel = sel or selection:Get()
    
    if #sel == 0 then return end
    
    if sel[1]:IsA("Model") then
        weld(sel[1]:GetChildren())
    end

    for i = #sel-1, 1, -1 do

        if sel[i]:IsA("BasePart") then
            local WC = Instance.new("WeldConstraint")

            WC.Parent = sel[i]
            WC.Part0 = sel[i+1]
            WC.Part1 = sel[i]
        else
            if sel[i]:IsA("Model") then
                weld(sel[i]:GetChildren())
            end
            table.remove(sel, i)
        end
    end

    Weld:SetActive(false)
end

Weld.Click:Connect(weld)

destroyWelds.Click:Connect(function()
    local sel = selection:Get()
    
    for i, v in ipairs(sel) do
        for i2, v2 in ipairs(v:GetDescendants()) do
            if v2:IsA("Weld") or v2:IsA("WeldConstraint") then
                v2:Destroy()
            end
        end
    end
end)
