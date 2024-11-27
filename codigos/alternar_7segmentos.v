////////////// PRONTO ////////////


module alternar_7segmentos(
  input clk_dp, on_off, va, vb, vc, vd, ve, vf, vg, pa, pb, pc, pd, pe, pf, pg,
  output d1, d2, sa, sb, sc, sd, se, sf, sg
  );
  wire clkneg;
  and andclk (d1, clk_dp, on_off ); // O primeiro display vai receber o sinal positivo do clk
  not not_clk (clkneg, clk_dp); // O segundo display vai receber o sinal negativo do clk
  and andckk (d2, clkneg, on_off);

  //A 
  mux2 mux_a ( // A depender do nivel logico do clk uma das duas saidas sera "escolhida"
    .bit(clk_dp), 
    .in_a(va), 
    .in_b(pa), 
    .out(sa)
  );

  //B
  mux2 mux_b (
    .bit(clk_dp), 
    .in_a(vb), 
    .in_b(pb), 
    .out(sb)
  );
    
  //C
  mux2 mux_c (
    .bit(clk_dp), 
    .in_a(vc), 
    .in_b(pc), 
    .out(sc)
  );
    
  //D
  mux2 mux_d (
    .bit(clk_dp), 
    .in_a(vd), 
    .in_b(pd), 
    .out(sd)
  );
    
  //E
  mux2 mux_e (
    .bit(clk_dp), 
    .in_a(ve), 
    .in_b(pe), 
    .out(se)
  );
    
  //F
  mux2 mux_f (
    .bit(clk_dp), 
    .in_a(vf), 
    .in_b(pf), 
    .out(sf)
  );
    
  //G
  mux2 mux_g (
    .bit(clk_dp), 
    .in_a(vg), 
    .in_b(pg), 
    .out(sg)
  );
    

endmodule

