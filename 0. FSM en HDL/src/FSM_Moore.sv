`timescale 100ns / 1ps

module FSM_Moore(
    input  logic clk, reset, D, C,      // D = dígito leído , C = lectura completada (viene de mealy)  
    output logic [1:0] L                // L = longitud código/sticker
);

//Plantilla de estados
typedef enum logic [1:0] {S0,S1,S2,S3} statetype;
statetype state, nextstate;

//Plantilla de L
typedef enum logic [1:0] {Digits_0, Digit_1, Digits_2, Digits_3} outtype;
outtype l;

// Registro de estados
always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else state <= nextstate;

// Next State Logic
always_comb
    case (state)    
        S0: if (D && ~C) nextstate = S1;
            else nextstate = S0;

        S1: if (~D && C) nextstate = S0;
            else if (D && ~C) nextstate = S2;
            else nextstate = S1;

        S2: if (~D && C) nextstate = S0;
            else if (D && ~C) nextstate = S3;
            else nextstate = S2;

        S3: if (~D && C) nextstate = S0;
            else nextstate = S3;

        default: nextstate = S0;
    endcase

// Output Logic
always_comb 
    case (state)
        S0: l = Digits_0;
        S1: l = Digit_1;
        S2: l = Digits_2;
        S3: l = Digits_3;
    endcase

assign L = l;

endmodule
