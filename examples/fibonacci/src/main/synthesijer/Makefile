SYNTHESIJER ?= ../synthesijer/bin
JAVA_SOURCES = Fib.java 
             $(END_LIST)
#OPT = --chaining --ip-exact=HW
#OPT = --ip-exact=HW
CLASSES = $(JAVA_SOURCES:.java=.class)
VHDL_SOURCES = $(JAVA_SOURCES:.java=.vhd)
VERILOG_SOURCES = $(SOURCES:.java=.v)

RPC_IF_GEN  = ../../../../../msgpack-vhdl/tools/msgpack-rpc-synthesijer-ifgen

all: $(JAVA_SOURCES) Fib_Interface.vhd

$(VHDL_SOURCES)   : $(JAVA_SOURCES)
	java -cp $(SYNTHESIJER):. synthesijer.Main --vhdl --verilog $(OPT) $(JAVA_SOURCES)

Fib_Interface.vhd : $(VHDL_SOURCES)
	$(RPC_IF_GEN) -v $(VHDL_SOURCES)

clean:
	-rm -f $(CLASSES)
	-rm -f *.class
	-rm -f $(VHDL_SOURCES)
	-rm -f $(VERILOG_SOURCES)
	-rm -f *.xml
	-rm -f *.dot
	-rm -f *.o
	-rm -f *.vcd
	-rm -f work-obj93.cf
	-rm -f *.svg
	-rm -f *.txt

