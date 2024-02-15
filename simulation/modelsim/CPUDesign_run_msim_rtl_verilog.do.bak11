transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/Datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/mux_32_to_1.v}

vlog -vlog01compat -work work +incdir+C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC {C:/Users/steve/OneDrive/Desktop/eng_stuff/FOURTH_YEAR/ELEC374/mini-SRC/and_32_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  and_32_tb

add wave *
view structure
view signals
run 500 ns
