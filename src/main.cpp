// For information and examples see:
// https://docs.wokwi.com/chips-api/getting-started

#include "wokwi-api.h"
#include <cstdio>

typedef struct {
  // Put chip data here
} chip_state_t;

void chip_init(void)
{
  chip_state_t *chip = malloc(sizeof(chip_state_t));
  
  // Initialize chip here

  std::puts("Online!");
}
