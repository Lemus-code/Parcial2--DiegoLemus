`timescale 100ns / 1ps

module Shift_Right( input logic [3:0] A,
                    input logic [1:0] SR, 
                    output logic [3:0] A_SR);
always_comb begin
    case (SR)
        2'b00: A_SR = A;                      // 0000 -> sin corrimiento
        2'b01: A_SR = {1'b0, A[3:1]};         // corrimiento de 1
        2'b10: A_SR = {2'b00, A[3:2]};        // corrimiento de 2
        2'b11: A_SR = {3'b000, A[3]};         // corrimiento de 3
    endcase
end

endmodule
