///////////// PRONTO /////////////

module sete_segmentos_velocidade(c1, c0, a, b, c, d, e, f, g);
  input c1, c0; //Entrada das chaves
  output a, b, c, d, e, f, g; // Saida dos digitos
  //C1 = MSB, C0 = LSB
  wire nc1, nc0; //Fios que recebem as portas c0 e c1 negadas

  not no1(nc1, c1);
  not not0(nc0, c0);

  //Digito A C1'C0
  and anda(a, nc1, c0);
  //Digito B = 0
  assign b = 0;
  //Digito C c1'c0'
  and andc(c, nc1, nc0);
  //Digito D c1'c0
  and andd(d, nc1, c0);
  //Digito E c1'c0
  and ande(e, nc1, c0);
  //Digito F c1'c0'
  and andf(f, nc1, nc0);
  //Digito G c1c0
  and andg(g, c1, c0);

endmodule