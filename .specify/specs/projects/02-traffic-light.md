# Project Specification: Traffic Light Simulator

**Project Number**: 02
**Difficulty**: Basic
**Created**: 2026-01-02
**Status**: Draft

## Overview

Build a traffic light simulator using red, yellow, and green LEDs. Learn to control multiple outputs in sequence with proper timing.

## Learning Objectives

- Control multiple digital outputs
- Implement sequential logic and timing
- Understand state machines conceptually
- Practice wiring multiple components

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | Red 5mm LED | Yes - LED Kit |
| 1 | Yellow 5mm LED | Yes - LED Kit |
| 1 | Green 5mm LED | Yes - LED Kit |
| 3 | 220-330 ohm resistor | Yes - Resistor Kit |

## Circuit Description

Three parallel LED circuits, each with its own current-limiting resistor.

### Connections
- Arduino D11 → 220Ω Resistor → Red LED → GND
- Arduino D10 → 220Ω Resistor → Yellow LED → GND
- Arduino D9 → 220Ω Resistor → Green LED → GND

## User Scenarios & Testing

### Scenario 1 - Basic Traffic Sequence (Priority: P1)

Standard traffic light cycle: Green → Yellow → Red → Green...

**Why this priority**: Core functionality demonstrating sequential control

**Acceptance Criteria**:
1. **Given** system starts, **When** powered on, **Then** green LED lights first
2. **Given** green is lit for 5 seconds, **When** time elapses, **Then** yellow lights for 2 seconds
3. **Given** yellow is lit for 2 seconds, **When** time elapses, **Then** red lights for 5 seconds
4. **Given** red is lit for 5 seconds, **When** time elapses, **Then** cycle repeats from green

### Scenario 2 - Pedestrian Crossing Mode (Priority: P2)

Add a button to trigger pedestrian crossing (interrupt green to go yellow→red).

**Acceptance Criteria**:
1. **Given** green is active, **When** button pressed, **Then** sequence advances to yellow
2. **Given** red or yellow is active, **When** button pressed, **Then** button is ignored until next green

## Code Template

```cpp
// Traffic Light Simulator - Project 02
const int RED_PIN = 11;
const int YELLOW_PIN = 10;
const int GREEN_PIN = 9;

void setup() {
  pinMode(RED_PIN, OUTPUT);
  pinMode(YELLOW_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
}

void loop() {
  // Green light
  digitalWrite(GREEN_PIN, HIGH);
  digitalWrite(YELLOW_PIN, LOW);
  digitalWrite(RED_PIN, LOW);
  delay(5000);

  // Yellow light
  digitalWrite(GREEN_PIN, LOW);
  digitalWrite(YELLOW_PIN, HIGH);
  delay(2000);

  // Red light
  digitalWrite(YELLOW_PIN, LOW);
  digitalWrite(RED_PIN, HIGH);
  delay(5000);
}
```

## Success Criteria

- [ ] All three LEDs light up independently
- [ ] Correct sequence: Green → Yellow → Red
- [ ] Timing matches real traffic lights (adjustable)
- [ ] Only one LED lit at a time (except transitions)

## Troubleshooting

- **Wrong LED lights up**: Check pin assignments match wiring
- **Multiple LEDs on**: Verify each LED has separate resistor path to GND
- **Timing too fast/slow**: Adjust delay() values

## Next Steps

After completing this project, try:
- Project 03: Button-Controlled LED
- Add a second traffic light for an intersection
- Add countdown display
