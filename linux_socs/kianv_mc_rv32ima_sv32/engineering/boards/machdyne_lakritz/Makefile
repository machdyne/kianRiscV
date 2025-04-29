###################################################################
# Makefile for Kianv RISC-V SoC Project
#
# Adjusted for a directory structure with the Makefile in a folder
# that is two levels deeper relative to source files.
###################################################################

# NOTE:
# You must set also QUAD_SPI_FLASH_MODE 1'b0 in defines_soc.vh

# Project Configuration
DEVICE ?= 25k
PROJ = soc
SYSTEM_FREQUENCY ?= 50000000
DEFINES = -DSOC_IS_ECP5 -DSOC_HAS_SDRAM_MT48LC16M16A2
DEFINES += -DSOC_HAS_1LED -DSOC_HAS_EXT_FLASH -DSOC_HAS_NETWORK
DEFINES += -DSDRAM_SIZE=$$((1024*1024*32))
DEFINES += -DNUM_ENTRIES_ITLB=64 -DNUM_ENTRIES_DTLB=64 -DICACHE_ENTRIES_PER_WAY=64
DEFINES += -DTRP_NS=15
DEFINES += -DTRC_NS=60
DEFINES += -DTRCD_NS=15
DEFINES += -DTCH_NS=2
DEFINES += -DCAS=2

RM = rm -rf

LPF_FILE = ./lakritz_v0.lpf --lpf-allow-unconstrained
include ../sources.mk

# Build all steps to generate the final bitstream
all: ${PROJ}.bit

# Synthesis: Generate the JSON file
${PROJ}.json: $(SRCS)
	yosys -q $(DEFINES) -DSYSTEM_CLK=${SYSTEM_FREQUENCY} -p \
        "synth_ecp5 -abc9 -json $@ -top ${PROJ}" $^

# Place and route: Generate the config file
${PROJ}_out.config: ${PROJ}.json
ifeq ($(DEVICE),um-85k)
	@echo "Using um-85k configuration"
	nextpnr-ecp5 --freq 250 --speed 7 --timing-allow-fail --json $< --textcfg $@ --um-85k --package CABGA256 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),85k)
	@echo "Using 85k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --85k --package CABGA256 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),25k)
	@echo "Using 25k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --25k --package CABGA256 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),45k)
	@echo "Using 45k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --45k --package CABGA256 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),12k)
	@echo "Using 12k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --12k --package CABGA256 --lpf $(LPF_FILE)
else
	$(error Unknown DEVICE value: $(DEVICE))
endif

# Bitstream generation: Pack the config file into a bitstream
${PROJ}.bit: ${PROJ}_out.config
	ecppack --compress --input $< --bit $@

# Clean up build artifacts
.PHONY: clean
clean:
	$(RM) *.bit *.config *.json

