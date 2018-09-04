--[[
  NAME: reactorMonitor.lua
  PATH: $HOME
  DESC: Monitors a Big Reactors reactor and displays information on a monitor
  CALL: Called from another script or from the command line
  DATE: 2018-September-04
  AUTH: WTMike24
  NOTE: 4 wide 3 tall monitor to the left, single monitor on top, and wired modem on right (change reactor name below)
  ]]

term.clear()

halt = 0
load = 0
controlRod = 0
text = colors.blue

reactor = peripheral.wrap("BigReactors-Reactor_2")
screen = peripheral.wrap("left")
panel = peripheral.wrap("top")
rednet.open("back")

function reactorMonitor()
  while true do
    screen.setBackgroundColor(colors.black)
    screen.clear()
  --PERCENTAGES
    fuelP = (reactor.getFuelAmount() / reactor.getFuelAmountMax()) * 100
    wasteP = (reactor.getWasteAmount() / reactor.getFuelAmountMax()) * 100
    powerP = (reactor.getEnergyStored() / 10000000) * 100
    fuelTime = (reactor.getFuelAmount() / reactor.getFuelConsumedLastTick()) / 1200
  --TEXT COLOR
    if reactor.getActive() then
      text = colors.green
    else
      text = colors.red
    end
  --TITLE
    screen.setBackgroundColor(colors.black)
    screen.setTextColor(colors.yellow)
    screen.setCursorPos(1,1)
    screen.write("Reactor 1")
    screen.setCursorPos(1,2)
    screen.write("---------")
  --STATUS
    screen.setCursorPos(1,3)
    screen.setTextColor(colors.orange)
    screen.write("Current status: ")
    screen.setTextColor(text)
    screen.setCursorPos(17,3)
    if reactor.getActive() then
      screen.write("Active")
    else
      screen.write("Inactive")
    end
  --OUTPUT
    screen.setTextColor(colors.orange)
    screen.setCursorPos(1,4)
    screen.write("Power Output: ")
    screen.setTextColor(text)
    screen.setCursorPos(15,4)
    screen.write(math.floor(reactor.getEnergyProducedLastTick()).." RF/t")
  --STORED
    screen.setTextColor(colors.orange)
    screen.setCursorPos(1,5)
    screen.write("Internal Power: ")
    screen.setTextColor(text)
    screen.setCursorPos(17,5)
    screen.write(reactor.getEnergyStored().." RF ("..math.floor(powerP).."%)")
  --CASE HEAT
    screen.setCursorPos(1,6)
    screen.setTextColor(colors.orange)
    screen.write("Casing Heat: ")
    screen.setCursorPos(14,6)
    screen.setTextColor(text)
    screen.write(math.floor(reactor.getCasingTemperature()).." C")
  --FUEL HEAT
    screen.setCursorPos(1,7)
    screen.setTextColor(colors.orange)
    screen.write("Fuel Heat: ")
    screen.setCursorPos(12,7)
    screen.setTextColor(text)
    screen.write(math.floor(reactor.getFuelTemperature()).." C")
  --FUEL AMOUNT
    screen.setCursorPos(1,8)
    screen.setTextColor(colors.orange)
    screen.write("Fuel Amount: ")
    screen.setCursorPos(14,8)
    screen.setTextColor(text)
    screen.write(reactor.getFuelAmount().." mB ("..math.floor(fuelP).."%)")
  --FUEL REACTIVITY
    screen.setCursorPos(1,9)
    screen.setTextColor(colors.orange)
    screen.write("Fuel Reactivity: ")
    screen.setTextColor(text)
    screen.setCursorPos(18,9)
    screen.write(math.floor(reactor.getFuelReactivity()).."%")
  --FUEL CONSUMED
    screen.setCursorPos(1,10)
    screen.setTextColor(colors.orange)
    screen.write("Fuel Consumption: ")
    screen.setTextColor(text)
    screen.setCursorPos(19,10)
    screen.write((math.floor(reactor.getFuelConsumedLastTick()*1000)/1000).." mB")
    screen.setCursorPos(29,10)
    screen.write("("..(math.floor(fuelTime*10)/10))
    screen.setCursorPos(35,10)
    screen.write(" min)")
  --WASTE AMOUNT
    screen.setCursorPos(1,11)
    screen.setTextColor(colors.orange)
    screen.write("Waste Amount: ")
    screen.setTextColor(text)
    screen.setCursorPos(15,11)
    screen.write(reactor.getWasteAmount().." mB ("..math.floor(wasteP).."%)")
  --CONTROL RODS
    screen.setCursorPos(1,12)
    screen.setTextColor(colors.orange)
    screen.write("Control Rod Level: ")
    screen.setCursorPos(20,12)
    screen.setTextColor(text)
    screen.write(reactor.getControlRodLevel(0).."%")
  --MESSAGES
    screen.setCursorPos(1,14)
    screen.setTextColor(colors.orange)
    screen.write("Messages: ")
    screen.setTextColor(colors.blue)
    screen.setCursorPos(11,14)
    if reactor.getEnergyStored() > 6000000 or halt == 1 then
      reactor.setActive(false)
      halt = 1
      screen.write("Reactor halted to save fuel.  ")
      screen.setCursorPos(10,15)
      screen.write("Internal energy buffer at 60% ")
      screen.setCursorPos(9,16)
      screen.write("Drain buffer to 10% to restart reactor.")
    elseif halt == 0 and reactor.getActive() then
      screen.write("Reactor functioning properly.")
      screen.setCursorPos(11,15)
      screen.clearLine()
      screen.setCursorPos(11,16)
      screen.clearLine()
    elseif halt == 0 and not (reactor.getActive()) then
      screen.write("Reactor Offline.")
      screen.setCursorPos(11,15)
      screen.clearLine()
      screen.setCursorPos(11,16)
      screen.clearLine()
    else
      screen.write("ERROR ERROR ERROR")
    end
    if halt == 1 and reactor.getEnergyStored() < 500000 then
      halt = 0
      reactor.setActive(true)
    end
  term.setCursorPos(1,1)
  term.setTextColor(colors.brown)
  if load == 0 then
  term.write("Monitoring Reactor   ")
  load = load + 1
  elseif load == 1 then
  term.write("Monitoring Reactor.  ")
  load = load + 1
  elseif load == 2 then
  term.write("Monitoring Reactor.. ")
  load = load + 1
  elseif load == 3 then
  term.write("Monitoring Reactor...")
  load = 0
  end
  sleep(.5)
  end
