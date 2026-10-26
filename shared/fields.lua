-- Handling fields read from a live vehicle with GetVehicleHandlingFloat /
-- GetVehicleHandlingInt / GetVehicleHandlingVector on class CHandlingData.
-- Names must match the game's field names exactly (case-sensitive).
HandlingFields = {
    floats = {
        'fMass', 'fInitialDragCoeff', 'fDownforceModifier', 'fPercentSubmerged',
        'fDriveBiasFront', 'fInitialDriveForce', 'fDriveInertia',
        'fClutchChangeRateScaleUpShift', 'fClutchChangeRateScaleDownShift',
        'fInitialDriveMaxFlatVel', 'fBrakeForce', 'fBrakeBiasFront', 'fHandBrakeForce',
        'fSteeringLock', 'fTractionCurveMax', 'fTractionCurveMin', 'fTractionCurveLateral',
        'fTractionSpringDeltaMax', 'fLowSpeedTractionLossMult', 'fCamberStiffnesss',
        'fTractionBiasFront', 'fTractionLossMult', 'fSuspensionForce', 'fSuspensionCompDamp',
        'fSuspensionReboundDamp', 'fSuspensionUpperLimit', 'fSuspensionLowerLimit',
        'fSuspensionRaise', 'fSuspensionBiasFront', 'fAntiRollBarForce', 'fAntiRollBarBiasFront',
        'fRollCentreHeightFront', 'fRollCentreHeightRear', 'fCollisionDamageMult',
        'fWeaponDamageMult', 'fDeformationDamageMult', 'fEngineDamageMult',
        'fPetrolTankVolume', 'fOilVolume', 'fSeatOffsetDistX', 'fSeatOffsetDistY',
        'fSeatOffsetDistZ',
    },
    ints = { 'nInitialDriveGears', 'nMonetaryValue' },
    vectors = { 'vecCentreOfMassOffset', 'vecInertiaMultiplier' },
}

-- Split a list into chunks of n (pure; used by the client to batch uploads).
function HandlingFields.chunk(list, n)
    local out, cur = {}, {}
    for i = 1, #list do
        cur[#cur + 1] = list[i]
        if #cur == n then out[#out + 1] = cur; cur = {} end
    end
    if #cur > 0 then out[#out + 1] = cur end
    return out
end

-- Build one vehicle record from reader callbacks (pure apart from the callbacks,
-- so the client passes the natives and the tests pass stubs).
function HandlingFields.readRecord(readFloat, readInt, readVector)
    local rec = {}
    for _, f in ipairs(HandlingFields.floats) do rec[f] = readFloat(f) end
    for _, f in ipairs(HandlingFields.ints) do rec[f] = readInt(f) end
    for _, f in ipairs(HandlingFields.vectors) do
        local v = readVector(f)
        rec[f] = v and { v.x, v.y, v.z } or nil
    end
    return rec
end
