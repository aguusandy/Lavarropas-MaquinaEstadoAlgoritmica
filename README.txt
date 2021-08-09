# Lavarropas-MaquinaEstadoAlgoritmica

Los autores del código son: Agustin Andino y Lorenzo Lopez. El siguiente código es el resultado de un informe educativo.

El codigo corresponde a una máquina de estado algorítmico que representa una implementación de un lavarropas.
La máquina está dividida en distintos programas básico, los cuales son: Lavado, Enjuague y Centrifugado.
El usuario puede ingresar distintos tipos de programas establecidos por los códigos:

-000: No se ejecuta nada.
-001: Lavado.
-010: Enjuague.
-011: Lavado y Enjuague.
-100: Centrifugado.
-101: Lavado y Centrifugado.
-111: Lavado, Enjuague y Centrifugado.

El módulo top corresponde al lavarropas en sí, que contiene una implementación de Lavado, Enjuague y Centrifugado.
Las entradas de la máquina s0,s2 y s3, corresponden a los niveles de agua del lavarropas donde, s0 en '1' indica que no hay agua en el lavarropas, cuando s2 es '1' se utilizan distintas válvulas de llenado dependiendo del programa elegido, si es Lavado se llenará con valvula de jabón hasta s3, si es Enjuague con valvula de suavizante.
Las salidas de la máquina corresponden a los tres led que indican en que estado se encuentra, y uno más que indica si la tapa está trabada o no.
La máquina utiliza procesos para pasar de un estado a otro, procesos para actualizar el led de la tapa y un proceso para utilizar las distitnas implementaciones.
Dentro de cada implementación se estableció un contador para llevar el tiempo de funcionamiento el motor.

Tener en cuenta que para que esta máquina de estado presente un buen funcionamiento a través del testbench se debe copiar tal cual las pruebas provistas, ya que los tiempos establecidos y la secuencia de señales en otro orden pueden hacer que la máquina muestre un funcionamiento incorrecto.

Cualquier duda consultar al siguiente mail:
daandino1998@gmail.com
