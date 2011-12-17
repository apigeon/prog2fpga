PROJET=led#change by the name of your project

TARGET=xc3s1200e-fg320-5


all : prog

prog : $(PROJET).bit
	djtgcfg -d DOnbUsb prog -i 0 -f $(PROJET).bit
$(PROJET).bit : $(PROJET)_par.ncd 
	bitgen $(PROJET)_par.ncd $(PROJET).bit $(PROJET).pcf
$(PROJET)_par.ncd : $(PROJET).ncd 
	par $(PROJET).ncd $(PROJET)_par.ncd $(PROJET).pcf
$(PROJET).ncd : $(PROJET).ngd
	map -p $(TARGET) $(PROJET).ngd
$(PROJET).ngd : $(PROJET).ngc
	ngdbuild -i -p $(TARGET) $(PROJET).ngc
$(PROJET).ngc : $(PROJET).scr
	xst -ifn $(PROJET).scr
$(PROJET).scr : 
	bash ~/Bureau/xilinx.sh
	echo "run\n-ifn $(PROJET).v\n-ifmt verilog\n-ofn $(PROJET).ngc\n-p $(TARGET)\n-top $(PROJET)" > $(PROJET).scr
	

clean : 
	@rm -rf *.scr *.srp *.bld *.map* *.ncd *.ngc* *.ngd* *.ngm *pad* *.par *.ptwx *.unroutes *.xpi *.xrpt *.pcf *.xml *.lst xlnx_auto_0_xdb/ _xmsgs/ xst/ .*mrp
