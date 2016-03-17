Synthesijerで作ったモジュールをMessagePack-RPCで制御する(Altera SoC論理合成編)
============================================================================

##はじめに

Synthesijerで作ったモジュールをMessagePack-RPCで制御する一連の記事

 - [アーキテクチャ編](http://qiita.com/ikwzm/items/6cb623b057a687ff4a8e)
 - [IP-Package編](http://qiita.com/ikwzm/items/924fc3fd59bdf7da55a2)
 - [ZYNQ論理合成編](http://qiita.com/ikwzm/items/0254f1d49602095b5cde)
 - [TTYドライバ編](http://qiita.com/ikwzm/items/533b905f7d1eb2e6c4d5)
 - [MessagePack-Ruby編](http://qiita.com/ikwzm/items/f742e2c9b5d9642d8857)

は、Xilinx 社のFPGA(ZYNQ)を対象にしてきましたが、この度ひょんな事から Altera の SoC が載ったボード(DE0-Nano-SoC)を入手したので、こちらにも実装してみました。

[アーキテクチャ編](http://qiita.com/ikwzm/items/6cb623b057a687ff4a8e)と[TTYドライバ編](http://qiita.com/ikwzm/items/533b905f7d1eb2e6c4d5)以降はZYNQの時と同じですので、そちらを参照してください。
この記事では Altera SoC 用に論理合成＆配置配線を行い、preloader、U-boot、Device Tree Blob を作って Linux を起動するまでを説明します。

##開発環境

###開発ツール

 - Altera Quartus Prime Version 15.1.0 Build 185 10/21/2015 SJ Lite Edition
 - Altera SoC EDS(Embedded Design Suite) 15.1 Build 185

###プロジェクトのリポジトリ

 - [msgpack-vhdl-examples (https://github.com/ikwzm/msgpack-vhdl-examples)](https://github.com/ikwzm/msgpack-vhdl-examples)

###必要なIP

 - Accumulator_Server : 前回作ったMessagePack-RPC-Server + Accumulator
 - PTTY_AXI : CPU-Accumulator_Server間の通信用IP [PTTY_AXI (https://github.com/ikwzm/PTTY_AXI)](https://github.com/ikwzm/PTTY_AXI)
 - LED_AXI : ZYNQのLED制御用IP [LED_AXI (https://github.com/ikwzm/LED_AXI)](https://github.com/ikwzm/LED_AXI)
 - messagepack-vhdl : MessagePack-VHDL ライブラリ [messagepack-vhdl(https://github.com/ikwzm/msgpack-vhdl)](https://github.com/ikwzm/msgpack-vhdl)
 - PipeWork : PipeWork ライブラリ [PipeWork(https://github.com/ikwzm/PipeWork)](https://github.com/ikwzm/PipeWork)

##準備

###githubからリポジトリをダウンロード

````
shell% git clone git://github.com/ikwzm/msgpack-vhdl-examples.git msgpack-vhdl-examples
shell% cd msgpack-vhdl-examples
````

###githubからサブモジュールをダウンロード

````
shell% git submodule init
shell% git submodule update
````

###DE0-Nano-SoC用ブランチのプロジェクトディレクトリに移動

````
shell% git checkout accumulator_de0_nano_soc
shell% cd examples/accumulator/fpga/altera/DE0_NANO_SOC
````
###IPを用意する

このブランチではすでに examples/accumulator/fpga/altera/DE0_NANO_SOC/ip に以下の各種 IP を用意しています。

  - accumulator_server : 前回作ったMessagePack-RPC-Server + Accumulator を Qsys から使えるように IP 化したものです。
  - ikwzm_pipework_led8_axi_0.1 : ZYNQのLED制御用IP [LED_AXI (https://github.com/ikwzm/LED_AXI)](https://github.com/ikwzm/LED_AXI)/target/altera/ip/ikwzm_pipework_led8_axi_0.1 のコピーです。
  - ikwzm_pipework_ptty_axi4_0.1 : CPU-Accumulator_Server間の通信用IP [PTTY_AXI(https://github.com/ikwzm/PTTY_AXI)](https://github.com/ikwzm/PTTY_AXI)/target/altera/ip/ikwzm_pipework_ptty_axi4_0.1 のコピーです。
  - msgpack_altera.qip msgpack_altera.vhd :  MessagePack-VHDL ライブラリ の使うものだけをアーカイブした VHDL のソースコードです。
  - pipework_altera.qip pipework_altera.vhd : PipeWork ライブラリ の使うものだけをアーカイブした VHDL のソースコードです。

###デザインを用意する

このブランチではすでに、トップレベルのRTL(DE0_NANO_SOC.v)と、HPSと各種IPを接続した Qsysファイル(soc_system.qsys)を用意しています。

###プロジェクトを作る

このブランチにはすでに Quartus 用のプロジェクト(DE0_NANO_SOC.qpfとDE0_NANO_SOC.qsf)を用意しています。
ただし、最初から用意しているこの Quartus 用のプロジェクト(DE0_NANO_SOC.qpf) は HPS のピン設定がまだされていません。ピンの設定をするには、一度 Qsys を実行して HDL ファイルと Tcl ファイルを生成した後、Qsys が生成した Tcl ファイルを実行する必要がありますこの作業は、一度 make quartus_compile または make sof を実行することで、自動的に行います。

##デザインフロー

Altera SoC で Linux を起動する際の一般的なデザインフローは[「FPGA+SoC+Linuxのブートシーケンス(Altera SoC+EDS編)」](http://qiita.com/ikwzm/items/c22d15803ed98f0e52ab)を参照してください。
また、このプロジェクトではデザインフローを実行するための Makefile を用意しています。Altera SoC EDS が実行出来る環境で make コマンドを実行することにより、以下の工程をGUIを使わずにコマンドラインだけで行うことが出来ます。


### 1. Qsys&Quartus でFPGA Fablicの論理合成と配置配線を行う

Qsys&Quartusを使って論理合成と配置配線を行いFPGA Hardware SRAM Object File(.sof)を生成するには、次のように make コマンドを実行します。

````
shell% make sof
````

これで ./DE0_NANO_SOC.sof が生成されます。

### 2. Convert Program File でSRAM Object File(.sof)からRAW Binary File(.rbf)を生成する

````
shell% make rbf
````

あるいは次のように直接起動してください。

````
shell% quartus_cpf -c -o bitstream_compression=on DE0_NANO_SOC.sof DE0_NANO_SOC.rbf
````
-c はファイル変換(convert)することを示します。
-o bitstream_compression=on で圧縮されたRAW Binary Fileを生成することを示します。
DE0_NANO_SOC.sof には生成されたSRAM Object Fileの名前を、DE0_NANO_SOC.rbf には生成するRAW Binary Fileの名前を指定します。

### 3. sopc2dtsでデバイスツリーを生成する

このプロジェクトでは sopc2dts でデバイスツリーを生成しません。後で直接デバイスツリーを編集します。

### 4. BSP Generatorを使ってPreloader Support Packageを作る

このプロジェクトでは次の工程の make preloader で自動的に Preloader Support Package を作ります。

### 5. preloaderとU-bootをビルドする

````
shell% make preloader 
shell% make uboot
````

make preloader で preloaderのイメージファイル(./software/preloader/preloader-mkpimage.bin)がビルドされます。
make uboot で U-Bootのイメージファイル(./software/preloader/uboot-socfgpa/u-boot.img) がビルドされます。


### 6. prelodaerとu-bootをSD Card の特殊パーティションに書き込む

preloaderのイメージファイル(preloader-mkpimage.bin)と、u-bootのイメージファイルをSD Card特殊パーティションに書き込みます。Linuxの場合、次のようにします(SD Card の特殊パーティションが/dev/sdc3の場合)。

```Shell
shell% dd if=./software/preloader/preloader-mkpimage.bin of=/dev/sdc3 bs=64k seek=0
shell% dd if=./software/preloader/uboot-socfpga/uboot.img of=/dev/sdc3 bs=64k seek=4
```
### 7. Linux Kernel Source から zImageとDevice Tree Blob(.dtb)を作る

Linux Kernelのソースコードを入手してビルドします。最近のLinux は Altera SoC 用のカーネルもビルドできるようになっています。
今回は Linux Kernel 4.4 を DE0-Nano-SoC 用にビルドしました。
ビルドすると、Linux Kernelのイメージと同時に Linux Kernel を起動するための Device Tree Blob($(LINUX_SRC)/arch/arm/boot/socfpga_cyclone5_de0_sockit.dtb)も生成されます。

### 8. デバイスツリーをつくる

ここが一番やっかいかもしれません。Linux Kernelのイメージと同時にビルドした Device Tree Blob(.dtb)に PTTY_AXI4 と LED_AXI のレジスタアドレスや割り込み番号を追加します。
とりあえずこのプロジェクトには Linux Kernel 4.4 用の Device Tree Blob(socfpga.dtb)をあらかじめ用意しています。

別の Linux Kernel 用にDevice Tree Blob を作りたい場合は次のようにします。

####Linux Kernelのイメージと同時にビルドした Device Tree Blob(.dtb)をソースコードに戻す。

DE0-Nano-SoC 用にビルドした時に同時にビルドした Device Tree Blob($(LINUX_SRC)/arch/arm/boot/socfpga_cyclone5_de0_sockit.dtb)をエディタ等で編集できるようにソースコード(socfpga.dts)に変換します。

````
shell% dtc -I dtb -O dts -o socfpga.dts $(LINUX_SRC)/arch/arm/boot/socfpga_cyclone5_de0_sockit.dtb
````

####Device Tree Source(.dts)を編集する

変換したソースコード(socfpga.dts)に PTTY と LED のエントリを追加します。例えば、Linux 4.4 のDevice Tree Blob(.dtb)に追加する場合は、次のように soc エントリの下に追加します。

````dts:socfpga.dts
	soc {
	    :
	  (中略)
	    :
		zptty@0xFF202000 {
			compatible = "ikwzm,zptty-0.10.a";
			minor-number = <0x0>;
			reg = <0xff202000 0x1000>;
			interrupts = <0x0 0x28 0x4>;
		};

		zled@0xFF201000 {
			compatible = "ikwzm,zled-0.10.a";
			reg = <0xff201000 0x1000>;
		};
	};
````

PTTYのエントリは、zptty@0xFF202000 です。ここにレジスタのアドレスと範囲、割り込み番号、デバイスのマイナー番号を指定します。
このプロジェクトでは、PTTYのレジスタアドレスは0xFF202000-0xFF202FFFにアサインしています。
Qsys によって PTTY レジスタのアドレスは HPS の Lightweight HPS2FPGA の 0x00002000-0x00002FFF にアサインしています。
CPU からみた Lightweight HPS2FPGA は 0xFF200000-0xFF3FFFFF にマッピングされているので、CPUからみた PTTY のレジスタの開始アドレスは 0xFF202000(=0xFF200000+0x00002000) になります。

interrupts= の２番目のパラメータの0x28(十進数で40)が割り込み番号を指定しています。
Qsys によって PTTY の割り込みは HPS の FPGA_IRQ0 に接続しています。「Cyclone V Hard Processor System Technical Reference Manual」によれば、FPGA_IRQ0 は汎用割り込みコントローラー(GIC)内の共有ペリフェラル割り込み(SPI)の72番を通じて割り込みがかかります。このパラメータには72から32引いた値を設定するようです。
interrupts=の１番目のパラメータはGIC内部の割り込みの種類を指定します。GIC 内部には共有ペリフェラル割り込み(SPI)の他にCPUプライベートペリフェラル割り込み(PPI)とソフトウェア生成割り込み(SGI)があります。共有ペリフェラル割り込み(SPI)を使う場合は0を指定します。
interrupts=の３番目のパラメータは割り込み信号がエッジトリガーかレベルトリガーかを指定します。1を指定するとエッジトリガー、4を指定するとレベルトリガーになります。

デバイスツリーの詳細はその他の文献を参照してください。正直、かなり判りにくいです。

####Device Tree Blob(.dtb)を生成する

PTTYを追加したDevice Tree Source(.dts)を Device Tree Blob(.dtb)に変換します。

````
shell% dtc -I dts -O dto -o socfpga.dtb socfpga.dts
````


### 9. u-boot.scrを用意する

u-bootがブート時に実行するスクリプト(u-boot.scr)を用意します。

Altera SoC EDS のu-bootはSD Card の第一パーティションにu-boot.scrという名前のファイルがあった場合、ブート時にこのファイルをスクリプトとして実行します。u-boot.scrはテキストファイルではなく、u-bootのスクリプト専用のイメージファイルです。

まず元になるスクリプトをテキストファイルで作ります。


```scr:boot.script
fatload mmc 0:1 $fpgadata DE0_NANO_SOC.rbf;
fpga load 0 $fpgadata $filesize;
set fdtimage socfpga.dtb;
run bridge_enable_handoff;
run mmcload;
run mmcboot;
```

この例では、次のようにブートします。

 1. DE0_NANO_SOC.rbfという名前のRAW Binary File(.rbf) を変数$fpgadataで示されるメモリアドレスにロード。
 2. 変数$fpgadataで示されるメモリアドレスにロードしたDE0_NANO_SOC.rbfのデータをFPGAにロード。
 3. 変数fdtimageにDevice Tree Blobのファイル名(ここではsocfpga.dtb)をセット。
 4. run bridge_enable_handoff というコマンドでFPGAとHPSとのインターフェースをイネーブルにする。
 5. run mmcload でzImageと変数fdtimageに設定されているDevice Tree Blobをメモリにロード。
 6. run mmcboot でメモリにロードしたzImageをブート。

また、boot.script は make で生成することもできます。

````
shell% make boot.script
````

この boot.script をu-bootイメージファイル(u-boot.scr)に変換します。変換にはU-bootをビルドしたときに同時にビルドされたツールを使います。

```
shell% ./software/preloader/uboot-socfpga/tools/mkimage  -A arm -O linux -T script -C none -a 0 -e 0 -n "bootscript" -d boot.script u-boot.scr
```

または

````
shell% make u-boot.scr
````

### 10. SD Card の第１パーティション(FAT File System)にzImage、Device Tree Blob(.dtb)、RAW Binary File(.rbf)、u-boot.scrを置く

SD Card の第１パーティションに FAT で File System を作って以下のファイルを置きます。

 - RAW Binary File(DE0_NANO_SOC.rbf)
 - Linux Kernelのイメージ(zImage)
 - Device Tree Blob(socfpga.dtb)
 - ブート用スクリプト(u-boot.scr)



##続き

[Synthesijerで作ったモジュールをMessagePack-RPCで制御する(TTYドライバ編)](http://qiita.com/ikwzm/items/533b905f7d1eb2e6c4d5)に続きます。

