# Project Specification: LED Blink

**Project Number**: 01
**Difficulty**: Basic
**Created**: 2026-01-02
**Status**: Draft

## Overview

The classic "Hello World" of electronics. Make an LED blink on and off at a regular interval using the Jumperless breadboard and Arduino Nano.

## Learning Objectives

- Understand basic circuit concepts (current flow, ground, power)
- Learn to use current-limiting resistors with LEDs
- Write and upload a basic Arduino sketch
- Use Jumperless software-defined wiring

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | 5mm LED (any color) | Yes - LED Kit |
| 1 | 220-330 ohm resistor | Yes - Resistor Kit |

## Circuit Description

Simple series circuit: Arduino digital pin → Resistor → LED → Ground

### Connections
- Arduino D13 → 220Ω Resistor
- Resistor → LED Anode (long leg)
- LED Cathode (short leg) → GND

## User Scenarios & Testing

### Scenario 1 - Basic Blink (Priority: P1)

Upload the standard blink sketch and observe the LED blinking.

**Why this priority**: Foundation for all future projects

**Acceptance Criteria**:
1. **Given** circuit is wired correctly, **When** sketch is uploaded, **Then** LED blinks at 1-second intervals
2. **Given** LED is blinking, **When** delay values are changed, **Then** blink rate changes accordingly

### Scenario 2 - Variable Blink Rate (Priority: P2)

Modify the sketch to change blink timing.

**Acceptance Criteria**:
1. **Given** sketch with 100ms delay, **When** uploaded, **Then** LED blinks rapidly (10 times/second)
2. **Given** sketch with 2000ms delay, **When** uploaded, **Then** LED blinks slowly (once every 2 seconds)

## Code Template

```cpp
// LED Blink - Project 01
const int LED_PIN = 13;

void setup() {
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_PIN, HIGH);
  delay(1000);
  digitalWrite(LED_PIN, LOW);
  delay(1000);
}
```

## Success Criteria

- [ ] LED lights up when powered
- [ ] LED blinks at programmed interval
- [ ] Can modify blink rate by changing code
- [ ] Understand why resistor is needed

## Troubleshooting

- **LED doesn't light**: Check LED polarity (long leg = positive)
- **LED very dim**: Resistor value too high, try 220Ω
- **LED burned out**: Missing resistor or wrong polarity

## Next Steps

After completing this project, try:
- Project 02: Traffic Light Simulator
- Add multiple LEDs with different blink patterns
