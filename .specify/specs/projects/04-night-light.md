# Project Specification: Light Sensor Night Light

**Project Number**: 04
**Difficulty**: Basic
**Created**: 2026-01-02
**Status**: Draft

## Overview

Create an automatic night light that turns on when ambient light drops below a threshold. Introduction to analog sensors and threshold-based control.

## Learning Objectives

- Read analog input values (0-1023)
- Understand photoresistors/light sensors
- Implement threshold-based logic
- Use Serial Monitor for debugging sensor values

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | Photoresistor/Light Sensor Module | Yes - 37-in-1 Sensor Kit |
| 1 | 5mm LED (white or warm white preferred) | Yes - LED Kit |
| 1 | 220-330 ohm resistor | Yes - Resistor Kit |
| 1 | 10K ohm resistor (for raw photoresistor) | Yes - Resistor Kit |

## Circuit Description

Light sensor provides analog voltage based on light level. LED turns on when light is below threshold.

### Connections (Using Sensor Module)
- Sensor VCC → 5V
- Sensor GND → GND
- Sensor OUT → Arduino A0
- Arduino D9 → 220Ω Resistor → LED → GND

### Connections (Using Raw Photoresistor)
- 5V → Photoresistor → Arduino A0
- Arduino A0 → 10KΩ Resistor → GND
- Arduino D9 → 220Ω Resistor → LED → GND

## User Scenarios & Testing

### Scenario 1 - Binary On/Off (Priority: P1)

LED turns on when dark, off when light.

**Why this priority**: Core night light functionality

**Acceptance Criteria**:
1. **Given** room is well-lit, **When** sensor reads above threshold, **Then** LED is off
2. **Given** room goes dark, **When** sensor reads below threshold, **Then** LED turns on
3. **Given** hand covers sensor, **When** light blocked, **Then** LED turns on immediately

### Scenario 2 - Smooth Dimming (Priority: P2)

LED brightness inversely proportional to ambient light using PWM.

**Acceptance Criteria**:
1. **Given** bright room, **When** light level is high, **Then** LED is off or very dim
2. **Given** dim room, **When** light level is medium, **Then** LED is at medium brightness
3. **Given** dark room, **When** light level is low, **Then** LED is at full brightness

### Scenario 3 - Adjustable Threshold (Priority: P3)

Use potentiometer to set the trigger threshold.

**Acceptance Criteria**:
1. **Given** potentiometer at minimum, **When** adjusted, **Then** night light triggers in dimmer conditions
2. **Given** potentiometer at maximum, **When** adjusted, **Then** night light triggers in brighter conditions

## Code Template

```cpp
// Light Sensor Night Light - Project 04
const int LIGHT_SENSOR_PIN = A0;
const int LED_PIN = 9;
const int THRESHOLD = 300;  // Adjust based on your environment

void setup() {
  pinMode(LED_PIN, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int lightLevel = analogRead(LIGHT_SENSOR_PIN);

  // Debug output
  Serial.print("Light level: ");
  Serial.println(lightLevel);

  // Binary mode
  if (lightLevel < THRESHOLD) {
    digitalWrite(LED_PIN, HIGH);
  } else {
    digitalWrite(LED_PIN, LOW);
  }

  // Uncomment for smooth dimming mode:
  /*
  int brightness = map(lightLevel, 0, 1023, 255, 0);
  brightness = constrain(brightness, 0, 255);
  analogWrite(LED_PIN, brightness);
  */

  delay(100);
}
```

## Success Criteria

- [ ] Sensor accurately detects light level changes
- [ ] LED responds to ambient light conditions
- [ ] Threshold is appropriate for intended use
- [ ] Serial Monitor shows sensor readings for calibration

## Troubleshooting

- **Always on or always off**: Adjust THRESHOLD value using Serial Monitor readings
- **Flickering at threshold**: Add hysteresis (two thresholds: on at 300, off at 400)
- **Slow response**: Reduce delay() value
- **Readings are inverted**: Some modules output HIGH for dark; invert logic

## Calibration

1. Open Serial Monitor (9600 baud)
2. Note reading in bright conditions (e.g., 800)
3. Note reading in dark conditions (e.g., 100)
4. Set threshold between these values (e.g., 400)

## Next Steps

After completing this project, try:
- Project 05: Temperature Monitor
- Add RGB LED for color-changing night light
- Add motion sensor to only activate when someone is present
