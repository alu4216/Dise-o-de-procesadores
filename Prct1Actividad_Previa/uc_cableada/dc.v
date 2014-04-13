module decodificador(input wire [2:0] tiempo, output wire [7:0] salida);
assign salida=1<<tiempo;
endmodule