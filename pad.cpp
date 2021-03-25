#include <Arduino.h>
#include "config.h"

#define PAD_DATA_1_PIN A2
#define PAD_DATA_0_PIN A3
#define PAD_CLOCK_PIN A4
#define PAD_LATCH_PIN A5

uint16_t keys[2] = { 0, 0 };
uint8_t state = 0;

void padSetup()
{
  pinMode(PAD_DATA_0_PIN, INPUT);
  pinMode(PAD_DATA_1_PIN, INPUT);
  pinMode(PAD_CLOCK_PIN, OUTPUT);
  pinMode(PAD_LATCH_PIN, OUTPUT);
  digitalWrite(PAD_DATA_0_PIN, HIGH);
  digitalWrite(PAD_DATA_1_PIN, HIGH);
  digitalWrite(PAD_CLOCK_PIN, HIGH);
  digitalWrite(PAD_LATCH_PIN, HIGH);
}

uint16_t *readJoy()
{
  return keys;
}

void keyboardIREvent(uint8_t t, uint8_t v)
{
}

void padPoll()
{
  switch (state)
  {
  case 0:
    digitalWrite(PAD_LATCH_PIN, LOW);
    break;

  case 1:
    keys[0] = (keys[0] & ~FIRE) | (digitalRead(PAD_DATA_0_PIN) ? 0 : FIRE);
    keys[1] = (keys[1] & ~FIRE) | (digitalRead(PAD_DATA_1_PIN) ? 0 : FIRE);
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 2:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 3:
    // Face right not used.
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 4:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 5:
    keys[0] = (keys[0] & ~SELECT) | (digitalRead(PAD_DATA_0_PIN) ? 0 : SELECT);
    keys[1] = (keys[1] & ~SELECT) | (digitalRead(PAD_DATA_1_PIN) ? 0 : SELECT);
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 6:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 7:
    keys[0] = (keys[0] & ~RESET) | (digitalRead(PAD_DATA_0_PIN) ? 0 : RESET);
    keys[1] = (keys[1] & ~RESET) | (digitalRead(PAD_DATA_1_PIN) ? 0 : RESET);
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 8:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 9:
    keys[0] = (keys[0] & ~UP) | (digitalRead(PAD_DATA_0_PIN) ? 0 : UP);
    keys[1] = (keys[1] & ~UP) | (digitalRead(PAD_DATA_1_PIN) ? 0 : UP);
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 10:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 11:
    keys[0] = (keys[0] & ~DOWN) | (digitalRead(PAD_DATA_0_PIN) ? 0 : DOWN);
    keys[1] = (keys[1] & ~DOWN) | (digitalRead(PAD_DATA_1_PIN) ? 0 : DOWN);
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 12:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 13:
    keys[0] = (keys[0] & ~LEFT) | (digitalRead(PAD_DATA_0_PIN) ? 0 : LEFT);
    keys[1] = (keys[1] & ~LEFT) | (digitalRead(PAD_DATA_1_PIN) ? 0 : LEFT);
    digitalWrite(PAD_CLOCK_PIN, LOW);
    break;

  case 14:
    digitalWrite(PAD_CLOCK_PIN, HIGH);
    break;

  case 15:
    keys[0] = (keys[0] & ~RIGHT) | (digitalRead(PAD_DATA_0_PIN) ? 0 : RIGHT);
    keys[1] = (keys[1] & ~RIGHT) | (digitalRead(PAD_DATA_1_PIN) ? 0 : RIGHT);
    digitalWrite(PAD_LATCH_PIN, HIGH);
    state = 0;
    return;
  }

  state++;
}
