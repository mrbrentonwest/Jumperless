# Project Specification: RGB Mood Light Controller

**Project Number**: 09
**Difficulty**: Intermediate
**Created**: 2026-01-02
**Status**: Draft

## Overview

Create an interactive mood light using the NeoPixel strip with multiple control modes: manual color selection via potentiometer, automatic color cycling, sound-reactive mode, and preset scenes.

## Learning Objectives

- Master NeoPixel color manipulation (HSV color space)
- Read multiple analog inputs
- Implement multiple operating modes with button switching
- Create smooth color animations and transitions

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | Adafruit NeoPixel Stick (8 LEDs) | Yes |
| 1 | Potentiometer (from sensor kit) | Yes - 37-in-1 Sensor Kit |
| 1 | Sound Sensor Module | Yes - 37-in-1 Sensor Kit |
| 1 | Push Button | Yes - 37-in-1 Sensor Kit |
| 1 | 10K resistor (pull-down) | Yes - Resistor Kit |

## Circuit Description

Potentiometer controls color/brightness, button cycles modes, sound sensor enables reactive mode.

### Connections
- Potentiometer VCC → 5V
- Potentiometer GND → GND
- Potentiometer OUT → Arduino A0
- Sound Sensor VCC → 5V
- Sound Sensor GND → GND
- Sound Sensor OUT → Arduino A1
- Button Pin 1 → Arduino D2
- Button Pin 2 → 5V
- Arduino D2 → 10KΩ → GND (pull-down)
- NeoPixel VCC → 5V
- NeoPixel GND → GND
- NeoPixel DIN → Arduino D6

## User Scenarios & Testing

### Scenario 1 - Manual Color Selection (Priority: P1)

Potentiometer controls color hue across full spectrum.

**Why this priority**: Core interactive control

**Acceptance Criteria**:
1. **Given** mode is Manual, **When** pot at 0%, **Then** color is red
2. **Given** mode is Manual, **When** pot at 50%, **Then** color is cyan
3. **Given** mode is Manual, **When** pot rotated, **Then** color smoothly transitions through spectrum
4. **Given** any pot position, **When** stable, **Then** no flicker or jumping

### Scenario 2 - Auto Color Cycle (Priority: P1)

Colors automatically cycle through rainbow.

**Acceptance Criteria**:
1. **Given** mode is Auto, **When** running, **Then** colors cycle smoothly
2. **Given** mode is Auto, **When** pot adjusted, **Then** cycle speed changes
3. **Given** full cycle, **When** complete, **Then** seamlessly loops back

### Scenario 3 - Sound Reactive (Priority: P2)

LEDs respond to ambient sound/music.

**Acceptance Criteria**:
1. **Given** mode is Sound, **When** quiet, **Then** LEDs dim or off
2. **Given** mode is Sound, **When** loud sound, **Then** LEDs flash bright
3. **Given** mode is Sound, **When** music playing, **Then** LEDs pulse with beat
4. **Given** pot adjusted, **When** in Sound mode, **Then** sensitivity changes

### Scenario 4 - Mode Switching (Priority: P1)

Button cycles through operating modes.

**Acceptance Criteria**:
1. **Given** any mode, **When** button pressed, **Then** advances to next mode
2. **Given** mode changes, **When** transition occurs, **Then** brief indicator flash
3. **Given** on last mode, **When** button pressed, **Then** wraps to first mode

## Code Template

