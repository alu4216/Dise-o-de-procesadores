
module uc_cableada(input wire q0, start, clk, output wire CargaQ, DesplazaQ, ResetA, CargaA, Fin);

wire [7:0] salida;

generador gt(clk, start, salida); //generador de tiempos. Segun el instante de tiempo que nos encontremos la uc mandará distintas señales

assign CargaQ = salida[0];
assign DesplazaQ = (salida[2] | salida[4]);
assign ResetA = salida[0];
assign CargaA = (q0 & (salida[1] | salida[3] | salida[5]));
assign Fin = salida[6];

endmodule
