module testes(input clk, output clk5, clk10, clk10_2);

	wire fioclk5, fioclk10;
	
	
	dividir_clk5 div1(
		.clk(clk),
		.clk_5(fioclk5)
	);
	
	dividir_clk5 div2(
		.clk(fioclk5),
		.clk_5(fioclk10)
	);
	flipflop_t ff (
		.clk(fioclk10),
		.reset(0),
		.preset(0),
		.q(clk10_2)
	);

	wire neg5, neg10;

	not not1(neg5, fioclk5);
	not not2 (clk5, neg5);
	
	not not3 (neg10, fioclk10);
	not not4 (clk10, neg10);
	
endmodule