//////////////// PRONTO //////////////

/*
	00 --> in_a --> clk2s
	01 --> in_b --> clk4s
	10 --> in_c --> clk8s
	11 --> in_d --> 0s
*/
module mux4_2(on_off, bit0, bit1, in_a, in_b, in_c, in_d, out);
	input on_off, bit0, bit1, in_a, in_b, in_c, in_d;
	output out;
	
	wire mx1, mx2, mx3; // Fios dos Mux 1 e 2
	
	//Com 3 Mux 2/1 fazemos o modulo de um Mux 4/1
	mux2 mux1(
		.bit(bit0),
		.in_a(in_a),
		.in_b(in_b),
		.out(mx1)
	);
	
	mux2 mux2(
		.bit(bit0),
		.in_a(in_c),
		.in_b(in_d),
		.out(mx2)
	);
	
	mux2 mux3(
		.bit(bit1),
		.in_a(mx1),
		.in_b(mx2),
		.out(mx3)
	);
	
	mux2 mux4(
	  .bit(on_off),
	  .in_a(0),
	  .in_b(mx3),
	  .out(out)
	);
endmodule





