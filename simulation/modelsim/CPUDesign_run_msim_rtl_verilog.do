transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/select_encode_logic.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/decoder_4_to_16.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/Datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/and_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/alu_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/mux_32_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/encoder_32_to_5.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/mul_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/or_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/shra_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/shr_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/shl_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/ror_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/rol_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/switch_to_neg_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/sub_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/add_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/not_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/div_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/d_flip_flop.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/con_ff.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/RAM.v}

vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/ld_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ld_tb

add wave *
view structure
view signals
run 500 ns
