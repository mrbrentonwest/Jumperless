# Project Specification: Motion-Activated Light

**Project Number**: 07
**Difficulty**: Intermediate
**Created**: 2026-01-02
**Status**: Draft

## Overview

Create a motion-activated lighting system using a PIR sensor and NeoPixel strip. The light turns on when motion is detected and automatically turns off after a timeout period.

## Learning Objectives

- Interface with PIR (Passive Infrared) motion sensors
- Implement timeout-based state management
- Create smooth LED transitions (fade in/out)
- Understand non-blocking timing with millis()

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | PIR Motion Sensor Module | Yes - 37-in-1 Sensor Kit |
| 1 | Adafruit NeoPixel Stick (8 LEDs) | Yes |

## Circuit Description

PIR sensor detects infrared radiation changes (motion). NeoPixel provides adjustable lighting.

### Connections
- PIR VCC → 5V
- PIR GND → GND
- PIR OUT → Arduino D2
- NeoPixel VCC → 5V
- NeoPixel GND → GND
- NeoPixel DIN → Arduino D6

## User Scenarios & Testing

### Scenario 1 - Basic Motion Trigger (Priority: P1)

Light turns on when motion detected, off after timeout.

**Why this priority**: Core motion-activated functionality

**Acceptance Criteria**:
1. **Given** no motion for 30 seconds, **When** person walks by, **Then** light turns on
2. **Given** light is on, **When** continuous motion, **Then** light stays on
3. **Given** light is on, **When** no motion for 30 seconds, **Then** light turns off

### Scenario 2 - Fade Transitions (Priority: P2)

Smooth fade in when activating, fade out when deactivating.

**Acceptance Criteria**:
1. **Given** light is off, **When** motion detected, **Then** light fades in over 0.5 seconds
2. **Given** light is on, **When** timeout reached, **Then** light fades out over 2 seconds
3. **Given** fading out, **When** new motion detected, **Then** immediately returns to full brightness

### Scenario 3 - Ambient Light Override (Priority: P3)

Only activate in dark conditions (combine with light sensor).

**Acceptance Criteria**:
1. **Given** room is bright, **When** motion detected, **Then** light stays off
2. **Given** room is dark, **When** motion detected, **Then** light activates normally
3. **Given** room becomes bright, **When** light is on, **Then** light fades out

## Code Template

```cpp
// Motion-Activated Light - Project 07
#include <Adafruit_NeoPixel.h>

#define PIR_PIN 2
#define NEOPIXEL_PIN 6
#define NUM_LEDS 8

Adafruit_NeoPixel strip(NUM_LEDS, NEOPIXEL_PIN, NEO_GRBW + NEO_KHZ800);

const unsigned long TIMEOUT = 30000;  // 30 seconds
const int FADE_STEPS = 50;
const int FADE_DELAY = 10;

unsigned long lastMotionTime = 0;
bool lightOn = false;
int currentBrightness = 0;
int targetBrightness = 0;

void setup() {
  Serial.begin(9600);
  pinMode(PIR_PIN, INPUT);

  strip.begin();
  strip.show();

  Serial.println("Motion Light Ready");
  Serial.println("Waiting for PIR to stabilize (30s)...");
  delay(30000);  // PIR needs time to calibrate
  Serial.println("System active!");
}

void setAllLeds(int brightness) {
  uint32_t color = strip.Color(brightness, brightness, brightness, brightness);
  for (int i = 0; i < NUM_LEDS; i++) {
    strip.setPixelColor(i, color);
  }
  strip.show();
}

void updateBrightness() {
  if (currentBrightness < targetBrightness) {
    currentBrightness = min(currentBrightness + 5, targetBrightness);
    setAllLeds(currentBrightness);
  } else if (currentBrightness > targetBrightness) {
    currentBrightness = max(currentBrightness - 2, targetBrightness);
    setAllLeds(currentBrightness);
  }
}

void loop() {
  int motion = digitalRead(PIR_PIN);

  if (motion == HIGH) {
    lastMotionTime = millis();
    targetBrightness = 200;
    if (!lightOn) {
      Serial.println("Motion detected - light ON");
      lightOn = true;
    }
  }

  // Check timeout
  if (lightOn && (millis() - lastMotionTime > TIMEOUT)) {
    Serial.println("Timeout - light OFF");
    targetBrightness = 0;
    lightOn = false;
  }

  // Smooth brightness transitions
  updateBrightness();

  delay(20);
}
```

## Required Libraries

- **Adafruit NeoPixel** library

## PIR Sensor Notes

- Most PIR modules have two potentiometers:
  - **Sensitivity**: Adjusts detection range (typically 3-7 meters)
  - **Time delay**: Adjusts how long output stays HIGH after motion (can override in code)
- PIR needs 30-60 seconds to stabilize after power-on
- Some modules have jumper for retriggering mode (H = retrigger, L = single trigger)

## Success Criteria

- [ ] Motion reliably triggers light activation
- [ ] Timeout works correctly (light turns off after period of no motion)
- [ ] Fade transitions are smooth and visible
- [ ] No false triggers after warm-up period

## Troubleshooting

- **Constant triggering**: PIR still calibrating (wait longer), or sensitivity too high
- **Not detecting motion**: Check PIR output with Serial, adjust sensitivity pot
- **Erratic behavior**: Ensure stable 5V power, PIR is sensitive to power fluctuations
- **Light stays on**: Check retriggering mode jumper on PIR module

## Advanced Challenges

- Add light sensor to only activate in dark conditions
- Implement "pathway lighting" - light follows you along multiple strips
- Add adjustable timeout via potentiometer
- Different colors for different times of day

## Next Steps

After completing this project, try:
- Project 08: Servo Radar Scanner
- Add multiple PIR sensors for directional detection
