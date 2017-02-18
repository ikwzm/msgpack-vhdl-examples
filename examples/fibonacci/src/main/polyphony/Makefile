RPC_IF_GEN = ../../../../../msgpack-vhdl/tools/msgpack-rpc-ifgen
SOURCE_PYTHON_FILE  = fib.py
SOURCE_VERILOG_FILE = polyphony_out_fib.v
INTERFACE_VHDL_FILE = fibonacci_interface.vhd
SERVER_VHDL_FILE    = fibonacci_server.vhd
CONFIG_YAML_FILE    = fib.yml

all: $(INTERFACE_VHDL_FILE)

$(SOURCE_VERILOG_FILE)   : $(SOURCE_PYTHON_FILE)
	polyphony $(SOURCE_PYTHON_FILE)

$(INTERFACE_VHDL_FILE) : $(CONFIG_YAML_FILE)
	$(RPC_IF_GEN) -v $(CONFIG_YAML_FILE)

clean:
	rm $(INTERFACE_VHDL_FILE) $(SERVER_VHDL_FILE) 

test:	
	-rm $(INTERFACE_VHDL_FILE) $(SERVER_VHDL_FILE) test.log
	$(RPC_IF_GEN) -v $(CONFIG_YAML_FILE)
	touch test.log
	git diff $(INTERFACE_VHDL_FILE) >> test.log
	git diff $(SERVER_VHDL_FILE)    >> test.log
	git diff $(CONFIG_YAML_FILE)    >> test.log
	cat test.log
