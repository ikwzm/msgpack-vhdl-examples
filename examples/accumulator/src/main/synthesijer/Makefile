SYNTHESIJER ?= ../synthesijer/bin
SOURCES = Accumulator.java 
          $(END_LIST)

#OPT = --chaining --ip-exact=HW
#OPT = --ip-exact=HW
CLASSES = $(SOURCES:.java=.class)
VHDL_SOURCES = $(SOURCES:.java=.vhd)
VERILOG_SOURCES = $(SOURCES:.java=.v)

all: $(SOURCES)
	java -cp $(SYNTHESIJER):. synthesijer.Main --vhdl --verilog $(OPT) $(SOURCES)

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

