# Project Specification: Ultrasonic Distance Display

**Project Number**: 06
**Difficulty**: Intermediate
**Created**: 2026-01-02
**Status**: Draft

## Overview

Use an ultrasonic distance sensor to measure distance and display it visually on the NeoPixel LED strip. The number of lit LEDs indicates proximity - a visual "parking sensor" style display.

## Learning Objectives

- Interface with HC-SR04 ultrasonic sensor
- Understand pulse timing and distance calculation
- Control addressable RGB LEDs (NeoPixels)
- Map sensor values to visual output

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | HC-SR04 Ultrasonic Sensor | Yes - Ultrasonic Module Pack |
| 1 | Adafruit NeoPixel Stick (8 LEDs) | Yes |

## Circuit Description

Ultrasonic sensor measures distance via sound pulses. NeoPixel strip provides visual feedback.

### Connections
- HC-SR04 VCC → 5V
- HC-SR04 GND → GND
- HC-SR04 TRIG → Arduino D9
- HC-SR04 ECHO → Arduino D10
- NeoPixel VCC → 5V
- NeoPixel GND → GND
- NeoPixel DIN → Arduino D6

## User Scenarios & Testing

### Scenario 1 - Distance Bar Graph (Priority: P1)

Number of lit LEDs corresponds to distance (closer = more LEDs).

**Why this priority**: Core functionality demonstrating sensor-to-display mapping

**Acceptance Criteria**:
1. **Given** object >80cm away, **When** measured, **Then** 0-1 LEDs lit (green)
2. **Given** object 40-80cm away, **When** measured, **Then** 2-4 LEDs lit (yellow)
3. **Given** object 20-40cm away, **When** measured, **Then** 5-6 LEDs lit (orange)
4. **Given** object <20cm away, **When** measured, **Then** 7-8 LEDs lit (red)

### Scenario 2 - Continuous Color Gradient (Priority: P2)

Single smooth color transition across all LEDs based on distance.

**Acceptance Criteria**:
1. **Given** object far away, **When** measured, **Then** all LEDs show cool blue/green
2. **Given** object approaching, **When** distance decreases, **Then** color shifts toward red
3. **Given** object very close, **When** measured, **Then** all LEDs show bright red

### Scenario 3 - Alert Flash Mode (Priority: P3)

LEDs flash rapidly when object is within critical distance.

**Acceptance Criteria**:
1. **Given** object >15cm, **When** measured, **Then** LEDs show solid color
2. **Given** object <15cm, **When** measured, **Then** red LEDs flash at 5Hz
3. **Given** object moves away, **When** >15cm again, **Then** flashing stops

## Code Template

```cpp
// Ultrasonic Distance Display - Project 06
#include <Adafruit_NeoPixel.h>

#define TRIG_PIN 9
#define ECHO_PIN 10
#define NEOPIXEL_PIN 6
#define NUM_LEDS 8

Adafruit_NeoPixel strip(NUM_LEDS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);

const int MAX_DISTANCE = 100;  // cm
const int MIN_DISTANCE = 5;    // cm

void setup() {
  Serial.begin(9600);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  strip.begin();
  strip.setBrightness(50);
  strip.show();
}

long measureDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH, 30000);
  long distance = duration * 0.034 / 2;

  return distance;
}

void loop() {
  long distance = measureDistance();

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // Map distance to number of LEDs (inverted: closer = more LEDs)
  int numLeds = map(distance, MIN_DISTANCE, MAX_DISTANCE, NUM_LEDS, 0);
  numLeds = constrain(numLeds, 0, NUM_LEDS);

  // Clear all LEDs
  strip.clear();

  // Light up LEDs with color based on distance
  for (int i = 0; i < numLeds; i++) {
    uint32_t color;
    if (numLeds <= 2) {
      color = strip.Color(0, 255, 0);      // Green - far
    } else if (numLeds <= 4) {
      color = strip.Color(255, 255, 0);    // Yellow - medium
    } else if (numLeds <= 6) {
      color = strip.Color(255, 128, 0);    // Orange - close
    } else {
      color = strip.Color(255, 0, 0);      // Red - very close
    }
    strip.setPixelColor(i, color);
  }

  strip.show();
  delay(50);
}
```

## Required Libraries

- **Adafruit NeoPixel** library

Install via Arduino IDE: Sketch → Include Library → Manage Libraries → Search "Adafruit NeoPixel"

## Success Criteria

- [ ] Distance readings are accurate (±2cm)
- [ ] LED display updates smoothly without flicker
- [ ] Color zones clearly indicate distance ranges
- [ ] Response time feels immediate (<100ms)

## Troubleshooting

- **Distance always 0**: Check TRIG/ECHO wiring, ensure sensor powered
- **Erratic readings**: Add filtering (average of 3-5 readings)
- **NeoPixels wrong color**: Check NEO_GRB vs NEO_RGB in strip initialization
- **LEDs very dim**: Increase setBrightness() value (max 255)

## Advanced Challenges

- Add smoothing filter to prevent jittery display
- Implement different animation modes (pulse, chase, rainbow)
- Add audio feedback with buzzer for parking sensor effect

## Next Steps

After completing this project, try:
- Project 07: Motion-Activated Light
- Combine with servo for scanning radar display
