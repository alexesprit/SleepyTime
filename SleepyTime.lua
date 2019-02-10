local MESSAGE_1 =
'It takes the average human %d minutes to fall\
asleep. If you head to bed right now, you should\
try to wake up at one of the following times:'
local MESSAGE_2 = 'A good night\'s sleep consists of 5-6 sleep cycles.'

local CYCLES_ENDS_COUNT = 6
local CYCLE_DURATION = 90
local FALL_ASLEEP_DURATION = 14

local FALL_ASLEEP_DURATION_VAR = 'FallAsleepDuration'
local CYCLE_DURATION_VAR = 'CycleDuration'
local SIMPLE_MODE_VAR = 'SimpleMode'

local function calculateCyclesEnds(fallAsleepDuration, cycleDuration)
    local cyclesEndsArray = {0, 0, 0, 0, 0, 0}
    local fallAsleepTime = os.time() + fallAsleepDuration * 60

    for i = 1, CYCLES_ENDS_COUNT do
        wakeUpTime = fallAsleepTime + i * cycleDuration * 60
        cyclesEndsArray[i] = os.date('%H:%M', wakeUpTime)
    end

    return cyclesEndsArray
end

local function setStringMeterText(meterName, text)
    SKIN:Bang('!SetOption', meterName, 'Text', text)
end

function Update()
    local fallAsleepDuration = SKIN:GetVariable(
        FALL_ASLEEP_DURATION_VAR,
        FALL_ASLEEP_DURATION
    )
    local cycleDuration = SKIN:GetVariable(CYCLE_DURATION_VAR, CYCLE_DURATION)

    local cyclesEndsArray = calculateCyclesEnds(fallAsleepDuration, cycleDuration)
    local cyclesEndsText = table.concat(cyclesEndsArray, ' or ')

    local isSimpleMode = SKIN:GetVariable(SIMPLE_MODE_VAR, 'False')
    if isSimpleMode == 'False' then
        setStringMeterText("Desc1String", string.format(MESSAGE_1, fallAsleepDuration))
        setStringMeterText("Desc2String", MESSAGE_2)
    elseif isSimpleMode == 'True' then
        setStringMeterText("Desc1String", "")
        setStringMeterText("Desc2String", "")
    end

    setStringMeterText("MainString", cyclesEndsText)
end
