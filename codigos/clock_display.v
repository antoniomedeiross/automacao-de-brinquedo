//////////////////PRONTO///////////////////

module clock_display(clk, clk_dpl);
  input clk ; // Recebe o clk, como entrada
  output clk_dpl; // Clock de saida que será de 64Hz

  
  wire div1, div2, div3, div4, div5, div6, div7, div8; //Fios que recebem as divizões do clk por 5

/*  ////DIVISÃO/////
    1 d/5 -> clk = 10Mhz
    2 d/5 -> clk = 2MHz 
    3 d/5 -> clk = 400KHz
    4 d/5 -> clk = 80KHz
    5 d/5 -> clk = 16KHz
    6 d/5 -> clk = 3.2KHz
    7 d/5 -> clk = 640Hz
    8 d/5 -> clk = 128Hz
    9 d/2 -> clk = 64Hz
  */
  dividir_clk5 divisor5_1( // O modulo divide o clock por 5
    .clk(clk), // Entrada de 50MHz
    .clk_5(div1) // saida de 10MHz
  );

  dividir_clk5 divisor5_2( // O modulo divide o clock por 5
    .clk(div1), // Entrada de 10MHz
    .clk_5(div2) // Saida de 2MHz
  );

  dividir_clk5 divisor5_3( // O modulo divide o clock por 5
    .clk(div2), // Entrada de 2MHz
    .clk_5(div3) // Saida de 400KHz
  );

  dividir_clk5 divisor5_4( // O modulo divide o clock por 5
    .clk(div3), // Entrada de 400KHz
    .clk_5(div4) // Saida de 80KHz
  );

  dividir_clk5 divisor5_5( // O modulo divide o clock por 5
    .clk(div4), // Entrada de 80KHz
    .clk_5(div5) // Saida de 16KHz
  );

  dividir_clk5 divisor5_6( // O modulo divide o clock por 5
    .clk(div5), // Entrada de 16KHz
    .clk_5(div6) // Saida de 3.2KHz
  );

  dividir_clk5 divisor5_7( // O modulo divide o clock por 5
    .clk(div6), // Entrada de 3.2KHz
    .clk_5(div7) // Saida de 640Hz
  );

  dividir_clk5 divisor5_8( // O modulo divide o clock por 5
    .clk(div7), // Entrada de 640Hz
    .clk_5(div8) // Saida de 128Hz
  );
  
  flipflop_t ff(
    .clk(div8), // Entrada de 128Hz
    .q(clk_dpl) // Saida de 64Hz
  );
  
endmodule