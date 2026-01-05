# Project Specification: Temperature Monitor

**Project Number**: 05
**Difficulty**: Basic
**Created**: 2026-01-02
**Status**: Draft

## Overview

Build a temperature monitoring system that reads ambient temperature and displays it via Serial Monitor. Visual LED indicators show if temperature is in comfortable range.

## Learning Objectives

- Interface with digital temperature sensors
- Parse sensor data and convert to meaningful units
- Display data via Serial communication
- Create visual feedback with multiple LEDs

## Components Required

| Qty | Component | From Inventory |
|-----|-----------|----------------|
| 1 | Arduino Nano 3.0 | Yes |
| 1 | Temperature Sensor (DS18B20 or DHT11) | Yes - 37-in-1 Sensor Kit |
| 1 | Blue 5mm LED (cold indicator) | Yes - LED Kit |
| 1 | Green 5mm LED (comfortable indicator) | Yes - LED Kit |
| 1 | Red 5mm LED (hot indicator) | Yes - LED Kit |
| 3 | 220-330 ohm resistor | Yes - Resistor Kit |
| 1 | 4.7K ohm resistor (for DS18B20) | Yes - Resistor Kit |

## Circuit Description

Temperature sensor provides digital readings. Three LEDs indicate temperature zones.

### Connections (DHT11 Module - most common in kits)
- Sensor VCC → 5V
- Sensor GND → GND
- Sensor DATA → Arduino D2
- Arduino D9 → 220Ω → Blue LED → GND (Cold: <18°C)
- Arduino D10 → 220Ω → Green LED → GND (Comfortable: 18-26°C)
- Arduino D11 → 220Ω → Red LED → GND (Hot: >26°C)

### Connections (DS18B20)
- Sensor VCC → 5V
- Sensor GND → GND
- Sensor DATA → Arduino D2
- 4.7KΩ pull-up resistor between DATA and VCC

## User Scenarios & Testing

### Scenario 1 - Serial Temperature Display (Priority: P1)

Display current temperature reading on Serial Monitor.

**Why this priority**: Core monitoring functionality

**Acceptance Criteria**:
1. **Given** sensor is connected, **When** Serial Monitor opened, **Then** temperature displays in °C
2. **Given** system running, **When** temperature changes, **Then** display updates every 2 seconds
3. **Given** any temperature, **When** reading taken, **Then** both °C and °F shown

### Scenario 2 - LED Zone Indicators (Priority: P2)

Visual indication of temperature comfort zone.

**Acceptance Criteria**:
1. **Given** temperature < 18°C, **When** reading taken, **Then** only blue LED lit
2. **Given** temperature 18-26°C, **When** reading taken, **Then** only green LED lit
3. **Given** temperature > 26°C, **When** reading taken, **Then** only red LED lit

### Scenario 3 - Min/Max Tracking (Priority: P3)

Track and display minimum and maximum temperatures since startup.

**Acceptance Criteria**:
1. **Given** system running, **When** new max reached, **Then** max value updates
2. **Given** system running, **When** new min reached, **Then** min value updates
3. **Given** command received, **When** 'r' sent via Serial, **Then** min/max reset

## Code Template

```cpp
// Temperature Monitor - Project 05
// Using DHT11 - requires DHT library

#include <DHT.h>

#define DHT_PIN 2
#define DHT_TYPE DHT11

const int BLUE_LED = 9;    // Cold
const int GREEN_LED = 10;  // Comfortable
const int RED_LED = 11;    // Hot

const float COLD_THRESHOLD = 18.0;
const float HOT_THRESHOLD = 26.0;

DHT dht(DHT_PIN, DHT_TYPE);

float minTemp = 100.0;
float maxTemp = -40.0;

void setup() {
  Serial.begin(9600);
  dht.begin();

  pinMode(BLUE_LED, OUTPUT);
  pinMode(GREEN_LED, OUTPUT);
  pinMode(RED_LED, OUTPUT);

  Serial.println("Temperature Monitor Started");
  Serial.println("===========================");
}

void loop() {
  float tempC = dht.readTemperature();
  float tempF = dht.readTemperature(true);

  if (isnan(tempC)) {
    Serial.println("Error reading sensor!");
    return;
  }

  // Update min/max
  if (tempC < minTemp) minTemp = tempC;
  if (tempC > maxTemp) maxTemp = tempC;

  // Display
  Serial.print("Temperature: ");
  Serial.print(tempC);
  Serial.print("°C / ");
  Serial.print(tempF);
  Serial.print("°F  [Min: ");
  Serial.print(minTemp);
  Serial.print("°C, Max: ");
  Serial.print(maxTemp);
  Serial.println("°C]");

  // LED indicators
  digitalWrite(BLUE_LED, tempC < COLD_THRESHOLD);
  digitalWrite(GREEN_LED, tempC >= COLD_THRESHOLD && tempC <= HOT_THRESHOLD);
  digitalWrite(RED_LED, tempC > HOT_THRESHOLD);

  delay(2000);
}
```

## Required Libraries

- **DHT sensor library** by Adafruit (for DHT11/DHT22)
- Or **OneWire** + **DallasTemperature** (for DS18B20)

Install via Arduino IDE: Sketch → Include Library → Manage Libraries

## Success Criteria

- [ ] Temperature readings are accurate (±2°C of known reference)
- [ ] Serial output updates regularly
- [ ] LED indicators match temperature zones
- [ ] Min/Max tracking works correctly

## Troubleshooting

- **"Error reading sensor"**: Check wiring, especially data pin
- **Readings are wrong**: Verify sensor type matches code (DHT11 vs DHT22)
- **Readings are 0 or NaN**: Ensure library is installed, check pull-up resistor
- **LEDs don't match readings**: Verify threshold values and pin assignments

## Calibration

If readings seem off:
1. Compare with known thermometer
2. DHT11 accuracy is ±2°C (DHT22 is better at ±0.5°C)
3. Allow sensor to stabilize for 2-3 minutes after power-on

## Next Steps

After completing this project, try:
- Project 06: Ultrasonic Distance Display (intermediate)
- Add humidity reading (DHT11 supports this)
- Add data logging to track temperature over time
