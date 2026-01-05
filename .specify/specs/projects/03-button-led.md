# Project Specification: Button-Controlled LED

**Project Number**: 03
**Difficulty**: Basic
**Created**: 2026-01-02
**Status**: Draft

## Overview

Learn digital input by using a button to control an LED. Introduces the concept of reading sensor/input states and responding to user interaction.

## Learning Objectives

- Read digital input (HIGH/LOW states)
- Understand pull-up and pull-down resistors
- Implement basic input→output logic
- Learn about switch debouncing concepts

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | Push Button | Yes - 37-in-1 Sensor Kit |
| 1 | 5mm LED (any color) | Yes - LED Kit |
| 1 | 220-330 ohm resistor | Yes - Resistor Kit |
| 1 | 10K ohm resistor (pull-down) | Yes - Resistor Kit |

## Circuit Description

Button input circuit with pull-down resistor, and LED output circuit.

### Connections
- Arduino D2 → Button Pin 1
- Button Pin 2 → 5V
- Arduino D2 → 10KΩ Resistor → GND (pull-down)
- Arduino D13 → 220Ω Resistor → LED → GND

## User Scenarios & Testing

### Scenario 1 - Momentary Control (Priority: P1)

LED lights only while button is pressed.

**Why this priority**: Simplest input-output relationship

**Acceptance Criteria**:
1. **Given** button is not pressed, **When** observing LED, **Then** LED is off
2. **Given** button is pressed, **When** held down, **Then** LED is on
3. **Given** button is released, **When** observing LED, **Then** LED turns off immediately

### Scenario 2 - Toggle Control (Priority: P2)

Each button press toggles LED state (on→off or off→on).

**Acceptance Criteria**:
1. **Given** LED is off, **When** button pressed and released, **Then** LED turns on and stays on
2. **Given** LED is on, **When** button pressed and released, **Then** LED turns off and stays off
3. **Given** button held down, **When** released, **Then** only one toggle occurs (debounced)

### Scenario 3 - Brightness Control (Priority: P3)

Multiple presses cycle through brightness levels using PWM.

**Acceptance Criteria**:
1. **Given** LED at 0%, **When** button pressed, **Then** LED goes to 33%
2. **Given** LED at 33%, **When** button pressed, **Then** LED goes to 66%
3. **Given** LED at 100%, **When** button pressed, **Then** LED goes to 0%

## Code Template

```cpp
// Button-Controlled LED - Project 03
const int BUTTON_PIN = 2;
const int LED_PIN = 13;

// For toggle mode
bool ledState = false;
bool lastButtonState = false;

void setup() {
  pinMode(BUTTON_PIN, INPUT);
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  // Simple momentary mode
  int buttonState = digitalRead(BUTTON_PIN);
  digitalWrite(LED_PIN, buttonState);

  // Uncomment below for toggle mode:
  /*
  bool currentButtonState = digitalRead(BUTTON_PIN);
  if (currentButtonState && !lastButtonState) {
    ledState = !ledState;
    digitalWrite(LED_PIN, ledState);
    delay(50); // Simple debounce
  }
  lastButtonState = currentButtonState;
  */
}
```

## Success Criteria

- [ ] Button press is detected reliably
- [ ] LED responds immediately to button state
- [ ] No flickering or false triggers (debounced)
- [ ] Understand pull-down resistor purpose

## Troubleshooting

- **Button always reads HIGH**: Missing pull-down resistor
- **Button always reads LOW**: Check 5V connection to button
- **LED flickers on press**: Add debounce delay or capacitor
- **Multiple toggles per press**: Increase debounce delay

## Next Steps

After completing this project, try:
- Project 04: Light Sensor Night Light
- Add multiple buttons for different functions
- Implement long-press vs short-press detection
