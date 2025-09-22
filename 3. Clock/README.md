# Reloj digital 12/24h con alarma en STM32 (Bare Metal)

## Descripción General
Este proyecto implementa un **reloj digital con formato 12/24 horas**, alarma y visualización en **displays de 7 segmentos multiplexados**, utilizando un **microcontrolador STM32** en **programación bare metal (sin HAL)** y montado en **protoboard**.  

El diseño permite:
- Mostrar la hora en formato **24h** o **12h AM/PM** (seleccionable con botón).  
- Indicar **AM/PM** mediante un LED.  
- Activar un **LED de alarma** a una hora predefinida.  
- Visualizar la hora en **4 displays de 7 segmentos multiplexados**.  

---

## Funcionalidades Principales
- **Formato horario alternable**:  
  - Botón en **PC13** permite cambiar entre 12h y 24h.  
  - Control mediante `formato24` (`0 = 12h`, `1 = 24h`).  

- **Alarma fija**:  
  - Configurada en el struct `alarma1`.  
  - Al coincidir con la hora actual, enciende **LED en PA5**.  

- **Indicador AM/PM**:  
  - **LED en PA6** se enciende en horas PM y se apaga en AM.  

- **Multiplexado de displays**:  
  - 4 dígitos controlados por `my_fsm` (máquina de estados).  
  - Segmentos manejados desde **GPIOB**.  
  - Displays habilitados desde **GPIOC**.  

- **Parser de dígitos**:  
  - Convierte valores 0–9 en patrones de 7 segmentos (`parser()`).  

---

## Implementación en hardware
- **Microcontrolador**: STM32 (familia Cortex-M0/M3).  
- **Displays de 7 segmentos**: 4 unidades, multiplexadas.  
- **Protoboard**: conexiones directas para prototipo.  
- **LEDs**:  
  - **PA5** → LED alarma.  
  - **PA6** → LED AM/PM.  
- **Botón de usuario (PC13)**: cambio de formato 12/24h.  

---

## Organización del Código
1. **Direcciones base y estructuras**: acceso directo a registros (`GPIOx`, `RCC`).  
2. **Macros de control**:  
   - `D0_CTRL–D3_CTRL` → habilitación de displays.  
   - `ca_cc_bits` → máscara para limpiar segmentos.  
3. **Variables de tiempo**:  
   - `reloj_24` → hora interna en formato 24h.  
   - `alarma1` → hora fija de la alarma.  
4. **Función `formato_display()`**: conversión de 24h a 12h para el display.  
5. **Loop principal**:  
   - Lectura del botón y antirrebote.  
   - Multiplexado de los 4 displays.  
   - Contador de tiempo (minutos y horas).  
   - Activación de LEDs (alarma y AM/PM).  
6. **Funciones auxiliares**:  
   - `delay_ms()` → retardos por bucle.  
   - `parser()` → tabla de conversión de números a segmentos.  

---

## Video de demostración
Explicación del funcionamiento, prototipo en protoboard y ejecución en STM32:  
[Ver video](https://youtu.be/4NbTO-8IHlQ)  
