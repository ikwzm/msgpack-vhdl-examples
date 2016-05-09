all: msgpack_altera.vhd pipework_altera.vhd

msgpack_altera.vhd  : 
	../../../../../../PipeWork/tools/vhdl-archiver.rb -v  \
	    --library MsgPack                     \
	    --archive msgpack_altera.vhd          \
	    ../../../../../../msgpack-vhdl/src    \
	    --library work                        \
	    --top Accumulator_Server              \
	    ./accumulator_server/                 \
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

