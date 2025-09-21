`timescale 100ns / 1ps

module Prefix_Adderr(input logic [3:0] A,B,
                     input logic [3:0] G_out,
                     output logic[3:0] S

    );

assign S[0] = ((A[0]^B[0])^G_out[0]);
assign S[1] = ((A[1]^B[1])^G_out[1]);
assign S[2] = ((A[2]^B[2])^G_out[2]);
assign S[3] = ((A[3]^B[3])^G_out[3]);



endmodule
