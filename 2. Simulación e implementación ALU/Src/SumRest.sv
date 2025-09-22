`timescale 100ns / 1ps

module SumRest( input logic [3:0] A,B,
                input logic Resta,
                output logic [3:0] SumaRest,
                output logic c_out, c2_out, c3_out

    );

logic [3:0] B1;
    
Prefix_Logic prefix(
            .A(A),
            .B(B1),
            .c_in(Resta),
            .S(SumaRest),
            .c_out(c_out),
            .c2_out(c2_out),
            .c3_out(c3_out)
);

always_comb begin
    case (Resta)
        2'b0: B1 = B;                       // sin corrimiento
        2'b1: B1 = ~B;         // desplazar 1 a la izquierda
        default: B1 = B;
    endcase
end
endmodule
