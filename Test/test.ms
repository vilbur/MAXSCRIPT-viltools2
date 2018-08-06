(
clearListener()

try (closeRolloutFloater ::rollTest.rollFloat) Catch()

struct rollouts
(
public rollFloat, rollout1, rollout2, rollout3,

fn createRollout1 =
(
local r = rollout roll1 "Rollout 1"
(
on roll1 open do
(
roll1.rollStruct = this
)

local rollStruct

fn printCBs =
(
print rollStruct.rollout1.cb1.state
print rollStruct.rollout2.cb2.state
print rollStruct.rollout3.cb3.state
)

button b1 "Button 1"
checkBox cb1

on b1 pressed do printCBs()
)
r
),

fn createRollout2 =
(
local r = rollout roll2 "Rollout 2"
(
on roll2 open do
(
roll2.rollStruct = this
)

local rollStruct

fn printCBs =
(
print rollStruct.rollout1.cb1.state
print rollStruct.rollout2.cb2.state
print rollStruct.rollout3.cb3.state
)

button b2 "Button 2"
checkBox cb2

on b2 pressed do printCBs()
)
r
),

fn createRollout3 =
(
local r = rollout roll3 "Rollout 3"
(
on roll3 open do
(
roll3.rollStruct = this
)

local rollStruct

fn printCBs =
(
print rollStruct.rollout1.cb1.state
print rollStruct.rollout2.cb2.state
print rollStruct.rollout3.cb3.state
)

button b3 "Button 3"
checkBox cb3

on b3 pressed do printCBs()
)
r
),

fn createUI =
(
rollout1 = createRollout1()
rollout2 = createRollout2()
rollout3 = createRollout3()

rollFloat = newRolloutFloater "Test Float" 100 250
addRollout rollout1 rollFloat
addRollout rollout2 rollFloat
addRollout rollout3 rollFloat
),

start = createUI()
)
global rollTest = rollouts()
)