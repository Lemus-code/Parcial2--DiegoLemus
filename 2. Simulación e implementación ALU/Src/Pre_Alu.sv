`timescale 100 ns / 1ps

module Pre_Alu( input logic [3:0] A,B,
                input logic [1:0] OP, OP_S, Shift_R, Shift_L,
                output logic Cero, Negativo, C_out, Overflow,
                output logic [3:0] Resultado, A_Shift

    );
    
logic resta, c_out2, overflow2; //señales internas de uso 
logic [3:0] RA_SL, RA_SR; //resultado de Shift A right y left y tipo de A que vamos a usar para operaciones
logic [3:0] SumRest, R_or, R_and; //Resultado Operaciones

//Desplazamiento
Shift_Left S_L (
        .A(A),
        .SL(Shift_L),
        .A_SL(RA_SL)
);

Shift_Right S_R (
        .A(A),
        .SR(Shift_R),
        .A_SR(RA_SR)
);

//Multiplexor para selección de A a emplear en operaciones (Normal, Shift_R, Shift_L)
always_comb begin
    case(OP_S)
        2'b00: A_Shift = A;
        2'b01: A_Shift = RA_SR;
        2'b10: A_Shift = RA_SL;
        2'b11: A_Shift = A;
        default: A_Shift = A;
     endcase    
end

//Proceso Suma, no usamos todas las salidas porque no es necesario. Esas salidas le interesan a Flags
SumRest Alu_SumRest (
            .A(A_Shift),
            .B(B),
            .Resta(OP[0]),
            .SumaRest(SumRest)              
);

//Proceso OR
assign R_or = A_Shift | B;

//Proceso AND
assign R_and = A_Shift & B;

//Cálculo Flags + Bloqueos
Flags Alu_Flags(
            .A(A_Shift),
            .B(B),
            .Resta(OP[0]),
            .Cero(Cero),
            .Negativo(Negativo),
            .C_out(c_out2),
            .Overflow(overflow2),
            .OP1(OP[1])
);

//Lógica para bloqueo de overflow y c_out

assign C_out = (( overflow2 | ((c_out2 & ~OP[0]) | (~c_out2 & OP[0]))) & ~OP[1]);
assign Overflow = overflow2 & OP[0];

//Selección de operación
always_comb begin
    case(OP)
        2'b00: Resultado = SumRest;
        2'b01: Resultado = SumRest;
        2'b10: Resultado = R_or;
        2'b11: Resultado = R_and;
     endcase
end
endmodule
