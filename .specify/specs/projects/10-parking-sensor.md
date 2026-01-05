# Project Specification: Smart Parking Sensor

**Project Number**: 10
**Difficulty**: Intermediate
**Created**: 2026-01-02
**Status**: Draft

## Overview

Build a garage parking assistant that helps drivers park at the perfect distance. Uses ultrasonic sensor for distance measurement, NeoPixel strip for visual feedback, and buzzer for audio alerts - just like commercial parking sensors.

## Learning Objectives

- Integrate multiple output types (visual + audio)
- Implement progressive warning systems
- Create responsive real-time feedback
- Handle edge cases and calibration

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | HC-SR04 Ultrasonic Sensor | Yes - Ultrasonic Module Pack |
| 1 | Adafruit NeoPixel Stick (8 LEDs) | Yes |
| 1 | Buzzer (Active or Passive) | Yes - 37-in-1 Sensor Kit |
| 1 | Push Button (for calibration) | Yes - 37-in-1 Sensor Kit |
| 1 | 10K resistor | Yes - Resistor Kit |

## Circuit Description

Ultrasonic sensor measures distance to vehicle. NeoPixel provides visual distance indication. Buzzer provides audio proximity warning.

### Connections
- HC-SR04 VCC → 5V
- HC-SR04 GND → GND
- HC-SR04 TRIG → Arduino D9
- HC-SR04 ECHO → Arduino D10
- NeoPixel VCC → 5V
- NeoPixel GND → GND
- NeoPixel DIN → Arduino D6
- Buzzer + → Arduino D5
- Buzzer - → GND
- Button → Arduino D2
- Arduino D2 → 10KΩ → GND

## User Scenarios & Testing

### Scenario 1 - Visual Distance Display (Priority: P1)

LED bar graph shows distance with color coding.

**Why this priority**: Primary user feedback mechanism

**Acceptance Criteria**:
1. **Given** car > 150cm away, **When** measured, **Then** all LEDs green, rightmost lit
2. **Given** car 100-150cm away, **When** measured, **Then** LEDs green-yellow, 3 lit
3. **Given** car 50-100cm away, **When** measured, **Then** LEDs yellow-orange, 5 lit
4. **Given** car 20-50cm away, **When** measured, **Then** LEDs orange-red, 7 lit
5. **Given** car < 20cm away, **When** measured, **Then** all LEDs red, flashing

### Scenario 2 - Audio Proximity Warning (Priority: P1)

Beep rate increases as car approaches.

**Acceptance Criteria**:
1. **Given** car > 150cm away, **When** measured, **Then** no beeping
2. **Given** car 100-150cm away, **When** measured, **Then** slow beeping (1/sec)
3. **Given** car 50-100cm away, **When** measured, **Then** medium beeping (2/sec)
4. **Given** car 20-50cm away, **When** measured, **Then** fast beeping (4/sec)
5. **Given** car < 20cm away, **When** measured, **Then** continuous tone

### Scenario 3 - Perfect Stop Indicator (Priority: P2)

Special indication when car is at ideal distance.

**Acceptance Criteria**:
1. **Given** car at 30-40cm (ideal zone), **When** measured, **Then** center LEDs pulse green
2. **Given** car enters ideal zone, **When** detected, **Then** two short beeps confirm
3. **Given** car in ideal zone, **When** stationary 3 seconds, **Then** beeping stops

### Scenario 4 - Calibration Mode (Priority: P3)

Button press calibrates "perfect stop" distance.

**Acceptance Criteria**:
1. **Given** button held 3 seconds, **When** released, **Then** enters calibration mode
2. **Given** in calibration mode, **When** button pressed, **Then** current distance saved as target
3. **Given** calibration complete, **When** done, **Then** settings persist in EEPROM

## Code Template

