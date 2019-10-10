function OpenKitchen(property)

    local options = {
        { label = 'Make Food', action = MakeFood },
    }
    
    if not IsUnlocked(property) then
        table.insert(options, { label = 'Lock the house', action = function()
            Trancamento(property, 1)
        end })
    elseif IsUnlocked(property) then
        table.insert(options, { label = 'Unlock the house', action = function()
            Trancamento(property, 2)
        end })
    end
    
    if IsPlayerOwnerOf(property) then
        table.insert(options, { label = 'Manage Property', action = function()
            ShowManageProperty(property)
        end })
    end

    local menu = {
        name = 'kitchen',
        title = 'Kitchen',
        options = options
    }

    TriggerEvent('disc-base:openMenu', menu)
end

function MakeFood()
    TriggerServerEvent('disc-base:givePlayerItem', Config.FoodItem, 1)
end

function Trancamento(property, info)
    ESX.UI.Menu.CloseAll()
	if info == 1 then
		exports['mythic_notify']:DoHudText('error', 'The house has been locked!')
		TriggerServerEvent('disc-property:trancarProperty', property, info)
		TriggerEvent('disc-property:forceUpdatePropertyData')
	else
		exports['mythic_notify']:DoHudText('success', 'The house has been unlocked!')
		TriggerServerEvent('disc-property:trancarProperty', property, info)
		TriggerEvent('disc-property:forceUpdatePropertyData')
	end
end
