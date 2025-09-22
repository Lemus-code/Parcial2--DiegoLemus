#include <stdint.h> // Librería estándar para tipos enteros

// -------------------- BASE ADDRESS --------------------
#define PERIPHERAL_BASE_ADDRESS     0x40000000U //Ubicación periféricos
#define AHB_BASE_ADDRESS            (PERIPHERAL_BASE_ADDRESS + 0x00020000U) //Ubicación de AHB para llegar a RCC
#define RCC_BASE_ADDRESS            (AHB_BASE_ADDRESS + 0x00001000U) //Ubicación de RCC
#define IOPORT_ADDRESS              (PERIPHERAL_BASE_ADDRESS + 0x10000000U) //Ubicación de los puertos
#define GPIOA_BASE_ADDRESS          (IOPORT_ADDRESS + 0x00000000U) //Ubicación de Puertos A
#define GPIOB_BASE_ADDRESS          (IOPORT_ADDRESS + 0x00000400U) //Ubicación de Puertos B
#define GPIOC_BASE_ADDRESS          (IOPORT_ADDRESS + 0x00000800U) //Ubicación de Puertos C

// -------------------- ESTRUCTURAS --------------------
typedef struct {
    uint32_t MODER;
    uint32_t OTYPER;
    uint32_t OSPEEDR;
    uint32_t PUPDR;
    uint32_t IDR;
    uint32_t ODR;
    uint32_t BSRR;
    uint32_t LCKR;
    uint32_t AFR[2];
    uint32_t BRR;
} GPIOx_Reg_Def; //Es una estructura que da saltos de memoria abarcando esos registros de GPIOS

typedef struct {
    uint32_t CR;
    uint32_t ICSCR;
    uint32_t CRRCR;
    uint32_t CFGR;
    uint32_t CIER;
    uint32_t CIFR;
    uint32_t CICR;
    uint32_t IOPRSTR;
    uint32_t AHBPRSTR;
    uint32_t APB1PRSTR;
    uint32_t APB2PRSTR;
    uint32_t IOPENR;
    uint32_t AHBENR;
    uint32_t APBENR[2];
    uint32_t IOPSMENR;
    uint32_t AHBSMENR;
    uint32_t APBSMENR[2];
    uint32_t CCIPR;
    uint32_t CSR;
} RCC_Reg_Def;//Lo mismo pero para RCC

// -------------------- PERIFÉRICOS --------------------
#define GPIOA   ((GPIOx_Reg_Def*)GPIOA_BASE_ADDRESS) //Le digo que esa estructura comienza en la dirección de GPIOA
#define GPIOB   ((GPIOx_Reg_Def*)GPIOB_BASE_ADDRESS) //Le digo que esa estructura comienza en la dirección de GPIOB
#define GPIOC   ((GPIOx_Reg_Def*)GPIOC_BASE_ADDRESS) //Le digo que esa estructura comienza en la dirección de GPIOC
#define RCC     ((RCC_Reg_Def*)RCC_BASE_ADDRESS)	//Le digo que esa estructura comienza en la dirección de RCC

// -------------------- DISPLAY CONTROL --------------------
#define ALL_DISPLAY_OFF  0x1B0 //0001 1011 0000 ubica los GPIOC a usar, más adelante encontramos uso
#define D0_CTRL          (1<<5)
#define D1_CTRL          (1<<6)
#define D2_CTRL          (1<<8)
#define D3_CTRL          (1<<9)

//Estos son las posiciones de bits para el PC5,6,8 y 9

uint8_t my_fsm = 0x00;

// -------------------- CÓDIGOS PARA 7 SEGMENTOS --------------------
#define cc_0 0b00111111
#define cc_1 0b00000110
#define cc_2 0b01011011
#define cc_3 0b01001111
#define cc_4 0b01100110
#define cc_5 0b01101101
#define cc_6 0b01111101
#define cc_7 0b00000111
#define cc_8 0b01111111
#define cc_9 0b01101111
#define cc_all_off 0b00000000

#define ca_cc_bits 0xFF //sirve más adelante para limpiar segmentos

// -------------------- VARIABLES --------------------
uint8_t time_control = 0x00;
uint8_t formato24 = 1; // 0 = 12h, 1 = 24h (inicia en 24h)

void delay_ms(uint16_t n);
uint8_t parser(uint8_t decode);

struct variablestiempo {
    uint8_t minutos_u;
    uint8_t minutos_d;
    uint8_t horas_u;
    uint8_t horas_d;
};

//Definimos inicio del clock y condición de alarma (AM)
struct variablestiempo reloj_24 = {0x00,0x00,0x00,0x00}; // 00:00
struct variablestiempo alarma1  = {0x00,0x03,0x06,0x00}; // 06:30

// -------------------- CONVERSIÓN A FORMATO DE DISPLAY --------------------
struct variablestiempo formato_display(struct variablestiempo reloj){
    struct variablestiempo temp = reloj;

    if(formato24 == 0){ // Mostrar en 12h
        uint8_t horas = reloj.horas_d*10 + reloj.horas_u;

        if(horas == 0){          // 00:xx → 12:xx AM
            horas = 12;
        } else if(horas > 12){   // 13–23 → 1–11 PM
            horas -= 12;
        }

        temp.horas_d = horas / 10;
        temp.horas_u = horas % 10;
    }
    return temp;
}

