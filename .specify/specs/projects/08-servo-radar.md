# Project Specification: Servo Radar Scanner

**Project Number**: 08
**Difficulty**: Intermediate
**Created**: 2026-01-02
**Status**: Draft

## Overview

Build a scanning radar system using a servo motor to sweep an ultrasonic sensor back and forth. Output distance data to Serial for visualization in Processing or display on NeoPixel strip.

## Learning Objectives

- Control servo motors with PWM
- Coordinate multiple components (servo + ultrasonic)
- Implement smooth sweeping motion
- Output formatted data for external visualization

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | 9G Servo Motor | Yes |
| 1 | HC-SR04 Ultrasonic Sensor | Yes - Ultrasonic Module Pack |
| 1 | Adafruit NeoPixel Stick (8 LEDs) | Yes |

## Circuit Description

Servo rotates ultrasonic sensor through 180°. Distance readings at each angle create a radar sweep.

### Connections
- Servo Red Wire → 5V
- Servo Brown/Black Wire → GND
- Servo Orange/Yellow Wire → Arduino D3
- HC-SR04 VCC → 5V
- HC-SR04 GND → GND
- HC-SR04 TRIG → Arduino D9
- HC-SR04 ECHO → Arduino D10
- NeoPixel VCC → 5V
- NeoPixel GND → GND
- NeoPixel DIN → Arduino D6

### Physical Setup
- Mount ultrasonic sensor on servo horn
- Ensure sensor can rotate freely through 180°

## User Scenarios & Testing

### Scenario 1 - Basic Sweep with Serial Output (Priority: P1)

Servo sweeps 0-180° while outputting angle and distance data.

**Why this priority**: Foundation for all radar functionality

**Acceptance Criteria**:
1. **Given** system powered on, **When** running, **Then** servo sweeps smoothly 0° to 180° and back
2. **Given** servo at any angle, **When** reading taken, **Then** Serial outputs "angle,distance" format
3. **Given** object in path, **When** sensor points at it, **Then** correct distance reported

### Scenario 2 - NeoPixel Arc Display (Priority: P2)

Map 8 LEDs to 8 angular sectors, showing nearest object distance.

**Acceptance Criteria**:
1. **Given** sweep in progress, **When** at 0-22°, **Then** LED 0 shows distance color
2. **Given** object detected at 45°, **When** servo passes, **Then** corresponding LED turns red
3. **Given** clear path at angle, **When** servo passes, **Then** corresponding LED shows green

### Scenario 3 - Processing Visualization (Priority: P3)

Output data compatible with Processing radar sketch.

**Acceptance Criteria**:
1. **Given** Processing sketch running, **When** receiving data, **Then** radar arc displays correctly
2. **Given** object detected, **When** data received, **Then** blip appears at correct angle/distance
3. **Given** object moves, **When** next sweep occurs, **Then** blip position updates

## Code Template

```cpp
// Servo Radar Scanner - Project 08
#include <Servo.h>
#include <Adafruit_NeoPixel.h>

#define SERVO_PIN 3
#define TRIG_PIN 9
#define ECHO_PIN 10
#define NEOPIXEL_PIN 6
#define NUM_LEDS 8

Servo radarServo;
Adafruit_NeoPixel strip(NUM_LEDS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);

const int SWEEP_DELAY = 30;  // ms between angle steps
const int MAX_DISTANCE = 100; // cm

int distances[NUM_LEDS];  // Store distance for each sector

void setup() {
  Serial.begin(9600);

  radarServo.attach(SERVO_PIN);
  radarServo.write(90);  // Center position

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  strip.begin();
  strip.setBrightness(50);
  strip.show();

  delay(1000);
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

uint32_t distanceToColor(long distance) {
  if (distance == 0 || distance > MAX_DISTANCE) {
    return strip.Color(0, 50, 0);      // Green - clear
  } else if (distance > 50) {
    return strip.Color(0, 255, 0);     // Bright green
  } else if (distance > 25) {
    return strip.Color(255, 255, 0);   // Yellow
  } else {
    return strip.Color(255, 0, 0);     // Red - close object
  }
}

void updateNeoPixels() {
  for (int i = 0; i < NUM_LEDS; i++) {
    strip.setPixelColor(i, distanceToColor(distances[i]));
  }
  strip.show();
}

void loop() {
  // Sweep from 0 to 180
  for (int angle = 0; angle <= 180; angle += 2) {
    radarServo.write(angle);
    delay(SWEEP_DELAY);

    long distance = measureDistance();

    // Output for Processing visualization
    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);

    // Update sector distance
    int sector = map(angle, 0, 180, 0, NUM_LEDS - 1);
    distances[sector] = distance;
    updateNeoPixels();
  }

  // Sweep from 180 to 0
  for (int angle = 180; angle >= 0; angle -= 2) {
    radarServo.write(angle);
    delay(SWEEP_DELAY);

    long distance = measureDistance();

    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);

    int sector = map(angle, 0, 180, 0, NUM_LEDS - 1);
    distances[sector] = distance;
    updateNeoPixels();
  }
}
```

## Required Libraries

- **Servo** (built-in)
- **Adafruit NeoPixel**

## Success Criteria

- [ ] Servo sweeps smoothly without jerking
- [ ] Distance readings are consistent at each angle
- [ ] Serial output is formatted correctly for parsing
- [ ] NeoPixel display accurately represents detected objects

## Troubleshooting

- **Servo jitters**: Ensure adequate power supply, add capacitor across servo power
- **Erratic distance readings**: Slow down sweep, ultrasonic needs time to settle
- **Servo doesn't reach full range**: Calibrate with write() values (some servos are 10-170°)
- **NeoPixels flicker**: Update less frequently, or only on significant changes

## Processing Sketch (Optional)

A basic Processing sketch to visualize the radar data is available online. Search for "Arduino radar Processing" for examples that read the serial data format this project outputs.

## Advanced Challenges

- Add persistence/fade effect so objects leave trails
- Implement object tracking across sweeps
- Add audio ping when objects detected
- Create 3D scan by adding vertical servo

## Next Steps

After completing this project, try:
- Project 09: RGB Mood Light Controller
- Add second ultrasonic sensor for faster scanning
