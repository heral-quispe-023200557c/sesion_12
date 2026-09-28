# 🚀 Sesión 12: Ciclo de Vida de un StatefulWidget en Flutter

Este proyecto contiene la implementación y demostración en consola del **Ciclo de Vida completo de un `StatefulWidget`** en Flutter, respondiendo a los requerimientos de la Sesión 12.

---

## 📊 Diagrama de Flujo del Ciclo de Vida (ASCII)

```text
               +-----------------------------------+
               | INICIO: Instanciación del Widget  |
               +-----------------------------------+
                                 |
                                 v
                    +-------------------------+
                    |    1. createState()     |  <-- mounted = false
                    +-------------------------+
                                 |
                                 v
                     =========================
                        mounted = true (Context)
                     =========================
                                 |
                                 v
                    +-------------------------+
                    |    2. initState()       |  <-- Una sola vez
                    +-------------------------+
                                 |
                                 v
                    +-------------------------+
                    | 3. didChangeDependencies|  <-- 1 o más veces
                    +-------------------------+
                                 |
                                 +<--------------------------+
                                 |                           |
                                 v                           |
                    +-------------------------+              |
            +-----> |      4. build()         |              |
            |       +-------------------------+              |
            |                    |                           |
            |             [ Eventos / UI ]                   |
     (setState)           /              \                   |
            |            /                \                  |
            +-----------+                  v                 |
                                 +-------------------+       |
                                 | 5. didUpdateWidget| ------+
                                 +-------------------+
                                   (Reconstrucción Padre)
                                 |
                                 v (Desmontaje)
                    +-------------------------+
                    |    6. deactivate()      |  <-- Temporal
                    +-------------------------+
                                 |
                                 v
                    +-------------------------+
                    |    7. dispose()         |  <-- Una sola vez
                    +-------------------------+
                                 |
                                 v
                     =========================
                        mounted = false (GC)
                     =========================
