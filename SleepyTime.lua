local MESSAGE =
'It takes the average human %d minutes to fall\
asleep. If you head to bed right now, you should\
try to wake up at one of the following times:\
%s. \
A good night\'s sleep consists of 5-6 sleep cycles.'

local CYCLES_ENDS_COUNT = 6
local CYCLE_DURATION = 90
local FALL_ASLEEP_DURATION = 14

local FALL_ASLEEP_DURATION_VAR = 'FallAsleepDuration'
local CYCLE_DURATION_VAR = 'CycleDuration'
local SIMPLE_MODE_VAR = 'SimpleMode'

local function calculateCyclesEnds(fallAsleepDuration, cycleDuration)
    cyclesEndsArray = {0, 0, 0, 0, 0, 0}
    fallAsleepTime = os.time() + fallAsleepDuration * 60

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
    fallAsleepDuration = SKIN:GetVariable(
        FALL_ASLEEP_DURATION_VAR,
        FALL_ASLEEP_DURATION
    )
    cycleDuration = SKIN:GetVariable(CYCLE_DURATION_VAR, CYCLE_DURATION)

    cyclesEndsArray = calculateCyclesEnds(fallAsleepDuration, cycleDuration)
    cyclesEndsText = table.concat(cyclesEndsArray, ' or ')

    simpleMode = SKIN:GetVariable(SIMPLE_MODE_VAR, 'False')
    if simpleMode == 'False' then
        messageText = string.format(MESSAGE, fallAsleepDuration, cyclesEndsText)
        setStringMeterText("MainString", messageText)
    elseif simpleMode == 'True' then
        setStringMeterText("MainString", cyclesEndsText)
    end
end
