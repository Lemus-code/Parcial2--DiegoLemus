`timescale 100ns / 1ps

module VivePass(
    input  logic clk,
    input  logic reset,
    input  logic D, ST, 
    output logic A
);
//Plantilla de L
typedef enum logic [1:0] {Digits_0, Digit_1, Digits_2, Digits_3} outtype;
outtype l;

typedef enum logic {Abrir, Cerrar} outtypet;
outtypet A_t;

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

    always_comb begin
        case(L_out)
            2'b00: l = Digits_0;
            2'b01: l = Digit_1;
            2'b10: l = Digits_2;
            2'b11: l = Digits_3;
            default: l = Digits_0;
        endcase
    end
    
     always_comb begin
        case(A)
            2'b0: A_t = Cerrar;
            2'b1: A_t = Abrir;
            default: A_t = Cerrar;
        endcase
    end

endmodule
