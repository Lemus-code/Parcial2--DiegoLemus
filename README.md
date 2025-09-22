#  Resumen de Implementaciones Digitales y de Microcontroladores

Este documento resume los proyectos desarrollados y documentados en protoboard, Logisim Evolution y Vivado, integrando prácticas de **diseño digital, HDL y programación bare metal en STM32**.

---


## FSM VivePass (control de parqueo)
- **Plataforma:** Vivado, con HDL (Moore/Mealy).  
- **Funcionalidad:** validación de stickers de 3 dígitos para acceso a parqueos sin tickets.  
- **Implementación:**  
  - FSM para lectura de código.  
  - Integración de estados “abierto/cerrado”.  
  - Control de displays mediante entradas/salidas.  
- **Documentación:** diagramas, tabla de entradas/salidas y explicación en video.  
[Video Vivado](https://www.youtube.com/watch?v=WgIRPq6yPKE)
---

## Estudio de sumadores (4 bits)
- **Sumadores implementados:** Ripple-Carry, Carry-Lookahead y Prefix Adder.  
- **Análisis comparativo:**  
  - Ripple-Carry → simple pero lento (129.2 ns).  
  - Carry-Lookahead → balance entre velocidad y área (193.1 ns en 4 bits, mejora al escalar).  
  - Prefix → más rápido de todos (57.04 ns) pero con más compuertas.  
- **Aplicaciones:**  
  - Bajo costo: RCA.  
  - Rápido con límite de área: CLA.  
  - Máxima velocidad: Prefix.  
- [Video explicación](https://youtu.be/dz2VMQQZ2Hw)

---

## ALU de 4 bits
- **Entornos:** Logisim Evolution (esquemático) y Vivado con SystemVerilog (HDL).  
- **Operaciones soportadas:** suma, resta, AND, OR, shift lógico izq/der.  
- **Flags:** Zero, Negative, Carry, Overflow.  
- **Arquitectura:** diseño modular con bloques de suma/resta, lógica, shifts y generador de flags.  
- [Video Logisim](https://youtu.be/m7PWGE1w8WU) | [Video Vivado](https://youtu.be/tPD14BhLtFE)

---

## Reloj digital 12/24h con alarma (STM32, bare metal)
- **Prototipo en protoboard.**  
- **Microcontrolador STM32 (GPIO directos sin HAL).**  
- **Características:**  
  - Hora en formato 24h (base), conversión a 12h en visualización.  
  - Botón en PC13 alterna entre 12/24h.  
  - LED alarma en PA5 (hora fija en código).  
  - LED AM/PM en PA6.  
  - Multiplexado de 4 displays de 7 segmentos controlados por GPIOB/GPIOC.  
- **Funciones clave:** `formato_display()`, `parser()`, `delay_ms()`.  
- [Video prototipo](https://youtu.be/4NbTO-8IHlQ)

---

## Conclusiones Generales
1. La combinación de **simulación digital (Logisim/Vivado)** y **prototipado en hardware (STM32)** refuerza la comprensión entre teoría y práctica.  
2. El **multiplexado** es fundamental para optimizar recursos en displays y sistemas embebidos.  
3. Mantener la hora en **24h internamente** y solo convertir a **12h para visualización** simplifica el diseño.  
4. El uso de **bare metal** en STM32 permite dominar el acceso a registros, aunque conlleva mayor complejidad de programación.  
5. Cada arquitectura (ALU, sumadores, FSM, reloj) demuestra distintos compromisos entre **velocidad, área, simplicidad y costo**, aplicables según la necesidad del sistema.  
