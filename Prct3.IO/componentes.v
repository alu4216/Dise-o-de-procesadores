// COMPONENTES VARIOS

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Banco de registros de dos salidas y una entrada. Actuará como una memoria de datos en registros
module regfile(input  wire        clk,               // Señal de reloj
               input  wire        we3,               // Señal de habilitación de escritura
               input  wire [3:0]  ra1, ra2, wa3,     // Direcciones de regs leidos y reg a escribir 
               input  wire [7:0]  wd3,               // Dato a escribir
               output wire [7:0]  rd1, rd2);         // Datos leidos

  reg [7:0] regb[0:15]; //memoria de 16 registros de 8 bits de ancho
  //Se supone que se tendra 16 registros de 8 bit de ancho.

  initial
  begin
    $readmemb("regfile.dat",regb); // inicializa los registros a valores conocidos. Los datos los recoje
				    // de regfile.dat, 
				   //  por eso en regfile.dat hay 16 filas, porque regb[0:15] y cada fila
				   //  es de 8 bit de ancho reg[7:0]
  end  
  // El registro 0 siempre es cero
  // se leen dos reg combinacionalmente
  // y la escritura del tercero ocurre en flanco de subida del reloj
  always @(posedge clk)
    if (we3) regb[wa3] <= wd3;	// si se produce la señal de escritura, guardar el valor en nuestro banco de registros
  
  assign rd1 = (ra1 != 0) ? regb[ra1] : 0; // rd1 y rd2 toman los valores de entrada al registro ra1 y ra2
  assign rd2 = (ra2 != 0) ? regb[ra2] : 0; // en caso de no tener valores se le asigna el valor 0
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sumador  
module sum(input  wire [9:0] a, b, // Entradas uno de ellos siempre es 1
             output wire [9:0] y); // Salida que va hacia el multiplexor 

  assign y = a + b; // Suma a y b y lo manda por la salida y.
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Registro para modelar el PC, cambia en cada flanco de subida de reloj o de reset
// Para que el PC apunte a la siguiente instrucción
module registro #(parameter WIDTH = 10) // NO APARECE EN EL DIBUJO ESTE REGISTRO, SE LE SUPONE ASOCIADO AL PC
              (input  wire clk, reset,    // Señales de clock y reset.
               input  wire [WIDTH-1:0] d, // Señal de entrada proveniente del multiplexor, en el dibujo 
					   // pone que debería ser de 10, no de 7
               output reg  [WIDTH-1:0] q); // Registro de salida que va a la memoria de programa, en el 
					   // dibujo pone que debería ser de 10, no de 7. 
	      
  always @(posedge clk, posedge reset)  // Siempre que haya un cambio de reloj o un reset:
    if (reset) q <= 0;                  // Si es un rest, el PC se pone a 0.
    else       q <= d;                  // Si no, el PC toma el valor de la entrada d.
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Multiplexor 2, si s=1 sale d1, s=0 sale d0
module mux2 #(parameter WIDTH = 8)           // Constante, determina el ancho de las entradas y salidas.
             (input  wire [WIDTH-1:0] d0, d1,// Señales de entrada, una proviene de la ALU(d0) y otra 
					      // la memoria de programa().
              input  wire             s,     // Señal de s_inm que se usa cuando se quiere almacenar en 
					      // banco de registros un valor directo.
              output wire [WIDTH-1:0] y);   // Señal de salida que va hacia el Banco de Registros.

  assign y = s ? d1 : d0; // Si s=1, sale d1, si s=0 sale d1
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Multiplexor antes del PC. 
module mux1 #(parameter WIDTH = 10)              // Constante, determina el ancho de las entradas y 		
						  // salidas.
             (input  wire [WIDTH-1:0] d0, d1,    // Señales de entrada, una proviene de la memoria de 
						  // programa(d0) y otra del sumador(d1).
              input  wire             s,        //  Señal de s_inc que se usa cuando es una operación 	
						 //  de salto
              output wire [WIDTH-1:0] y);       // Señal de salida que va hacia el PC.

  assign y = s ? d1 : d0; // Si s=1, sale d1, si s=0 sale d1
endmodule
//registro creado para solucionar el problema del almaceanr la señal z
module registro_z (input wire z_in, input wire clk, output reg z_out, input wire [2:0] op); // NO APARECE 

	always @(posedge clk)
	begin
	
    	      z_out <= z_in;
	      
        end
endmodule


//COMPONENTES DE ENTRADA SALIDA
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module registro_salidaA(input wire clk,we_s_r_1,input wire [7:0]datos_in,output reg  [7:0] datos_out );
 
     always @(posedge clk)
     begin
      if(we_s_r_1==1)
	datos_out=datos_in;
     end

endmodule
module registro_salidaB(input wire clk,we_s_r_2,input wire[7:0]datos_in,output reg [7:0] datos_out );
 
     always @(posedge clk)
     begin
      if(we_s_r_2==1)
	datos_out=datos_in;
     end

endmodule

module registro_salidaC(input wire clk,we_s_r_3,input wire [7:0]datos_in,output reg [7:0] datos_out );
 
     always @(posedge clk)
     begin
      if(we_s_r_3==1)
	datos_out=datos_in;
     end

endmodule

module registro_salidaD(input wire clk,we_s_r_4,input wire [7:0]datos_in,output reg [7:0] datos_out );
 
     always @(posedge clk)
     begin
      if(we_s_r_4==1)
	datos_out=datos_in;
     end

endmodule

module mux3(input wire [7:0]datos_in_regfile,input wire [7:0]datos_in_memprog,input wire s_r,output wire [7:0]datos_out);

    assign datos_out = s_r ? datos_in_memprog :datos_in_regfile; 

endmodule

module mux5(input wire [7:0]datos_in_mux4,input wire [7:0]datos_in_memprog,input wire s_mux5,output wire [7:0]datos_out);

    assign datos_out = s_mux5 ? datos_in_memprog :datos_in_mux4; 

endmodule


module mux4(input wire [7:0]datos_in_A,input wire [7:0]datos_in_B,input wire [7:0]datos_in_C,
	      input wire [7:0]datos_in_D,input wire [1:0]s_e,output reg [7:0] datos_out);

    always @(*)
      casex (s_e)
      
	  2'b00:
	     datos_out=datos_in_A;
	  2'b01:
	     datos_out=datos_in_B;
	  2'b10:
	     datos_out=datos_in_C;
	  2'b11:
	     datos_out=datos_in_D;
     endcase

endmodule

module mux6(input wire [9:0]datos_in,input wire [9:0] dato,input wire s_rel,output wire [9:0] datos_out);

    assign datos_out = s_rel ? dato:datos_in;
    
endmodule










