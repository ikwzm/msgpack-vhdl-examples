
DTC=dtc
BOOTGEN=bootgen
DEVICETREE_SOURCE=./Linux-Digilent-Dev/devicetree.dts

devicetree.dtb : $(DEVICETREE_SOURCE)
	$(DTC) -I dts -O dtb -o $@ $<

BOOT.bin : u-boot.bif ../project/project.sdk/fsbl/Debug/fsbl.elf  ../project/project.runs/impl_1/design_1_wrapper.bit ../../../../../../lib/obj/zybo/u-boot.elf
	$(BOOTGEN) -image u-boot.bif -w on -o BOOT.bin

