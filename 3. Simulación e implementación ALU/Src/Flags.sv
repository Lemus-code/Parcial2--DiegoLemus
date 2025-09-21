`timescale 100ns / 1ps

module Flags( input logic [3:0] A,B,
              input logic Resta,
              output logic Cero, Negativo, C_out, Overflow

    );

logic c2,c3;
logic [3:0] result_sumrest;
logic or1, or2;

SumRest SumaResta (
            .A(A),
            .B(B),
            .Resta(Resta),
            .c_out(C_out), //Carry out flag
            .c2_out(c2),
            .c3_out(c3),
            .SumaRest(result_sumrest)
            
);

//Flags
assign Overflow = c3 ^ c2;
assign Cero = (result_sumrest == 4'b0000);
assign Negativo = (result_sumrest[3] & Resta);

endmodule
