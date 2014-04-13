`timescale 1 ns / 10 ps
`include "memprog.v"
`include "microc.v"
`include "uc.v"
`include "alu.v"
`include "componentes.v"
`include "procesador.v"
module procesador_tb;

//definición de variables del test_bench
reg clkt;
reg resett;
reg [7:0] datos_inAt;			//Entrada "A" del la señal al mux4. Una de las entradas del multiplexor
reg [7:0] datos_inBt;			//Entrada "B" del la señal al mux4. Una de las entradas del multiplexor
reg [7:0] datos_inCt;			//Entrada "C" del la señal al mux4. Una de las entradas del multiplexor
reg [7:0] datos_inDt;			//Entrada "D" del la señal al mux4. Una de las entradas del multiplexor
procesador proc(clkt,resett,datos_inAt[7:0],datos_inBt[7:0],datos_inCt[7:0],datos_inDt[7:0]);

always
    begin
      clkt =1'b1;
      #30;
      clkt =1'b0;
      #30;
    end
    
  initial 
    begin
      
	resett=1'b1;
	#5;
	resett=1'b0; 
  end
    
  initial
    begin
      $dumpfile("microc.vcd");
      $dumpvars;
      datos_inAt=8'b00000001;
      
      #300
      
      $finish;
   end 
endmodule

    
