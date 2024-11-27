module principal (
  input clk_50MHz, on_off, vel_1, vel_0, sensor_p,// ENTRADAS
  output da, db, dc, dd, de, df, dg, display1, display2, display3, display4, rgb); // AS ÚNICAS SAIDAS SERÃO AS PORTAS DO DISPLAY
  
  wire clk_2s, clk_4s, clk_8s, clk_display; //Fio dos clocks
  wire saida_mux_clk; // Fio da saida do mux 4/2 de escolha de clock
  wire f_bit2, f_bit1, f_bit0; // Fios de saida do contador
  wire sensor_prox;
  
  not senso_px(sensor_prox, sensor_p);
  
  not nt1(rgb, on_off);

  //O Clk de 50MHz recebido é dividido em 3: 2s, 4s, 8s e no display de 7segmentos

  dividir_clks dividir_clks(
    .clk(clk_50MHz),
	 .clk_2s(clk_2s),
    .clk_4s(clk_4s),
	 .clk_8s(clk_8s),
	 .clk_display(clk_display)
  );


  // Após dividir o clk em 3 velocidades eles vao para um mux 4/2
  mux4_2 muxclk(
	 .on_off(on_off),
    .bit0(vel_0), // Chave0 de velocidade do clk
    .bit1(vel_1), // Chave1 de velocidade do clk
    .in_a(clk_2s), // Clk 2s
    .in_b(clk_4s), // Clks 4s
    .in_c(clk_8s), // Clks 8s
    .in_d(1'b0), // Clks 0s
    .out(saida_mux_clk)  // Saida do mux 4/2
  );

  // A saida do Mux 4/2 vai para o contador de 3 bits
  contador_3bits contador3bits(
    .on_off(on_off),
    .clk(saida_mux_clk), 
    .bit2(f_bit2), 
    .bit1(f_bit1), 
    .bit0(f_bit0), 
    .sensor_prox(sensor_prox)
  );

  
  wire fpa, fpb, fpc, fpd, fpe, fpf, fpg; // Fios de saida do decodificador sete segmentos passos
  // As saidas do contador vão para o modulo que decodificará o numero para o display de sete segmentos
  sete_segmentos_passo segmentos_passo(
    .x(f_bit2), 
    .y(f_bit1), 
    .z(f_bit0), 
    .da(fpa), 
    .db(fpb), 
    .dc(fpc), 
    .dd(fpd), 
    .de(fpe), 
    .df(fpf), 
    .dg(fpg)
  );

  
  wire fva, fvb, fvc, fvd, fve, fvf, fvg; // Fios de saida do decodificador sete segmentos velocidade
  // No decodificador para sete segmentos da velocidade é recebido as chaves de velocidade
  sete_segmentos_velocidade segmentos_velocidade(
    .c1(vel_1), 
    .c0(vel_0), 
    .a(fva), 
    .b(fvb), 
    .c(fvc), 
    .d(fvd), 
    .e(fve), 
    .f(fvf), 
    .g(fvg)
  );

  
  wire saidadp1, saidadp2;
  // As saidas dos dois displays vão para a entrada do modulo que escolher qual segmento acender a depender do clk
  alternar_7segmentos alternar_segmentos(
    .clk_dp(clk_display),
	 .on_off(on_off),
    .va(fva), .vb(fvb), .vc(fvc), .vd(fvd), .ve(fve), .vf(fvf), .vg(fvg),
    .pa(fpa), .pb(fpb), .pc(fpc), .pd(fpd), .pe(fpe), .pf(fpf), .pg(fpg),
    .sa(da), .sb(db), .sc(dc), .sd(dd), .se(de), .sf(df), .sg(dg),
    .d1(saidadp1), .d2(saidadp2)
  );
 
 //displays
 not notdp1 (display1, 0);
 not notdp2 (display2, saidadp1);
 not notdp3 (display3, saidadp2);
 not notdp4 (display4, 0);
 

endmodule