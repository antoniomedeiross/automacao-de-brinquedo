//CERTO, ELE DIVIDE EM 4 PORQUE O FF É SENSIVEL A BORDA DE DESCIDA!!!!!!!!!!!!!!!

module dividir_clk5(clk, clk_5);
  input clk; // Recebe o clk, como entrada
  output clk_5; // A saida é clk com período de 5s

  wire fioff0, fioff1, fioff2;//Fios q recebem as saidas dos ff
  wire fioreset, nfioff1, nfioff0, nfioff2; // Fio do reset e no ff1 negado

  // Fazer um contador ate 5 
  flipflop_t ff0(
    .clk(clk),
    .q(fioff0),
    .reset(fioreset)
  ); 

  flipflop_t ff1(
    .clk(fioff0),
    .q(fioff1),
    .reset(fioreset)
  ); 

  flipflop_t ff2(
    .clk(fioff1),
    .q(fioff2),
    .reset(fioreset)
  ); 
  
  not notff1(nfioff0, fioff0);
  not notff2(nfioff1, fioff1);
  not notff3(nfioff2, fioff2);
  and andrst(fioreset, fioff0, nfioff1, fioff2); //101 os flipflops irão resetar 

  wire not0, not1; 

  not not_0 ( not0, fioreset);
  not not_1 (clk_5, not0);
  //and andsaida(clk_5, nfioff0, nfioff1, fioff2); // clk sera dividido quando contagem = 4 -> 100
  
  

endmodule