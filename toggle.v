module toggle(clock, toggle_output); 

input clock;
output[9:5] toggle_output;

reg[30:0] toggling;
	
always @ (posedge clock)
   begin
		toggling<=toggling + 1;
   end 

assign toggle_output[9] = toggling[21];
assign toggle_output[5] = toggling[21];

assign toggle_output[8] = toggling[26];
assign toggle_output[6] = toggling[26];

assign toggle_output[7] = toggling[27];

endmodule
