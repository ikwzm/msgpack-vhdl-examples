
DTC=dtc
COPY=cp
REMOVE=rm -f
BOOTGEN=bootgen
FSBL_ELF_FILE=../project/project.sdk/fsbl/Debug/fsbl.elf
FPGA_BIT_FILE=../project/project.runs/impl_1/design_1_wrapper.bit
BOOT_ELF_FILE=../../../../../../lib/fpga/xilinx/zybo_test_1/boot/u-boot-2016.01-00448-g0289ee8.elf
UENV_TXT_FILE=../../../../../../lib/fpga/xilinx/zybo_test_1/boot/uEnv.txt
DEVICETREE_SOURCE=../../../../../../lib/fpga/xilinx/zybo_test_1/dts/linux-4.4/devicetree.dts

all: BOOT.bin devicetree.dtb uEnv.txt

clean:
	-$(REMOVE) BOOT.bin devicetree.dtb uEnv.txt

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

uEnv.txt       : $(UENV_TXT_FILE)
	$(COPY) $< $@
