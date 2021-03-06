//Memoria de programa, se inicializa y no se modifica

module memprog(input  wire clk,	// Señal de reloj
               input  wire [9:0] a,	// Señal de entrada proveniente del PC
               output wire [15:0] rd);	// Señal de salida de 16 bits que determina la instrucción que se 
					// va a hacer. 3 Tipos de instrucciones.

  reg [15:0] mem[0:1023]; // Memoria de 1024 palabras de 16 bits de ancho
	      
  initial
  begin
    $readmemb("progfile.dat",mem); // inicializa la memoria del fichero en texto binario

  end

  assign rd = mem[a];	// Carga en rd (que es la salida) la posición de memoria indicada por el PC.
endmodule


