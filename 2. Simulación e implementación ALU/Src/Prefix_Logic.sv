`timescale 100ns / 1ps

module Prefix_Logic( input logic [3:0] A,B,
                     input logic c_in,
                     output logic [3:0] S,
                     output logic c_out, c2_out, c3_out

    );

//Señales internas
logic [3:0 ] P,G, G_out_internal;

//Generate P and G
assign P = A | B;
assign G = A & B;

Prefix_Block block1 (.P(P), 
                     .G(G), 
                     .c_in(c_in), 
                     .G_out(G_out_internal), 
                     .c_out(c_out));
                     
Prefix_Adderr adder (.A(A), .B(B), .G_out(G_out_internal), .S(S));

assign c2_out = G_out_internal[2];
assign c3_out = G_out_internal[3];




endmodule
