#!/bin/bash
DEVICE=${1:-25k}
make -f Makefile clean
make -f Makefile DEVICE=$DEVICE
openFPGALoader -c dirtyJtag -f soc.bit

