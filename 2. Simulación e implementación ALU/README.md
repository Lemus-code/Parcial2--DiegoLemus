# Implementación de una ALU de 4 bits en Logisim Evolution y Vivado

## Descripción General
Este proyecto desarrolla una **Unidad Lógica Aritmética (ALU) de 4 bits**, implementada en dos entornos complementarios:  
- **Logisim Evolution** → Diseño esquemático con compuertas, multiplexores y bloques jerárquicos.  
- **Vivado (SystemVerilog)** → Modelado en HDL, síntesis y simulación con XSim.  

La ALU permite realizar operaciones aritméticas y lógicas básicas, además de generar **banderas (flags)** que describen el estado del resultado. Este diseño busca ilustrar tanto el enfoque de **simulación académica** como el de **implementación en hardware digital**.
Es importante destacar que esta ALU **no incluye el uso de complemento a 2**.  

---

## Funcionalidades de la ALU
### Operaciones soportadas
- **Suma** (`A + B`)  
- **Resta** (`A - B`)  
- **AND** (`A & B`)  
- **OR** (`A | B`)  
- **Shift lógico a la izquierda** (`A << n`)  
- **Shift lógico a la derecha** (`A >> n`)  

### Flags generados
- **Zero (Z):** activo si el resultado es `0000`.  
- **Negative (N):** refleja el MSB en complemento a dos.  
- **Carry (C):** acarreo generado en suma/resta.  
- **Overflow (V):** indica desbordamiento en operaciones aritméticas con signo.  

---

## Implementación en Logisim Evolution
El diseño se estructuró de forma modular:  
- **Bloque aritmético**: suma/resta implementada con un **prefix adder** de 4 bits.  
- **Bloques de corrimiento**: desplazamientos lógicos construidos mediante **multiplexores**.  
- **Bloques lógicos**: operaciones AND y OR.  
- **Generador de banderas**: cálculo en paralelo de `Zero`, `Negative`, `Carry` y `Overflow`.  

La selección de operaciones se realiza a través de un **código de control (`OP`)**, gestionado con multiplexores jerárquicos.  

---

## Implementación en Vivado (SystemVerilog)
El modelo en HDL también sigue un esquema jerárquico:  
- **Prefix_Logic:** sumador prefix completo, implementado módulo a módulo en archivos separados.  
- **Suma/Resta:** módulo de 4 bits con cálculo eficiente de `Carry`.  
- **Shift_Left / Shift_Right:** operaciones de corrimiento controladas por `SL` / `SR`.  
- **Flags:** bloque dedicado al cálculo centralizado de banderas.  
- **ALU (top module):** integra todas las operaciones y selecciona mediante señales de control (`OP`, `OP_S`).  

La simulación en **XSim (Vivado)** permitió verificar la consistencia entre la implementación esquemática y la HDL.  

---

## Recursos audiovisuales
- **Demostración en Logisim Evolution:** [Ver video](https://youtu.be/m7PWGE1w8WU)  
- **Demostración en Vivado (SystemVerilog):** [Ver video](https://youtu.be/tPD14BhLtFE)  
