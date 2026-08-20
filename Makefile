CXX := x86_64-w64-mingw32-g++
CXXFLAGS ?= -std=c++17 -Wall -Wextra -Iinclude
TARGET ?= bin/gatochi.exe
SOURCES := $(wildcard src/*.cpp)
OBJECTS := $(SOURCES:src/%.cpp=bin/%.o)

SFML_MODULES := sfml-graphics sfml-window sfml-system
SFML_CFLAGS ?= $(shell pkg-config --cflags $(SFML_MODULES) 2>/dev/null)
SFML_LIBS ?= $(shell pkg-config --libs $(SFML_MODULES) 2>/dev/null)
ifeq ($(strip $(SFML_LIBS)),)
SFML_LIBS := -lsfml-graphics -lsfml-window -lsfml-system
endif

WINE ?= wine

.PHONY: all build run clean

all: build

build: $(TARGET)

ifeq ($(strip $(SOURCES)),)
$(TARGET):
	@printf '%s\n' 'No hay archivos fuente en src/; se omite la compilacion.'
else
$(TARGET): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(SFML_CFLAGS) $^ -o $@ $(SFML_LIBS)

bin/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(SFML_CFLAGS) -c $< -o $@
endif

run: build
	$(WINE) $(TARGET)

clean:
	rm -f $(OBJECTS) $(TARGET)