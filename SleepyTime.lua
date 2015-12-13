local MESSAGE = 
'It takes the average human %d minutes to fall\
asleep. If you head to bed right now, you should\
try to wake up at one of the following times:\
%s. \
A good night\'s sleep consists of 5-6 sleep cycles.'

local CYCLES_ENDS_COUNT = 6
local CYCLE_DURATION = 90
local FALL_ASLEEP_DURATION = 14

local function calculateCyclesEnds()
    cyclesEndsArray = {0, 0, 0, 0, 0, 0}
    fallAsleepTime = os.time() + FALL_ASLEEP_DURATION * 60
    
    for i = 1, CYCLES_ENDS_COUNT do
        wakeUpTime = fallAsleepTime + i * CYCLE_DURATION * 60
        cyclesEndsArray[i] = os.date('%H:%M', wakeUpTime)
    end

    return cyclesEndsArray
end

local function setStringMeterText(meterName, text)
    SKIN:Bang('!SetOption', meterName, 'Text', text)
end

function Update()
    cyclesEndsArray = calculateCyclesEnds()
    cyclesEndsText = table.concat(cyclesEndsArray, ' or ')
    messageText = string.format(MESSAGE, FALL_ASLEEP_DURATION, cyclesEndsText)
    setStringMeterText("MainString", messageText)
end
