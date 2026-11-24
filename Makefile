# SPDX-FileCopyrightText: © 2022 Uri Shaked <uri@wokwi.com>, 2026 Terence Simpson <kubuntu.tsimpson@gmail.com>
# SPDX-License-Identifier: MIT

C_SOURCES = $(wildcard src/*.c)
CXX_SOURCES = $(wildcard src/*.cpp)
C_OBJECTS = $(patsubst %.c,%.o,$(C_SOURCES))
CXX_OBJECTS = $(patsubst %.cpp,%.o,$(CXX_SOURCES))
OBJECTS = $(C_OBJECTS) $(CXX_OBJECTS)
TARGET  = dist/chip.wasm

.PHONY: all
all: $(TARGET) dist/chip.json

.PHONY: clean
clean:
	rm -rf dist

dist:
	mkdir -p dist

$(TARGET): dist $(OBJECTS)
	clang++ --target=wasm32-unknown-wasi --sysroot /opt/wasi-libc -nostartfiles -Wl,--import-memory -Wl,--export-table -Wl,--no-entry -Werror -o $(TARGET) $(OBJECTS)

%.o: %.c
	clang --target=wasm32-unknown-wasi --sysroot /opt/wasi-libc -Werror -O2 $< -o $@

%.o: %.cpp
	clang --target=wasm32-unknown-wasi --sysroot /opt/wasi-libc -nostartfiles -Wl,--import-memory -Wl,--export-table -Wl,--no-entry -Werror -O2 $< -o $@

dist/chip.json: dist chip.json
	cp chip.json dist

.PHONY: test
test:
	cd test && arduino-cli compile -e -b arduino:avr:uno blink