// -------------------- MAIN --------------------
int main(void) {
    // Habilitar reloj GPIO A/B/C
    RCC->IOPENR |= (1<<0) | (1<<1) | (1<<2);

    // Configuración GPIOs
    GPIOA->MODER &= ~(3 << (5*2));
    GPIOA->MODER |=  (1 << (5*2)); // PA5 salida (LED alarma)

    GPIOA->MODER &= ~(3 << (6*2));
    GPIOA->MODER |=  (1 << (6*2)); // PA6 salida (LED AM/PM)

    GPIOB->MODER &= ~((1<<15)|(1<<13)|(1<<11)|(1<<9)|(1<<7)|(1<<5)|(1<<3)|(1<<1));
    GPIOC->MODER &= ~((1<<11)|(1<<13)|(1<<17)|(1<<19));

    // Botón PC13 entrada
    GPIOC->MODER &= ~(3 << (13*2));

    // Apagar displays al inicio
    GPIOC->BSRR |= ALL_DISPLAY_OFF << 16;

    while(1) {
        // ---------- Lectura botón (cambio formato) ----------
        if((GPIOC->IDR & (1<<13)) == 0){ // presionado (activo en bajo)
            formato24 ^= 1;              // alterna formato
            delay_ms(200);               // antirrebote
        }

        // ---------- Selección de formato ----------
        struct variablestiempo reloj_mostrar = formato_display(reloj_24);

        // ---------- Multiplexado ----------
        switch (my_fsm){
            case 0:
                GPIOC->BSRR = (D3_CTRL << 16);
                GPIOB->BSRR = ca_cc_bits;
                GPIOC->BSRR = D0_CTRL;
                GPIOB->ODR  = parser(reloj_mostrar.minutos_u);
                my_fsm++;
                break;
            case 1:
                GPIOC->BSRR = (D0_CTRL << 16);
                GPIOB->BSRR = ca_cc_bits;
                GPIOC->BSRR = D1_CTRL;
                GPIOB->ODR  = parser(reloj_mostrar.minutos_d);
                my_fsm++;
                break;
            case 2:
                GPIOC->BSRR = (D1_CTRL << 16);
                GPIOB->BSRR = ca_cc_bits;
                GPIOC->BSRR = D2_CTRL;
                GPIOB->ODR  = parser(reloj_mostrar.horas_u);
                my_fsm++;
                break;
            case 3:
                GPIOC->BSRR = (D2_CTRL << 16);
                GPIOB->BSRR = ca_cc_bits;
                GPIOC->BSRR = D3_CTRL;
                GPIOB->ODR  = parser(reloj_mostrar.horas_d);
                my_fsm = 0;
                break;
        }

        // ---------- Delay multiplexado ----------
        delay_ms(1);
        time_control++;

        // ---------- Contador de tiempo ----------
        if(time_control == 60){ // 1 minuto (aproximado)
            time_control = 0;
            reloj_24.minutos_u++;

            if(reloj_24.minutos_u == 10){
                reloj_24.minutos_u = 0;
                reloj_24.minutos_d++;
            }

            if(reloj_24.minutos_d == 6){
                reloj_24.minutos_d = 0;
                reloj_24.horas_u++;

                if(reloj_24.horas_u == 10){
                    reloj_24.horas_u = 0;
                    reloj_24.horas_d++;
                }

                if(reloj_24.horas_d == 2 && reloj_24.horas_u == 4){
                    reloj_24.horas_d = 0;
                    reloj_24.horas_u = 0;
                }
            }
        }

        // ---------- LED alarma en PA5 ----------
        if(reloj_24.minutos_u == alarma1.minutos_u &&
           reloj_24.minutos_d == alarma1.minutos_d &&
           reloj_24.horas_u   == alarma1.horas_u   &&
           reloj_24.horas_d   == alarma1.horas_d)
        {
            GPIOA->ODR |=  (1<<5);   // ON
        } else {
            GPIOA->ODR &= ~(1<<5);   // OFF
        }

        // ---------- LED AM/PM en PA6 ----------
        if (reloj_24.horas_d > 1 || (reloj_24.horas_d == 1 && reloj_24.horas_u >= 2)) {
            GPIOA->ODR |=  (1<<6);   // PM → ON
        } else {
            GPIOA->ODR &= ~(1<<6);   // AM → OFF
        }
    }
}

// -------------------- FUNCIONES --------------------
void delay_ms(uint16_t n){
    uint16_t i;
    for(; n>0; n--){
        for(i=0; i<140; i++);
    }
}

uint8_t parser(uint8_t decode){
    switch(decode){
        case 0: return cc_0;
        case 1: return cc_1;
        case 2: return cc_2;
        case 3: return cc_3;
        case 4: return cc_4;
        case 5: return cc_5;
        case 6: return cc_6;
        case 7: return cc_7;
        case 8: return cc_8;
        case 9: return cc_9;
        default: return cc_all_off;
    }
}

