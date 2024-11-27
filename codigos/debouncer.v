module debouncer(
  input clk, click,
  output out
);

	wire fioff1_d, fioff2_d, fioff2_d_negado; // Fios que serão usados no debouncer

  	DFF ffd1 (
		.d(click), 
		.clk(clk),  
		.q(fioff1_d)
	);

  	DFF ffd2 (
		.d(fioff1_d), 
		.clk(clk),  
		.q(fioff2_d)
	);
	
  not d_negado(fioff2_d_negado, fioff2_d);

  and and1(out, fioff1_d, fioff2_d_negado);
endmodule