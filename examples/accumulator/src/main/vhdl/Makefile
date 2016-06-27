RPC_IF_GEN = ../../../../../msgpack-vhdl/tools/msgpack-rpc-synthesijer-ifgen
SYNTHESIJER_VHDL_FILE = ../synthesijer/Accumulator.vhd
INTERFACE_VHDL_FILE   = Accumulator_Interface.vhd
SERVER_VHDL_FILE      = Accumulator_Server.vhd

all: $(INTERFACE_VHDL_FILE) $(SERVER_VHDL_FILE)

$(INTERFACE_VHDL_FILE) :    $(SYNTHESIJER_VHDL_FILE)
	$(RPC_IF_GEN) -v -s $(SYNTHESIJER_VHDL_FILE)

clean:
	rm $(INTERFACE_VHDL_FILE) $(SERVER_VHDL_FILE)