```cpp
// Smart Parking Sensor - Project 10
#include <Adafruit_NeoPixel.h>
#include <EEPROM.h>

#define TRIG_PIN 9
#define ECHO_PIN 10
#define NEOPIXEL_PIN 6
#define BUZZER_PIN 5
#define BUTTON_PIN 2
#define NUM_LEDS 8

Adafruit_NeoPixel strip(NUM_LEDS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);

// Distance thresholds (cm)
int targetDistance = 35;  // Ideal stop distance
const int FAR_DISTANCE = 150;
const int MED_DISTANCE = 100;
const int CLOSE_DISTANCE = 50;
const int DANGER_DISTANCE = 20;

unsigned long lastBeep = 0;
unsigned long lastFlash = 0;
bool flashState = false;
bool inIdealZone = false;
unsigned long idealZoneStart = 0;

void setup() {
  Serial.begin(9600);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT);

  strip.begin();
  strip.setBrightness(100);
  strip.show();

  // Load calibration from EEPROM
  int saved = EEPROM.read(0);
  if (saved > 10 && saved < 200) {
    targetDistance = saved;
  }

  Serial.print("Target distance: ");
  Serial.println(targetDistance);

  // Startup animation
  for (int i = 0; i < NUM_LEDS; i++) {
    strip.setPixelColor(i, strip.Color(0, 100, 0));
    strip.show();
    delay(50);
  }
  delay(500);
  strip.clear();
  strip.show();
}

long measureDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH, 30000);
  return duration * 0.034 / 2;
}

void updateDisplay(long distance) {
  strip.clear();

  // Calculate how many LEDs to light
  int numLeds = map(distance, DANGER_DISTANCE, FAR_DISTANCE, NUM_LEDS, 1);
  numLeds = constrain(numLeds, 1, NUM_LEDS);

  // Determine color based on distance
  uint32_t color;
  if (distance > MED_DISTANCE) {
    color = strip.Color(0, 255, 0);        // Green
  } else if (distance > CLOSE_DISTANCE) {
    color = strip.Color(255, 255, 0);      // Yellow
  } else if (distance > DANGER_DISTANCE) {
    color = strip.Color(255, 128, 0);      // Orange
  } else {
    color = strip.Color(255, 0, 0);        // Red
  }

  // Check ideal zone
  if (abs(distance - targetDistance) < 10) {
    color = strip.Color(0, 255, 100);      // Teal for perfect
    if (!inIdealZone) {
      inIdealZone = true;
      idealZoneStart = millis();
      // Confirmation beeps
      tone(BUZZER_PIN, 2000, 100);
      delay(150);
      tone(BUZZER_PIN, 2500, 100);
    }
  } else {
    inIdealZone = false;
  }

  // Danger zone flashing
  if (distance < DANGER_DISTANCE) {
    if (millis() - lastFlash > 100) {
      flashState = !flashState;
      lastFlash = millis();
    }
    if (!flashState) {
      color = strip.Color(0, 0, 0);
    }
  }

  // Light up LEDs from right to left
  for (int i = NUM_LEDS - 1; i >= NUM_LEDS - numLeds; i--) {
    strip.setPixelColor(i, color);
  }
  strip.show();
}

void updateBuzzer(long distance) {
  // Don't beep if in ideal zone for > 3 seconds
  if (inIdealZone && (millis() - idealZoneStart > 3000)) {
    noTone(BUZZER_PIN);
    return;
  }

  int beepInterval;

  if (distance > FAR_DISTANCE) {
    noTone(BUZZER_PIN);
    return;
  } else if (distance > MED_DISTANCE) {
    beepInterval = 1000;
  } else if (distance > CLOSE_DISTANCE) {
    beepInterval = 500;
  } else if (distance > DANGER_DISTANCE) {
    beepInterval = 250;
  } else {
    // Continuous tone for danger
    tone(BUZZER_PIN, 2000);
    return;
  }

  if (millis() - lastBeep > beepInterval) {
    tone(BUZZER_PIN, 1500, 50);
    lastBeep = millis();
  }
}

void checkCalibration() {
  static unsigned long buttonPressStart = 0;
  static bool wasPressed = false;

  bool isPressed = digitalRead(BUTTON_PIN);

  if (isPressed && !wasPressed) {
    buttonPressStart = millis();
  } else if (isPressed && (millis() - buttonPressStart > 3000)) {
    // Calibration mode
    Serial.println("Calibrating...");

    // Visual feedback
    strip.fill(strip.Color(0, 0, 255));
    strip.show();
    delay(500);

    long newTarget = measureDistance();
    if (newTarget > 10 && newTarget < 200) {
      targetDistance = newTarget;
      EEPROM.write(0, targetDistance);
      Serial.print("New target: ");
      Serial.println(targetDistance);

      // Confirmation
      strip.fill(strip.Color(0, 255, 0));
      strip.show();
      tone(BUZZER_PIN, 2000, 200);
      delay(1000);
    }
  }

  wasPressed = isPressed;
}

void loop() {
  checkCalibration();

  long distance = measureDistance();

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  if (distance > 0 && distance < 400) {
    updateDisplay(distance);
    updateBuzzer(distance);
  }

  delay(50);
}
```

## Required Libraries

- **Adafruit NeoPixel**
- **EEPROM** (built-in)

## Success Criteria

- [ ] Visual display clearly shows distance
- [ ] Audio beeping rate matches distance appropriately
- [ ] Perfect stop zone is clearly indicated
- [ ] Calibration saves and persists after power cycle
- [ ] No false readings or erratic behavior

## Troubleshooting

- **Erratic readings**: Add averaging (3-5 samples), check sensor mounting
- **Buzzer too loud**: Add resistor in series or use PWM for volume control
- **LEDs not bright enough**: Increase setBrightness() or use separate 5V supply
- **Calibration doesn't save**: Check EEPROM write, ensure valid distance range

## Installation Tips

1. Mount sensor at bumper height, facing where car will approach
2. Mount LED strip at eye level for driver visibility
3. Keep sensor away from reflective surfaces that could cause false readings
4. Test with actual vehicle to calibrate ideal distance

## Advanced Challenges

- Add second sensor for two-car garage
- Add WiFi notification when car is parked
- Implement "car leaving" detection with different alerts
- Add temperature compensation for ultrasonic accuracy

## Project Complete!

Congratulations on completing the 10-project series! You've learned:
- Digital and analog I/O
- Multiple sensor types
- LED control (basic and addressable)
- Servo motors
- Audio output
- State machines and modes
- Data persistence (EEPROM)
- Multi-component integration
