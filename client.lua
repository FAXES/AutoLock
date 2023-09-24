--------------------------------
--- Auto Lock, Made by FAXES ---
--------------------------------
local dict = "anim@mp_player_intmenu@key_fob@"
RequestAnimDict(dict)
while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        local vehLast = GetVehiclePedIsIn(ped, true)
        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
        local vehLockStat = GetVehicleDoorLockStatus(vehLast)

        if GetVehicleClass(vehLast) == 18 and GetLastPedInVehicleSeat(vehLast, -1) == ped and GetVehicleDoorAngleRatio(vehLast, 0) <= 0 and GetVehicleDoorAngleRatio(vehLast, 1) <= 0 then
            if distanceToVeh <= 5 then
                if vehLockStat == 2 then
                    TaskPlayAnim(ped, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

                    SetVehicleDoorsLocked(vehLast, 0)
                    SetVehicleDoorsLockedForAllPlayers(vehLast, false)
                    ShowInfo("Your patrol car is unlocked.")
                end
            else
                if vehLockStat == 1 or vehLockStat == 0 then
                    TaskPlayAnim(ped, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

                    SetVehicleDoorsLocked(vehLast, 2)
                    SetVehicleDoorsLockedForAllPlayers(vehLast, true)
                    ShowInfo("Your patrol car is locked.")
                end
            end
        end
    end
end)

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
