--------------------------------
--- Auto Lock, Made by FAXES ---
--------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = GetPlayerPed(PlayerId())
        local vehLast = GetVehiclePedIsIn(ped, true)
        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
        local vehLockStat = GetVehicleDoorLockStatus(vehLast)

        if GetVehicleClass(vehLast) == 18 and GetLastPedInVehicleSeat(vehLast, -1) == ped and GetVehicleDoorAngleRatio(vehLast, 0) <= 0 and GetVehicleDoorAngleRatio(vehLast, 1) <= 0 then
            if distanceToVeh <= 5 then
                if vehLockStat == 2 then
                    SetVehicleDoorsLocked(vehLast, 0)
                    SetVehicleDoorsLockedForAllPlayers(vehLast, false)
                    ShowInfo("Your patrol car is unlocked.")
                end
            else
                if vehLockStat == 1 or vehLockStat == 0 then
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