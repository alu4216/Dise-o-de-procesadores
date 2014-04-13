`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulaci�n y el paso de simulaci�n

module cuenta1_tb; //Declaracion de modulo del testbench


//declaracion de se�ales

reg [2:0] valor;
reg start, clk;
wire [3:0] cuenta;
wire fin; 

//instancia del modulo a testear
cuenta1 cuenta1(valor, start,clk,cuenta,fin);


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
clk = 1;
#20;
clk = 0;
#50;
end


initial
begin
  $monitor("tiempo=%0d Valor=%b start=%b clk=%b Cuenta=%b fin=%b", $time, valor,start,clk,cuenta,fin);
  $dumpfile("ejecutable.vcd");
  $dumpvars;

   start = 1;
   #5;
   start = 0;
   #5;

   valor = 3'b111;
   #450;

  $finish;  //fin simulacion

end
endmodule
