`timescale 100ns / 1ps


module Prefix_Adder( input logic [3:0] P,G,
                     input logic c_in,
                     output logic [3:0] G_out,
                     output logic c_out

    );

logic c0, c1, c2, c3, c_out;

assign c0 = c_in;
assign c1 = (c_in & P[0]) | G[0];
assign c2 = (c1 & P[1]) | G[1];
assign c3 = (c1 & (P[1] & P[2])) | ((G[1] & P[2])| G[2]);
assign c_out = (c3 & P[3]) | G[3];

assign G_out = {c3, c2, c1, c0};

endmodule