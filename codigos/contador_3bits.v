///////////////PRONTO///////////////////


module contador_3bits(clk, bit2, bit1, bit0, sensor_prox, on_off);
  input clk, sensor_prox, on_off;
  output wire bit2, bit1, bit0;
  // CONTA APENAS DE 000 ATÉ 101
  // Quando bit0=1 AND bit1=1 AND bit2=0 <---> reset=1
  wire fio_rstff1e3, fio_rstff2; //FIos de reset dos ff
  wire saidaAnd; //Fio da saida and
  
  wire on_off_neg;
  not notc(on_off_neg, on_off);
  
  and and1(fio_rstff1e3, bit2, bit1); //110
 // and and2(saidaAnd, bit2, bit1); //110
  or or1(fio_rstff2, fio_rstff1e3, sensor_prox, on_off_neg);
  // 101
  or orreset1e3(reseta1e3, fio_rstff1e3, on_off_neg);
  
  flipflop_t ff1(
  .clk(clk), 
  .q(bit0), 
  .reset(reseta1e3),
  .preset(sensor_prox),
  );

  flipflop_t ff2(
  .clk(bit0), 
  .q(bit1), 
  .reset(fio_rstff2),
  );

  flipflop_t ff3(
  .clk(bit1), 
  .q(bit2), 
  .reset(reseta1e3),
  .preset(sensor_prox)
  );
  
  
endmodule