```cpp
// RGB Mood Light Controller - Project 09
#include <Adafruit_NeoPixel.h>

#define NEOPIXEL_PIN 6
#define NUM_LEDS 8
#define POT_PIN A0
#define SOUND_PIN A1
#define BUTTON_PIN 2

Adafruit_NeoPixel strip(NUM_LEDS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);

enum Mode { MANUAL, AUTO_CYCLE, SOUND_REACTIVE, PRESET_WARM, PRESET_COOL };
Mode currentMode = MANUAL;
const int NUM_MODES = 5;

bool lastButtonState = false;
unsigned long lastUpdate = 0;
uint16_t autoHue = 0;

void setup() {
  Serial.begin(9600);
  pinMode(BUTTON_PIN, INPUT);

  strip.begin();
  strip.setBrightness(150);
  strip.show();

  showModeIndicator();
}

void showModeIndicator() {
  // Flash color to indicate mode
  uint32_t colors[] = {
    strip.Color(255, 0, 0),    // Manual - Red
    strip.Color(0, 255, 0),    // Auto - Green
    strip.Color(0, 0, 255),    // Sound - Blue
    strip.Color(255, 150, 50), // Warm - Orange
    strip.Color(100, 150, 255) // Cool - Light Blue
  };

  strip.fill(colors[currentMode]);
  strip.show();
  delay(300);
}

void setAllHSV(uint16_t hue, uint8_t sat, uint8_t val) {
  uint32_t color = strip.ColorHSV(hue, sat, val);
  strip.fill(color);
  strip.show();
}

void manualMode() {
  int potValue = analogRead(POT_PIN);
  uint16_t hue = map(potValue, 0, 1023, 0, 65535);
  setAllHSV(hue, 255, 200);
}

void autoCycleMode() {
  int potValue = analogRead(POT_PIN);
  int speed = map(potValue, 0, 1023, 50, 500);

  if (millis() - lastUpdate > speed / 10) {
    autoHue += 100;
    setAllHSV(autoHue, 255, 200);
    lastUpdate = millis();
  }
}

void soundReactiveMode() {
  int potValue = analogRead(POT_PIN);
  int sensitivity = map(potValue, 0, 1023, 50, 500);

  int soundLevel = analogRead(SOUND_PIN);
  int brightness = map(soundLevel, sensitivity, 1023, 0, 255);
  brightness = constrain(brightness, 0, 255);

  // Color shifts with intensity
  uint16_t hue = map(brightness, 0, 255, 0, 21845);  // Red to Green
  setAllHSV(hue, 255, brightness);
}

void presetMode(bool warm) {
  if (warm) {
    // Warm white / candlelight
    strip.fill(strip.Color(255, 147, 41));
  } else {
    // Cool white / daylight
    strip.fill(strip.Color(200, 220, 255));
  }
  strip.show();
}

void checkButton() {
  bool buttonState = digitalRead(BUTTON_PIN);

  if (buttonState && !lastButtonState) {
    currentMode = (Mode)((currentMode + 1) % NUM_MODES);
    Serial.print("Mode: ");
    Serial.println(currentMode);
    showModeIndicator();
    delay(50);  // Debounce
  }

  lastButtonState = buttonState;
}

void loop() {
  checkButton();

  switch (currentMode) {
    case MANUAL:
      manualMode();
      break;
    case AUTO_CYCLE:
      autoCycleMode();
      break;
    case SOUND_REACTIVE:
      soundReactiveMode();
      break;
    case PRESET_WARM:
      presetMode(true);
      break;
    case PRESET_COOL:
      presetMode(false);
      break;
  }

  delay(10);
}
```

## Required Libraries

- **Adafruit NeoPixel**

## Success Criteria

- [ ] All modes function correctly
- [ ] Button reliably switches modes
- [ ] Potentiometer provides smooth control
- [ ] Sound reactive mode responds to audio
- [ ] Colors are vibrant and transitions smooth

## Troubleshooting

- **Colors look washed out**: Increase saturation in HSV, check power supply
- **Sound mode not responsive**: Adjust sound sensor sensitivity pot, check analog readings
- **Mode skips on button press**: Increase debounce delay
- **Flickering in manual mode**: Add smoothing to potentiometer reading

## Sound Sensor Calibration

1. Open Serial Monitor and print soundLevel values
2. Note quiet room baseline (e.g., 300)
3. Note loud sound level (e.g., 700)
4. Adjust sensitivity map() values accordingly

## Advanced Challenges

- Add more presets (sunset, ocean, forest)
- Implement "breathing" effect in presets
- Add second potentiometer for brightness control
- Store last mode in EEPROM to survive power cycles

## Next Steps

After completing this project, try:
- Project 10: Smart Parking Sensor
- Add IR remote control
