
DTC=dtc
COPY=cp
BOOTGEN=bootgen
FSBL_ELF_FILE=../project/project.sdk/fsbl/Debug/fsbl.elf
FPGA_BIT_FILE=../project/project.runs/impl_1/design_1_wrapper.bit
BOOT_ELF_FILE=../../../../../../lib/fpga/xilinx/zybo_test_1/boot/u-boot.elf
DEVICETREE_SOURCE=../../../../../../lib/fpga/xilinx/zybo_test_1/dts/Linux-Digilent-Dev/devicetree.dts

devicetree.dtb : devicetree.dts
	$(DTC) -I dts -O dtb -o $@ $<

devicetree.dts : $(DEVICETREE_SOURCE)
	$(COPY) $< $@

BOOT.bin       : u-boot.bif $(FSBL_ELF_FILE) $(FPGA_BIT_FILE) $(BOOT_ELF_FILE)
	$(BOOTGEN) -image u-boot.bif -w on -o BOOT.bin

u-boot.bif     : 
	echo "the_ROM_image:"                 >  u-boot.bif
	echo "{"                              >> u-boot.bif
	echo "  [bootloader]"$(FSBL_ELF_FILE) >> u-boot.bif
	echo " "$(FPGA_BIT_FILE)              >> u-boot.bif
	echo " "$(BOOT_ELF_FILE)              >> u-boot.bif
	echo "}"                              >> u-boot.bif

