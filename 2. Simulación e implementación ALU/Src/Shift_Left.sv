`timescale 100ns / 1ps

module Shift_Left (input  logic [3:0] A,
                   input  logic [1:0] SL,
                   output logic [3:0] A_SL
);

always_comb begin
    case (SL)
        2'b00: A_SL = A;                       // sin corrimiento
        2'b01: A_SL = {A[2:0], 1'b0};         // desplazar 1 a la izquierda
        2'b10: A_SL = {A[1:0], 2'b00};        // desplazar 2
        2'b11: A_SL = {A[0], 3'b000};         // desplazar 3
        default: A_SL = A;
    endcase
end

endmodule
