msgpack_object.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object.vhd

msgpack_kvmap_components.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_components.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_components.vhd

msgpack_kvmap_key_match_aggregator.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_match_aggregator.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_match_aggregator.vhd

msgpack_kvmap_dispatcher.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_dispatcher.vhd msgpack_object.o msgpack_kvmap_components.o msgpack_kvmap_key_match_aggregator.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_dispatcher.vhd

pipework_components.o : ../../../../msgpack-vhdl/src/msgpack/pipework/pipework_components.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/pipework_components.vhd

queue_register.o : ../../../../msgpack-vhdl/src/msgpack/pipework/queue_register.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/queue_register.vhd

reducer.o : ../../../../msgpack-vhdl/src/msgpack/pipework/reducer.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/reducer.vhd

msgpack_kvmap_get_value.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_get_value.vhd msgpack_object.o msgpack_kvmap_components.o msgpack_kvmap_dispatcher.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_get_value.vhd

msgpack_kvmap_set_value.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_set_value.vhd msgpack_object.o msgpack_kvmap_components.o msgpack_kvmap_dispatcher.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_set_value.vhd

msgpack_object_code_compare.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_compare.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_compare.vhd

msgpack_object_code_reducer.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_reducer.vhd msgpack_object.o pipework_components.o reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_reducer.vhd

msgpack_object_components.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_components.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_components.vhd

msgpack_object_decode_integer.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_integer.vhd msgpack_object.o pipework_components.o queue_register.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_integer.vhd

msgpack_object_decode_map.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_map.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_map.vhd

msgpack_object_encode_map.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_map.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_map.vhd

msgpack_structure_stack.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_structure_stack.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_structure_stack.vhd

chopper.o : ../../../../msgpack-vhdl/src/msgpack/pipework/chopper.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/pipework/chopper.vhd

msgpack_rpc.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc.vhd

msgpack_kvmap_decode_get_stream_parameter.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_decode_get_stream_parameter.vhd msgpack_object.o msgpack_object_components.o msgpack_object_decode_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_decode_get_stream_parameter.vhd

msgpack_kvmap_get_map_value.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_get_map_value.vhd msgpack_object.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_object_decode_map.o msgpack_kvmap_get_value.o msgpack_object_encode_map.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_get_map_value.vhd

msgpack_kvmap_key_compare.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_compare.vhd msgpack_object.o msgpack_object_components.o msgpack_object_code_compare.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_key_compare.vhd

msgpack_kvmap_set_map_value.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_set_map_value.vhd msgpack_object.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_object_decode_map.o msgpack_kvmap_set_value.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_set_map_value.vhd

msgpack_object_code_fifo.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_fifo.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_code_fifo.vhd

msgpack_object_decode_array.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_array.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_decode_array.vhd

msgpack_object_encode_array.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_array.vhd msgpack_object.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_array.vhd

msgpack_object_encode_integer.o : ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_integer.vhd msgpack_object.o msgpack_object_components.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/object/msgpack_object_encode_integer.vhd

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

msgpack_rpc_components.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_components.vhd msgpack_object.o msgpack_rpc.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_components.vhd

msgpack_rpc_method_return_code.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_code.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_code.vhd

msgpack_rpc_method_return_nil.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_nil.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_nil.vhd

msgpack_kvmap_get_integer.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_get_integer.vhd msgpack_object.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_kvmap_key_compare.o msgpack_kvmap_decode_get_stream_parameter.o msgpack_object_encode_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_get_integer.vhd

msgpack_kvmap_set_integer.o : ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_set_integer.vhd msgpack_object.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_kvmap_key_compare.o msgpack_object_decode_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/kvmap/msgpack_kvmap_set_integer.vhd

msgpack_rpc_method_main_with_param.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_main_with_param.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_kvmap_key_compare.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_main_with_param.vhd

msgpack_rpc_method_return_integer.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_integer.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_return_integer.vhd

msgpack_rpc_method_set_param_integer.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_set_param_integer.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_object_decode_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_method_set_param_integer.vhd

msgpack_rpc_server_kvmap_get_value.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_kvmap_get_value.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_rpc_components.o msgpack_kvmap_components.o msgpack_kvmap_key_compare.o msgpack_object_code_reducer.o msgpack_object_decode_array.o msgpack_kvmap_get_map_value.o msgpack_object_encode_array.o msgpack_rpc_method_return_code.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_kvmap_get_value.vhd

msgpack_rpc_server_kvmap_set_value.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_kvmap_set_value.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_rpc_components.o msgpack_kvmap_components.o msgpack_kvmap_key_compare.o msgpack_object_code_reducer.o msgpack_object_decode_array.o msgpack_kvmap_set_map_value.o msgpack_rpc_method_return_nil.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_kvmap_set_value.vhd

msgpack_rpc_server_requester.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_requester.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o msgpack_kvmap_components.o msgpack_object_unpacker.o msgpack_object_code_compare.o msgpack_object_match_aggregator.o msgpack_kvmap_key_match_aggregator.o msgpack_object_code_fifo.o msgpack_object_code_reducer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_requester.vhd

msgpack_rpc_server_responder.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_responder.vhd msgpack_object.o msgpack_rpc.o msgpack_object_components.o pipework_components.o queue_arbiter.o msgpack_object_encode_string_constant.o msgpack_object_code_reducer.o msgpack_object_packer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server_responder.vhd

msgpack_rpc_server.o : ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server.vhd msgpack_object.o msgpack_rpc.o msgpack_rpc_components.o msgpack_rpc_server_requester.o msgpack_rpc_server_responder.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../../../msgpack-vhdl/src/msgpack/rpc/msgpack_rpc_server.vhd

Accumulator.o : ../../src/main/synthesijer/Accumulator.vhd 
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/synthesijer/Accumulator.vhd

add_interface.o : ../../src/main/vhdl/add_interface.vhd msgpack_rpc.o msgpack_object.o msgpack_rpc_components.o msgpack_rpc_method_main_with_param.o msgpack_rpc_method_set_param_integer.o msgpack_rpc_method_return_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/add_interface.vhd

get_interface.o : ../../src/main/vhdl/get_interface.vhd msgpack_rpc.o msgpack_object.o msgpack_rpc_components.o msgpack_kvmap_components.o msgpack_rpc_server_kvmap_get_value.o msgpack_kvmap_get_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/get_interface.vhd

set_interface.o : ../../src/main/vhdl/set_interface.vhd msgpack_rpc.o msgpack_object.o msgpack_rpc_components.o msgpack_kvmap_components.o msgpack_rpc_server_kvmap_set_value.o msgpack_kvmap_set_integer.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/set_interface.vhd

accumulator_server.o : ../../src/main/vhdl/accumulator_server.vhd msgpack_object.o msgpack_rpc.o msgpack_rpc_components.o msgpack_rpc_server.o add_interface.o set_interface.o get_interface.o Accumulator.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/main/vhdl/accumulator_server.vhd

test_bench.o : ../../src/test/vhdl/test_bench.vhd accumulator_server.o
	ghdl -a -C $(GHDLFLAGS) --work=MSGPACK ../../src/test/vhdl/test_bench.vhd

