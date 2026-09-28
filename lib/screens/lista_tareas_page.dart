import 'package:flutter/material.dart';
import '../models/tarea.dart';

class ListaTareasPage extends StatefulWidget {
  const ListaTareasPage({super.key});

  @override
  State<ListaTareasPage> createState() => _ListaTareasPageState();
}

class _ListaTareasPageState extends State<ListaTareasPage> {
  // Estado efímero: Lista de tareas y controlador de texto
  final List<Tarea> _tareas = [];
  final TextEditingController _controlador = TextEditingController();

  // Agrega una nueva tarea a la lista
  void _agregarTarea() {
    final texto = _controlador.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _tareas.add(Tarea(titulo: texto));
        _controlador.clear();
      });
    }
  }

  // Alterna el estado de completado
  void _alternarEstadoTarea(int index) {
    setState(() {
      _tareas[index].completada = !_tareas[index].completada;
    });
  }

  // Elimina una tarea
  void _eliminarTarea(int index) {
    setState(() {
      _tareas.removeAt(index);
    });
  }

  // Liberación de recursos
  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Tareas (setState)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Error corregido: se eliminó el "style"
        child: Column(
          children: [
            // ÁREA DE ENTRADA DE DATOS
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controlador,
                    decoration: const InputDecoration(
                      labelText: 'Nueva tarea',
                      hintText: 'Ej. Revisar entregable de Flutter',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _agregarTarea(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _agregarTarea,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ÁREA REACTIVA: RENDERIZADO CONDICIONAL DE LA LISTA
            Expanded(
              child: _tareas.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No hay tareas registradas.\n¡Agrega una para comenzar!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = _tareas[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: CheckboxListTile(
                            value: tarea.completada,
                            title: Text(
                              tarea.titulo,
                              style: TextStyle(
                                decoration: tarea.completada
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tarea.completada
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            onChanged: (_) => _alternarEstadoTarea(index),
                            secondary: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              tooltip: 'Eliminar tarea',
                              onPressed: () => _eliminarTarea(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}