end

function manageControlRod()
  while true do
    --SET UP SCREEN
    panel.setCursorPos(1,1)
    panel.setBackgroundColor(colors.blue)
    panel.setTextColor(colors.orange)
    panel.write("Control")
    panel.setCursorPos(1,5)
    panel.write("  Rod  ")
    panel.setBackgroundColor(colors.green)
    panel.setTextColor(colors.white)
    panel.setCursorPos(2,2)
    panel.write("+")
    panel.setCursorPos(4,2)
    panel.write("+")
    panel.setCursorPos(6,2)
    panel.write("+")
    panel.setBackgroundColor(colors.red)
    panel.setCursorPos(2,4)
    panel.write("-")
    panel.setCursorPos(4,4)
    panel.write("-")
    panel.setCursorPos(6,4)
    panel.write("-")
    panel.setBackgroundColor(colors.black)
    panel.setTextColor(colors.orange)
    panel.setCursorPos(2,3)
    panel.write("1")
    panel.setCursorPos(4,3)
    panel.write("5")
    panel.setCursorPos(6,3)
    panel.write("10")
    event, side, xPos, yPos = os.pullEvent("monitor_touch")
    level = reactor.getControlRodLevel(0)
    if yPos == 2 then
      if xPos == 2 then
        if level < 100 then
          level = level + 1
        else
          level = 100
        end
      elseif xPos == 4 then
        if level < 95 then
          level = level + 5
        else
          level = 100
        end
      elseif xPos == 6 then
        if level < 90 then
          level = level + 10
        else
          level = 100
        end
      end
    elseif yPos == 4 then
      if xPos == 2 then
        if level > 0 then
          level = level - 1
        else
          level = 0
        end
      elseif xPos == 4 then
        if level > 4 then
          level = level - 5
        else
          level = 0
        end
      elseif xPos == 6 then
        if level > 9 then
          level = level - 10
        else
          level = 0
        end
      end
    end
    reactor.setAllControlRodLevels(level)
    sleep(.25)
  end
end

function wirelessControl()--Not completed
  while true do
    id, message = rednet.receive()
    sleep(.15)
    if message == "reactorOff" then
      reactor.setActive(false)
    elseif message == "reactorOn" then
      reactor.setActive(true)
    elseif message == "setControlRod" then
      id, message = rednet.receive(30)
      if message > 100 then
        reactor.setAllControlRodLevels(100)
      elseif message < 0 then
        reactor.setAllControlRodLevels(0)
      else
        reactor.setAllControlRodLevels(message)
      end
    elseif message == "getEnabled" then
      if reactor.getActive() then
        rednet.send(id, "Reactor is enabled")
      else
        rednet.send(id, "Reactor is disabled")
      end
    elseif message == "getSummary" then
      rednet.send(id, reactor.getEnabled())
      sleep(0.25)
    end
  end
end

parallel.waitForAll(reactorMonitor, manageControlRod, wirelessControl)
