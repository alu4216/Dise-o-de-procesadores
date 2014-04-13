module microc(input wire clk, reset, s_inc, s_inm, we3, input wire [2:0] op,input wire s_r,input wire [1:0]s_e,input wire s_mux5,we_s_r_1, we_s_r_2,we_s_r_3,we_s_r_4,input wire [7:0] datos_inA,input wire [7:0] datos_inB,input wire [7:0] datos_inC,input wire [7:0] datos_inD, input wire s_rel,output wire z, output wire [5:0] opcode);//Microcontrolador sin memoria de datos de un solo ciclo


//Instanciar e interconectar pc, memprog, regfile, alu, sum y mux's
wire [9:0]  mux1;			// Salida del mux1 al PC.
wire [9:0]  dir;			// Salida del PC a la Memoria de Programa.
wire [9:0]  sumsal;			// Salida del sumador al PC.
wire [15:0] datos;			// Salida de la memoria de programa.
wire [7:0]  wd3;			// Salida del mux2 a al Banco de Registros.
wire [7:0]  alusal;			// Salida de la ALU al mux2.
wire [7:0]  rd1;			// Salida del Banco de Registros a la ALU.
wire [7:0]  rd2;			// Salida del Banco de Registros a la ALU.
wire 	    z_out;			// Salida del registro z (guaramos el valor de la z proviniente de la alu)
wire 	    z_z;			// Entrada del registro z(entrada que viene de la alu)
//Señales para intrucciones optativas

wire [9:0] sal_mux6;


//Definición de señales necesarias de la IO

//"Puertos de salida"
wire [7:0] datos_outA;			//Salida del registroA de IO
wire [7:0] datos_outB;			//Salida del registroB de IO
wire [7:0] datos_outC;			//Salida del registroC de IO
wire [7:0] datos_outD;			//Salida del registroD de IO
wire [7:0] sal_mux3;			//Salida del mux3
wire [7:0] sal_mux4;			//Salida del mux4
wire [7:0] sal_mux5;			//Salida del mux5

//"Puertos de entrada"
/*
wire [7:0] datos_inA;			//Entrada "A" del la señal al mux4. Una de las entradas del multiplexor
wire [7:0] datos_inB;			//Entrada "B" del la señal al mux4. Una de las entradas del multiplexor
wire [7:0] datos_inC;			//Entrada "C" del la señal al mux4. Una de las entradas del multiplexor
wire [7:0] datos_inD;			//Entrada "D" del la señal al mux4. Una de las entradas del multiplexor
*/

//Intanciación de componentes necesarios para la realización del camino de datos
memprog  memo(clk,dir,datos);
registro #(10) PC(clk,reset,mux1,dir);	
sum #(10) suma(dir,sal_mux6,sumsal);
mux1 #(10) muxizq(datos[15:6],sumsal,s_inc,mux1);	
regfile #(8) banco(clk,we3,datos[7:4],datos[11:8],datos[15:12],wd3,rd1,rd2);
alu #(10) alualu(rd1,rd2,op,alusal,z_z);	
mux2 #(8) muxdch(alusal,sal_mux5,s_inm,wd3);	
registro_z #(8) reg_z(z_z, clk, z_out, op);

//Instanciación de componentes necesarios para la IO

registro_salidaA #(10) regA(clk,we_s_r_1,sal_mux3[7:0],datos_outA[7:0]);
registro_salidaB #(10) regB(clk,we_s_r_2,sal_mux3[7:0],datos_outB[7:0]);
registro_salidaC #(10) regC(clk,we_s_r_3,sal_mux3[7:0],datos_outC[7:0]);
registro_salidaD #(10) regD(clk,we_s_r_4,sal_mux3[7:0],datos_outD[7:0]);
//Otros mux
mux3 #(8) mux_3(rd2,datos[15:8],s_r,sal_mux3[7:0]);
mux5 #(8) mux_5(sal_mux4[7:0],datos[11:4],s_mux5,sal_mux5[7:0]);
//Mux de entrada
mux4 #(8) mux_4(datos_inA[7:0],datos_inB[7:0],datos_inC[7:0],datos_inD[7:0],s_e,sal_mux4[7:0]);
//Instaciación de componentes opcionales
mux6 #(8) mux_6(datos[15:6],1,s_rel,sal_mux6);
assign opcode=datos[5:0];
assign z=z_out;

endmodule
