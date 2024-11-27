//Modulo de um Mux 2/1
module mux2(bit, in_a, in_b, out);
	input bit,in_a, in_b;
	output out;


	wire fio_a1, fio_a2, fio_n;
	
	not not1(fio_n, bit);
	and and1(fio_a1, fio_n, in_a);
	and and2(fio_a2, bit, in_b);
	or or1(out, fio_a1, fio_a2);
endmodule
