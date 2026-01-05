# Jumperless Project Specs

A progressive series of 10 projects to learn electronics and Arduino programming using the Jumperless breadboard.

## Project Overview

| # | Project | Difficulty | Key Components | Learning Focus |
|---|---------|------------|----------------|----------------|
| 01 | [LED Blink](./01-led-blink.md) | Basic | LED, Resistor | Digital output, basic circuits |
| 02 | [Traffic Light](./02-traffic-light.md) | Basic | 3x LEDs, Resistors | Sequential logic, timing |
| 03 | [Button-Controlled LED](./03-button-led.md) | Basic | Button, LED | Digital input, debouncing |
| 04 | [Night Light](./04-night-light.md) | Basic | Light Sensor, LED | Analog input, thresholds |
| 05 | [Temperature Monitor](./05-temperature-monitor.md) | Basic | Temp Sensor, LEDs | Digital sensors, Serial output |
| 06 | [Distance Display](./06-distance-display.md) | Intermediate | Ultrasonic, NeoPixel | Pulse timing, addressable LEDs |
| 07 | [Motion Light](./07-motion-light.md) | Intermediate | PIR, NeoPixel | Motion detection, timeouts |
| 08 | [Servo Radar](./08-servo-radar.md) | Intermediate | Servo, Ultrasonic | Motor control, data visualization |
| 09 | [Mood Light](./09-mood-light.md) | Intermediate | NeoPixel, Pot, Sound | Multi-mode systems, HSV color |
| 10 | [Parking Sensor](./10-parking-sensor.md) | Intermediate | Ultrasonic, NeoPixel, Buzzer | Multi-output integration, EEPROM |

## Recommended Order

**Start here if you're new to Arduino:**
1. LED Blink → Traffic Light → Button LED → Night Light → Temperature Monitor

**Move to intermediate after basics:**
6. Distance Display → Motion Light → Servo Radar → Mood Light → Parking Sensor

## Components Used Across Projects

See [inventory.md](../../memory/inventory.md) for full component list.

### Most Used Components
- Arduino Nano 3.0 (all projects)
- LEDs from 5mm LED Kit (Projects 1-5)
- Adafruit NeoPixel Stick (Projects 6-10)
- HC-SR04 Ultrasonic (Projects 6, 8, 10)
- 37-in-1 Sensor Kit modules (various)

## Required Arduino Libraries

Install via Arduino IDE: Sketch → Include Library → Manage Libraries

| Library | Used In | Purpose |
|---------|---------|---------|
| Adafruit NeoPixel | 6, 7, 8, 9, 10 | Addressable LED control |
| DHT | 5 | Temperature/humidity sensor |
| Servo | 8 | Servo motor control |

## Project Spec Structure

Each spec includes:
- **Overview**: What you'll build
- **Learning Objectives**: Skills you'll gain
- **Components Required**: Parts list with inventory reference
- **Circuit Description**: Wiring guide
- **User Scenarios**: Acceptance criteria (Given/When/Then)
- **Code Template**: Starter code
- **Success Criteria**: Checkboxes for completion
- **Troubleshooting**: Common issues and fixes
- **Next Steps**: Where to go after completion
