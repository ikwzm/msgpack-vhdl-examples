msgpack_object.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object.vhd

pipework_components.o : ../../../../msgpack-vhdl/src/msgpack/pipework/pipework_components.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/pipework_components.vhd

reducer.o : ../../../../msgpack-vhdl/src/msgpack/pipework/reducer.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/reducer.vhd

msgpack_object_code_compare.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_compare.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_compare.vhd

msgpack_object_code_reducer.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_reducer.vhd msgpack_object.o pipework_components.o reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_reducer.vhd

msgpack_object_components.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_components.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_components.vhd

msgpack_structure_stack.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_structure_stack.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_structure_stack.vhd

chopper.o : ../../../../msgpack-vhdl/src/msgpack/pipework/chopper.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/chopper.vhd

queue_register.o : ../../../../msgpack-vhdl/src/msgpack/pipework/queue_register.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/queue_register.vhd

msgpack_kvmap_components.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_components.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_components.vhd

msgpack_kvmap_key_compare.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_compare.vhd msgpack_object.o msgpack_object_components.o msgpack_object_code_compare.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_compare.vhd

msgpack_kvmap_key_match_aggregator.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_match_aggregator.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_match_aggregator.vhd

msgpack_object_code_fifo.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_fifo.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_fifo.vhd

msgpack_object_decode_integer.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_integer.vhd msgpack_object.o pipework_components.o queue_register.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_integer.vhd

msgpack_object_encode_string_constant.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_string_constant.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_string_constant.vhd

msgpack_object_match_aggregator.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_match_aggregator.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_match_aggregator.vhd

msgpack_object_packer.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_packer.vhd msgpack_object.o pipework_components.o reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_packer.vhd

msgpack_object_unpacker.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_unpacker.vhd msgpack_object.o pipework_components.o msgpack_object_components.o reducer.o chopper.o msgpack_structure_stack.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_unpacker.vhd

queue_arbiter.o : ../../../../msgpack-vhdl/src/msgpack/pipework/queue_arbiter.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/queue_arbiter.vhd

msgpack_rpc.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc.vhd

msgpack_rpc_components.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_components.vhd msgpack_object.o msgpack_rpc.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_components.vhd

msgpack_rpc_method_main_with_param.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_main_with_param.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_kvmap_key_compare.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_main_with_param.vhd

msgpack_rpc_method_return_integer.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_integer.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_integer.vhd

msgpack_rpc_method_set_param_integer.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_set_param_integer.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_object_decode_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_set_param_integer.vhd

msgpack_rpc_server_requester.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_requester.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_object_unpacker.o msgpack_object_code_compare.o msgpack_object_match_aggregator.o msgpack_kvmap_key_match_aggregator.o msgpack_object_code_fifo.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_requester.vhd

msgpack_rpc_server_responder.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_responder.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o pipework_components.o queue_arbiter.o msgpack_object_encode_string_constant.o msgpack_object_code_reducer.o msgpack_object_packer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_responder.vhd

msgpack_rpc_server.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server.vhd msgpack_object.o msgpack_rpc.o msgpack_rpc_components.o msgpack_rpc_server_requester.o msgpack_rpc_server_responder.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server.vhd

fib.o : ../../src/main/vhdl/fib.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/fib.vhd

fib_interface.o : ../../src/main/vhdl/fib_interface.vhd msgpack_rpc.o msgpack_object.o msgpack_rpc_components.o msgpack_rpc_method_main_with_param.o msgpack_rpc_method_set_param_integer.o msgpack_rpc_method_return_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/fib_interface.vhd

fibonacci_server.o : ../../src/main/vhdl/fibonacci_server.vhd msgpack_object.o msgpack_rpc.o msgpack_rpc_components.o msgpack_rpc_server.o fib_interface.o fib.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/fibonacci_server.vhd

test_bench.o : ../../src/test/vhdl/test_bench.vhd fibonacci_server.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/test/vhdl/test_bench.vhd

