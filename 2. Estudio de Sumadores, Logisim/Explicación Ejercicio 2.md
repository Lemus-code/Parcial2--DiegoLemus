# Estudio de Sumadores, simulación en Logisim

En este inciso nos enfocaremos en construir 3 tipos de sumadores en el software **Logisim Evolution**:  

1. **Ripple-Carry Adder (RCA)**  
2. **Carry-Lookahead Adder (CLA)**  
3. **Prefix Adder (PA)**  

A continuación se detalla qué es cada uno de ellos y cómo funcionan.

---

## 🔹 Ripple-Carry Adder
El **Ripple-Carry** se construye encadenando *Full Adders*.  
- Cada bit suma `Aᵢ + Bᵢ + Cᵢₙ`.  
- El *carry out* de un FA se conecta al *carry in* del siguiente.  
- **Ventaja:** diseño sencillo, ocupa pocas compuertas.  
- **Desventaja:** lento, porque el carry debe propagarse a través de todos los bits (retardo lineal en `n`).  

---

## Carry-Lookahead Adder
El **Carry-Lookahead** introduce lógica adicional para calcular los carries en paralelo:  
- Define señales de **propagate** `Pᵢ = Aᵢ ⊕ Bᵢ` y **generate** `Gᵢ = Aᵢ · Bᵢ`.  
- Con esas señales, la lógica de *look-ahead* predice los valores de `C₁, C₂, C₃...` sin esperar la propagación secuencial.  
- **Ventaja:** mucho más rápido que el ripple (retardo ≈ log(n)).  
- **Desventaja:** mayor complejidad, más compuertas y área ocupada.  

---

## Prefix Adder
El **Prefix Adder** (ej. Kogge-Stone, Brent-Kung, Sklansky) organiza los cálculos de P/G en un **árbol de etapas** (*rounds* o *columns*):  
- Combina pares de `(P,G)` de forma jerárquica hasta obtener los carries globales.  
- Requiere `log₂(n)` niveles de lógica para resolver todos los carries.  
- **Ventaja:** altísima velocidad (ideal para procesadores de 32, 64 bits).  
- **Desventaja:** más cableado y muchas compuertas, ocupa más área.  

---

## Comparación de arquitecturas
- **Ripple-Carry:** simple, bajo costo, lento (retardo lineal).  
- **Carry-Lookahead:** balance entre velocidad y área, ideal para 4–16 bits.  
- **Prefix:** más rápido de todos (retardo logarítmico), pero con mucho costo en hardware.  

---

### Aplicaciones recomendadas
- **Aplicaciones lentas con restricción de espacio/presupuesto:**  
  Usar **Ripple-Carry Adder**.  

- **Aplicaciones rápidas sin restricción de espacio/presupuesto:**  
  Usar **Prefix Adder**.  

- **Aplicaciones rápidas con restricción de espacio/presupuesto:**  
  Usar **Carry-Lookahead Adder**, ya que ofrece buena velocidad con menos compuertas que un prefix.  

---

## Video de simulación y explicación
![Adders_Diego_Lemus][Enlace a YouTube aquí]
