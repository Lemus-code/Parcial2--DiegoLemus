`timescale 100ns / 1ps

module VivePass(
    input  logic clk,
    input  logic reset,
    input  logic D, ST, 
    output logic A
);

logic [1:0] L_out;
logic c_out;

// Instancia Moore
FSM_Moore moore (
    .clk(clk), 
    .reset(reset), 
    .D(D), 
    .C(c_out),     
    .L(L_out)
);

// Instancia Mealy
FSM_Mealy mealy (
    .clk(clk), 
    .reset(reset), 
    .ST(ST), 
    .L(L_out), 
    .A(A), 
    .C(c_out)      
);

endmodule
