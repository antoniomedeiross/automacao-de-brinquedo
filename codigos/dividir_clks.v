////////////PRONTO////////////

module dividir_clks(clk, clk_2s, clk_4s, clk_8s, clk_display);
  input clk;
  output clk_display, clk_2s, clk_4s, clk_8s;

  wire div1, div2, div3, div4, div5, div6, div7, div8; //Fios que recebem as divizões do clk por 5
  wire ff1, ff2, ff3, ff4, ff5, ff6, ff7, ff8, ff9; // Fios da divisão por 2 dos flipflops
/*  ////DIVISÃO/////
    1 d/5 -> clk = 10Mhz
    2 d/5 -> clk = 2MHz 
    3 d/5 -> clk = 400KHz
    4 d/5 -> clk = 80KHz
    5 d/5 -> clk = 16KHz
    6 d/5 -> clk = 3.2KHz
    7 d/5 -> clk = 640Hz
    8 d/5 -> clk = 128Hz
    9 d/2 -> clk = 64Hz -> clk_display
    10 d/2 -> clk = 32Hz
    11 d/2 -> clk = 16Hz
    12 d/2 -> clk = 8Hz
    13 d/2 -> clk = 4Hz
    14 d/2 -> clk = 2Hz
    15 d/2 -> clk = 1Hz
    16 d/2 -> clk = 0.5Hz   // 2s
    17 d/2 -> clk = 0.25Hz  // 4s
    18 d/2 -> clk = 0.125Hz // 8s
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
  //Apos passar pelos divisores de 5, o clock agora é de 128Hz, então conseguimos dividi-lo precisamente para 2s usando flip-flops tipo T


  flipflop_t ff_1( // A saida do 1° ff é 64
    .clk(div8), // Entrada de 128Hz
    .q(ff1) // Saida de 64Hz
  );

  wire negclkdp;
  not notdp(negclkdp, ff1);// O clock do display recebe o fio do ff1 que é de 65Hz
  not(clk_display, negclkdp); 

  flipflop_t ff_2( 
    .clk(ff1), // Entrada de 64Hz
    .q(ff2)  // Saida de 32Hz
  );
  flipflop_t ff_3(
    .clk(ff2), // Entrada de 32Hz
    .q(ff3) // Saida de 16Hz
  );
  flipflop_t ff_4(
    .clk(ff3), // Entrada de 16Hz 
    .q(ff4) // Saida de 8Hz
  );
  flipflop_t ff_5( 
    .clk(ff4), // Entrada de 8Hz
    .q(ff5)  // Saida de 4Hz
  );
  flipflop_t ff_6(
    .clk(ff5), // Entrada de 4Hz
    .q(ff6) // Saida de 2Hz
  );
  flipflop_t ff_7(
    .clk(ff6), // Entrada de 2Hz
    .q(ff7) // Saida de 1Hz
  );
  flipflop_t ff_8(
    .clk(ff7), // Entrada de 1Hz
    .q(ff8) // Saida de 1.5Hz
  );

  wire negclk2;
  not notclk2(negclk2, ff8);
  not(clk_2s, negclk2); // O clk_2s recebe o fio do ff8 que é de 0.5Hz
  


  flipflop_t ff_9(
    .clk(ff8), // Entrada de 0.5Hz
    .q(ff9) // Saida de 0.25Hz
  );
  

  wire negclk4;
  not notclk4(negclk4, ff9);
  not(clk_4s, negclk4); // O clk_4s recebe o fio do ff8 que é de 0.25Hz

  
  flipflop_t ff_10( 
    .clk(ff9), // Entrada de 0.25Hz
    .q(clk_8s) // Saida de 0.125Hz
  );


endmodule