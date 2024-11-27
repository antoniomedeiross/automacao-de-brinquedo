//////////////////PRONTO////////////

module flipflop_t(
    input clk,       // Clock
    input reset,     // Sinal de reset
    input preset,     // Sinal de preset
    output reg q     // Saída q
);

  always @(negedge clk or posedge reset or posedge preset) begin
    if (reset) begin
      q <= 0;        // Reseta o flip-flop, q = 0
    end else if (preset) begin 
      q <=1;
    end else begin
      q <= !q;       // Alterna o estado de q na borda negativa do clock
    end
  end

  
endmodule
