
module generador(input wire clk, reset, output wire [7:0] salida);

reg [2:0] tiempo;

always @ (posedge clk, posedge reset)
  if (reset)
    tiempo <= 3'b000;
  else
    tiempo <= tiempo + 1;

decodificador dc(tiempo, salida);

endmodule