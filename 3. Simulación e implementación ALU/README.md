# Implementación de una ALU de 4 bits en Logisim Evolution y Vivado

## Descripción
Este proyecto implementa una **Unidad Lógica Aritmética (ALU) de 4 bits** utilizando dos entornos:
- **Logisim Evolution**: diseño esquemático con compuertas, multiplexores y bloques jerárquicos.
- **Vivado (SystemVerilog)**: implementación en HDL para síntesis y simulación con XSim.

La ALU es capaz de realizar operaciones aritméticas y lógicas básicas, además de generar **banderas (flags)** que describen el resultado.

---

## Funcionalidades de la ALU
- **Operaciones soportadas:**
  - Suma (`A + B`)
  - Resta (`A - B`)
  - AND (`A & B`)
  - OR (`A | B`)
  - Shift lógico a la izquierda (`A << n`)
  - Shift lógico a la derecha (`A >> n`)

- **Flags generados:**
  - **Zero (Z):** activo cuando el resultado es `0000`.
  - **Negative (N):** refleja el bit más significativo (MSB) en complemento a dos.
  - **Carry (C):** acarreo de la operación de suma/resta.
  - **Overflow (V):** activo cuando ocurre desbordamiento en operaciones aritméticas con signo.

---

## Implementación en Logisim Evolution
- Diseño modular con:
  - **Bloque de sumador/restador** implementado con **prefix adder**.
  - **Bloques de desplazamiento (shift)** hechos con multiplexores.
  - **Bloques de lógica (AND/OR)**.
  - **Generador de banderas** (`Zero`, `Negativo`, `Carry`, `Overflow`).
- Se usaron multiplexores para seleccionar la operación según el código de control (`OP`).

---

##  Implementación en Vivado (SystemVerilog)
- Implementación jerárquica:
  - `Prefix_Logic`: es el sumador Prefix completo, cada uno de sus módulos fue creado en diversos archivos.
  - `Suma y resta`: suma/resta de 4 bits con cálculo rápido de carry.
  - `Shift_Left` y `Shift_Right`: corrimiento controlado por `SL`/`SR`.
  - `Flags`: bloque que permite calcular las flags del sistema.
  - `ALU`: módulo superior que integra las operaciones y selecciona mediante `OP` para operaciones y `OP_S` tipo de corrimiento.
---

