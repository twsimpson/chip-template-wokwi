# SPDX-FileCopyrightText: © 2022 Uri Shaked <uri@wokwi.com>, 2026 Terence Simpson <kubuntu.tsimpson@gmail.com>
# SPDX-License-Identifier: MIT

CC = /opt/wasi-sdk/bin/clang
CXX = /opt/wasi-sdk/bin/clang++
C_SOURCES = $(wildcard src/*.c)
CXX_SOURCES = $(wildcard src/*.cpp)
C_OBJECTS = $(patsubst %.c,dist/%.o,$(C_SOURCES))
CXX_OBJECTS = $(patsubst %.cpp,dist/%.o,$(CXX_SOURCES))
OBJECTS = $(C_OBJECTS) $(CXX_OBJECTS)
TARGET  = dist/chip.wasm

.PHONY: all
all: $(TARGET) dist/chip.json

.PHONY: clean
clean:
	rm -rf dist

dist:
	mkdir -p dist/src

dist/%.o: %.c
	$(CC) --target=wasm32-unknown-wasip1 -Werror -O2 $< -o -c $@

dist/%.o: %.cpp
	$(CXX) --target=wasm32-unknown-wasip1 -Werror -O2 -c $< -o $@

$(TARGET): dist $(OBJECTS)
	@echo $(OBJECTS)
	$(CXX) --target=wasm32-unknown-wasip1 -nostartfiles -Wl,--import-memory -Wl,--export-table -Wl,--no-entry -Werror -o $(TARGET) $(OBJECTS)

dist/chip.json: dist chip.json
	cp chip.json dist

.PHONY: test
test:
	cd test && arduino-cli compile -e -b arduino:avr:uno blink
