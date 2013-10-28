module de1_tutorial(CLOCK_50, LEDG, LEDR, DRAM_CLK,
DRAM_CKE,DRAM_ADDR, DRAM_BA_1, DRAM_BA_0, DRAM_CS_N, DRAM_CAS_N,
DRAM_RAS_N,DRAM_WE_N, DRAM_DQ, DRAM_UDQM, DRAM_LDQM, HEX3, HEX2,
HEX1, HEX0);

input CLOCK_50;
output [7:0] LEDG;
output [9:5] LEDR;
output [6:0] HEX3;
output [6:0] HEX2;
output [6:0] HEX1;
output [6:0] HEX0;
output [11:0] DRAM_ADDR;
output DRAM_BA_1, DRAM_BA_0, DRAM_CAS_N, DRAM_RAS_N, DRAM_CLK,
		 DRAM_CKE, DRAM_CS_N, DRAM_WE_N, DRAM_UDQM, DRAM_LDQM;
inout [15:0] DRAM_DQ;

wire toggle_clock;

    nios_system u0 (
        .green_leds_external_connection_export (LEDG), 
        .hex3_external_connection_export       (HEX3),       
        .hex2_external_connection_export       (HEX2),       
        .hex1_external_connection_export       (HEX1),       
        .hex0_external_connection_export       (HEX0),       
        .new_sdram_controller_0_wire_addr      (DRAM_ADDR),      
        .new_sdram_controller_0_wire_ba        ({DRAM_BA_1, DRAM_BA_0}),        
        .new_sdram_controller_0_wire_cas_n     (DRAM_CAS_N),     
        .new_sdram_controller_0_wire_cke       (DRAM_CKE),       
        .new_sdram_controller_0_wire_cs_n      (DRAM_CS_N),      
        .new_sdram_controller_0_wire_dq        (DRAM_DQ),        
        .new_sdram_controller_0_wire_dqm       ({DRAM_UDQM, DRAM_LDQM}),       
        .new_sdram_controller_0_wire_ras_n     (DRAM_RAS_N),     
        .new_sdram_controller_0_wire_we_n      (DRAM_WE_N),      
        .altpll_0_c2_clk                       (toggle_clock),                       
        .clk_clk                               (CLOCK_50),                               
        .clock_bridge_0_out_clk_1_clk          (DRAM_CLK)             
    );

	 toggle t(toggle_clock, LEDR);

endmodule
