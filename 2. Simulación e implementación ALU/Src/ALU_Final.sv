`timescale 100ns / 1ps

module ALU_Final( input logic [3:0] A,B,
                  input logic  [1:0] OP_Selector, Shift_Selector, Shift_Right, Shift_Left,
                  output logic [3:0] Resultado, A_shift,
                  output logic Cero, Negativo, C_out, Overflow
        
    );
 //Plantillas de flags
typedef enum logic {Nulll , CERO} cero_outtype;
cero_outtype cf; 

typedef enum logic {POSITIVO , NEGATIVO} neg_outtype;
neg_outtype nf; 

typedef enum logic {NOCARRY, CARRY} car_outtype;
car_outtype carf; 

typedef enum logic {NOOVER, OVERFLOW} o_outtype;
o_outtype of; 


Pre_Alu Alu6 (
            .A(A),
            .B(B),
            .OP(OP_Selector),
            .OP_S(Shift_Selector),
            .Shift_R(Shift_Right),
            .Shift_L(Shift_Left),
            .Cero(Cero),
            .Negativo(Negativo),
            .C_out(C_out),
            .Overflow(Overflow),
            .Resultado(Resultado),
            .A_Shift(A_shift)
);
always_comb begin
        case(Cero)
            2'b0: cf = Nulll;
            2'b1: cf = CERO;
            default: cf = CERO;
        endcase
        
        case(Negativo)
            2'b0: nf = POSITIVO;
            2'b1: nf = NEGATIVO;
            default: nf = POSITIVO;
        endcase
        
        case(C_out)
            2'b0: carf = NOCARRY;
            2'b1: carf = CARRY;
            default: carf = NOCARRY;
        endcase
        
        case(Overflow)
            2'b0: of = NOOVER;
            2'b1: of = OVERFLOW;
            default: of = NOOVER;
        endcase
    end
endmodule

