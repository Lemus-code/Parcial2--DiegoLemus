# Estudio de Sumadores en Logisim Evolution

## Descripción General
En este estudio se construyeron y analizaron **tres arquitecturas de sumadores de 4 bits** utilizando el software **Logisim Evolution**:  

1. **Ripple-Carry Adder (RCA)**  
2. **Carry-Lookahead Adder (CLA)**  
3. **Prefix Adder (PA)**  

El objetivo es comparar **ventajas, desventajas y rendimiento temporal** de cada diseño para entender sus aplicaciones prácticas.

---

## Ripple-Carry Adder (RCA)
El **Ripple-Carry** se construye encadenando *Full Adders*:  
- Cada bit suma `Aᵢ + Bᵢ + Cᵢₙ`.  
- El *carry out* de un FA se conecta al *carry in* del siguiente.  

**Ventajas**  
- Diseño sencillo.  
- Bajo costo en compuertas y área.  

**Desventajas**  
- Lento: el carry debe propagarse bit por bit.  

---

## Carry-Lookahead Adder (CLA)
El **Carry-Lookahead** introduce lógica adicional para calcular los *carries* en paralelo:  
- Señales de **propagate** `Pᵢ = Aᵢ ⊕ Bᵢ` y **generate** `Gᵢ = Aᵢ · Bᵢ`.  
- La lógica *look-ahead* predice `C₁, C₂, C₃...` sin esperar propagación secuencial.  

**Ventajas**  
- Mucho más rápido que el RCA.  
- Buena alternativa cuando se necesita velocidad.  

**Desventajas**  
- Mayor complejidad.  
- Requiere más compuertas y área que el RCA.  

---

## Prefix Adder (PA)
El **Prefix Adder** organiza los cálculos de P/G en un **árbol jerárquico** (*rounds* o *columns*):  
- Combina `(P,G)` en niveles hasta obtener los *carries* globales.  
- Resuelve en `log₂(n)` etapas.  

**Ventajas**  
- Es el más rápido de todos.  
- Excelente desempeño en arquitecturas de gran cantidad de bits.  

**Desventajas**  
- Complejo de cablear.  
- Gran cantidad de compuertas, alto consumo de área.  

---

## Comparación de Arquitecturas
| Arquitectura        | Ventaja Principal       | Desventaja Principal       | Tiempo (4 bits) |
|---------------------|-------------------------|----------------------------|-----------------|
| Ripple-Carry (RCA)  | Simplicidad y bajo costo | Muy lento                  | **129.2 ns**    |
| Carry-Lookahead (CLA)| Buen balance velocidad/área | Complejidad moderada   | **193.1 ns**    |
| Prefix Adder (PA)   | Máxima velocidad         | Alto costo en hardware     | **57.04 ns**    |

*Nota:* En este caso el CLA fue más lento que el RCA debido a que se implementó en **4 bits**. La ventaja real del CLA se observa al escalar a **mayor cantidad de bits**.  

---

## Aplicaciones Recomendadas
- **Aplicaciones lentas con restricción de área/presupuesto:** usar **Ripple-Carry**.  
- **Aplicaciones rápidas sin restricción de área:** usar **Prefix Adder**.  
- **Aplicaciones rápidas con recursos limitados:** usar **Carry-Lookahead**, ya que ofrece un balance entre complejidad y desempeño.  

---

## Video de simulación y explicación
Explicación de los tres sumadores, construcción en Logisim y análisis de tiempos:  
[Ver video](https://youtu.be/dz2VMQQZ2Hw)
