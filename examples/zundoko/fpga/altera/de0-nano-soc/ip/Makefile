all: msgpack_altera.vhd \
     pipework_altera.vhd \
     zundoko_server/tinymt32.vhd \
     zundoko_server/zundoko_main.vhd \
     zundoko_server/zundoko_interface.vhd \
     zundoko_server/zundoko_server.vhd


msgpack_altera.vhd  : 
	../../../../../../PipeWork/tools/vhdl-archiver.rb -v  \
	    --library MsgPack                     \
	    --archive msgpack_altera.vhd          \
	    ../../../../../../msgpack-vhdl/src    \
	    --library work                        \
	    --top Zundoko_Server                  \
	    ./zundoko_server/                     \
	    $(ENDLIST)

pipework_altera.vhd :
	../../../../../../PipeWork/tools/vhdl-archiver.rb -v  \
            --library PipeWork                    \
            --use 'SDPRAM(ALTERA_AUTO_SELECT)'    \
            --use 'QUEUE_ARBITER(INTEGER_ARCH)'   \
            --archive pipework_altera.vhd         \
            ../../../../../../PipeWork/src/       \
	    --library work                        \
	    --top LED8_AXI                        \
	    --top PTTY_AXI4                       \
	    ./ikwzm_pipework_led8_axi_0.1/        \
	    ./ikwzm_pipework_ptty_axi4_0.1/       \
	    $(ENDLIST)


zundoko_server/tinymt32.vhd           : ../../../../src/main/vhdl/tinymt32.vhd
	cp $< $@

zundoko_server/zundoko_interface.vhd  : ../../../../src/main/vhdl/zundoko_interface.vhd
	cp $< $@

zundoko_server/zundoko_main.vhd       : ../../../../src/main/vhdl/zundoko_main.vhd
	cp $< $@

zundoko_server/zundoko_server.vhd     : ../../../../src/main/vhdl/zundoko_server.vhd
	cp $< $@
