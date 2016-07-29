
DUMMY_PLUG_PATH      = ../../../../../Dummy_Plug
DUMMY_PLUG_SRC_PATH  = $(DUMMY_PLUG_PATH)/src/main/vhdl
DUMMY_PLUG_WORK_PATH = $(DUMMY_PLUG_PATH)/sim/ghdl/dummy_plug
DUMMY_PLUG_TOOL_PATH = $(DUMMY_PLUG_PATH)/tools

SRC_PATH             = ../../../src

COPY       = cp
REMOVE     = -rm
GHDL       = ghdl
GHDLFLAGS  = --mb-comments -P$(DUMMY_PLUG_WORK_PATH)

test   : test_bench.o dut $(SRC_PATH)/test/scenarios/test_92.snr 
	$(COPY) $(SRC_PATH)/test/scenarios/test_92.snr test.snr
	$(GHDL) -e $(GHDLFLAGS) --work=msgpack TEST_BENCH
	$(GHDL) -r $(GHDLFLAGS) --work=msgpack TEST_BENCH

clean  : 
	$(REMOVE) *.o *.cf

dut    : fibonacci_server.o

sources.mk   : sources.yml
	../../../../../PipeWork/tools/vhdl-archiver.rb -v --config sources.yml > sources.mk

include sources.mk

