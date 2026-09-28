import 'package:flutter/material.dart';

void main() {
  runApp(const CicloVidaCyberApp());
}

class CicloVidaCyberApp extends StatelessWidget {
  const CicloVidaCyberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ciclo de Vida State - Cyber UI',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090D16),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          secondary: Color(0xFF8B5CF6),
          surface: Color(0xFF111827),
        ),
        fontFamily: 'Segoe UI',
      ),
      home: const DashboardCicloVida(),
    );
  }
}

class DashboardCicloVida extends StatefulWidget {
  const DashboardCicloVida({super.key});

  @override
  State<DashboardCicloVida> createState() {
    // 1. MÉTODOS EXIGIDOS POR RÚBRICA CON PRINT()
    // ignore: avoid_print
    print('1. createState() ejecutado | mounted: false');
    return _DashboardCicloVidaState();
  }
}

class _DashboardCicloVidaState extends State<DashboardCicloVida> {
  int _pasoIndice = 0;
  int _pestanaCodigo = 0;

  // 2. initState()
  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('2. initState() ejecutado | mounted: $mounted');
  }

  // 3. didChangeDependencies()
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ignore: avoid_print
    print('3. didChangeDependencies() ejecutado | mounted: $mounted');
  }

  // 4. didUpdateWidget()
  @override
  void didUpdateWidget(covariant DashboardCicloVida oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ignore: avoid_print
    print('5. didUpdateWidget() ejecutado | mounted: $mounted');
  }

  // 5. deactivate()
  @override
  void deactivate() {
    // ignore: avoid_print
    print('6. deactivate() ejecutado | mounted: $mounted');
    super.deactivate();
  }

  // 6. dispose()
  @override
  void dispose() {
    // ignore: avoid_print
    print('7. dispose() ejecutado | mounted antes de destruir: $mounted');
    super.dispose();
  }

  final List<PasoCicloData> _pasos = [
    PasoCicloData(
      numero: 1,
      metodo: 'Constructor',
      subtitulo: 'StatefulWidget',
      isMounted: false,
      fase: 'Instanciación',
      descripcion:
          'Se ejecuta al evaluar la jerarquía del árbol. Recibe la configuración inicial inmutable (parámetros y keys). El objeto State aún no ha sido creado.',
      codigoCorrecto:
          'class MiWidget extends StatefulWidget {\n  final String titulo;\n  const MiWidget({super.key, required this.titulo});\n}',
      codigoIncorrecto:
          'class MiWidget extends StatefulWidget {\n  int contador = 0; // ❌ Estado mutable directamente en el StatefulWidget\n}',
    ),
    PasoCicloData(
      numero: 2,
      metodo: 'createState()',
      subtitulo: 'Creación del estado',
      isMounted: false,
      fase: 'Instanciación',
      descripcion:
          'Invocado por el framework inmediatamente después del constructor. Instancia y retorna la clase State asociada al widget.',
      codigoCorrecto:
          '@override\nState<MiWidget> createState() => _MiWidgetState();',
      codigoIncorrecto:
          '@override\nState<MiWidget> createState() {\n  peticionApi(); // ❌ Efectos secundarios o llamadas asíncronas aquí\n  return _MiWidgetState();\n}',
    ),
    PasoCicloData(
      numero: 3,
      metodo: 'mounted = true',
      subtitulo: 'Vinculación de contexto',
      isMounted: true,
      fase: 'Montaje',
      descripcion:
          'Transición de estado donde el objeto State se enlaza al BuildContext del árbol. A partir de este momento la propiedad boolean mounted pasa a ser true.',
      codigoCorrecto:
          'void guardar() async {\n  await peticion();\n  if (mounted) setState(() => exito = true);\n}',
      codigoIncorrecto:
          'void guardar() async {\n  await peticion();\n  setState(() => exito = true); // ❌ Se llama setState sin verificar mounted\n}',
    ),
    PasoCicloData(
      numero: 4,
      metodo: 'initState()',
      subtitulo: 'Inicialización única',
      isMounted: true,
      fase: 'Montaje',
      descripcion:
          'Se invoca una sola vez cuando el estado es montado. Reservado para inicializar controladores de texto, animaciones o suscripciones a Streams.',
      codigoCorrecto:
          '@override\nvoid initState() {\n  super.initState();\n  _controller = TextEditingController();\n}',
      codigoIncorrecto:
          '@override\nvoid initState() {\n  // ❌ Faltó super.initState()\n  final tema = Theme.of(context); // ❌ Contexto inestable durante initState\n}',
    ),
    PasoCicloData(
      numero: 5,
      metodo: 'didChangeDependencies()',
      subtitulo: 'Cambio de dependencias',
      isMounted: true,
      fase: 'Montaje / Actualización',
      descripcion:
          'Ejecutado inmediatamente después de initState() y cada vez que cambia un InheritedWidget del cual depende este contexto (ej. Theme, Provider).',
      codigoCorrecto:
          '@override\nvoid didChangeDependencies() {\n  super.didChangeDependencies();\n  _color = Theme.of(context).primaryColor;\n}',
      codigoIncorrecto:
          '@override\nvoid didChangeDependencies() {\n  super.didChangeDependencies();\n  setState(() {}); // ❌ Provoca un bucle infinito de renderizado\n}',
    ),
    PasoCicloData(
      numero: 6,
      metodo: 'build()',
      subtitulo: 'Renderizado visual',
      isMounted: true,
      fase: 'Renderizado',
      descripcion:
          'Construye la interfaz gráfica. Se invoca múltiples veces. setState() solicita una reconstrucción directa ejecutando este método nuevamente.',
      codigoCorrecto:
          '@override\nWidget build(BuildContext context) {\n  return Scaffold(body: Text("\$_contador"));\n}',
      codigoIncorrecto:
          '@override\nWidget build(BuildContext context) {\n  cargarDatosServidor(); // ❌ Petición HTTP dentro de build (se repite N veces)\n  return Text("Data");\n}',
      esBucleSetState: true,
    ),
    PasoCicloData(
      numero: 7,
      metodo: 'didUpdateWidget()',
      subtitulo: 'Mutación del Padre',
      isMounted: true,
      fase: 'Actualización',
      descripcion:
          'Se activa si el widget Padre se redibuja enviando nuevas propiedades. Permite evaluar oldWidget frente a widget y actualizar el estado si cambió.',
      codigoCorrecto:
          '@override\nvoid didUpdateWidget(MiWidget oldWidget) {\n  super.didUpdateWidget(oldWidget);\n  if (oldWidget.id != widget.id) _recargar();\n}',
      codigoIncorrecto:
          '@override\nvoid didUpdateWidget(MiWidget oldWidget) {\n  super.didUpdateWidget(oldWidget);\n  _recargar(); // ❌ Se ejecuta sin comprobar si la propiedad cambió\n}',
    ),
    PasoCicloData(
      numero: 8,
      metodo: 'deactivate()',
      subtitulo: 'Desmontaje temporal',
      isMounted: true,
      fase: 'Desmontaje',
      descripcion:
          'Se invoca cuando el widget es retirado temporalmente del árbol visual. Puede volver a reinsertarse en otra sección dentro de la misma trama.',
      codigoCorrecto:
          '@override\nvoid deactivate() {\n  _reproductor.pause();\n  super.deactivate();\n}',
      codigoIncorrecto:
          '@override\nvoid deactivate() {\n  _controller.dispose(); // ❌ Destruir controladores aquí impide su reutilización\n  super.deactivate();\n}',
    ),
    PasoCicloData(
      numero: 9,
      metodo: 'dispose()',
      subtitulo: 'Destrucción permanente',
      isMounted: true,
      fase: 'Destrucción',
      descripcion:
          'Método terminal. Se invoca una única vez cuando el estado es removido de forma definitiva. Libera memoria cerrando controllers y listeners.',
      codigoCorrecto:
          '@override\nvoid dispose() {\n  _controller.dispose();\n  super.dispose();\n}',
      codigoIncorrecto:
          '@override\nvoid dispose() {\n  setState(() {}); // ❌ Intentar redibujar un widget en proceso de destrucción\n  super.dispose();\n}',
    ),
    PasoCicloData(
      numero: 10,
      metodo: 'mounted = false',
      subtitulo: 'Garbage Collection',
      isMounted: false,
      fase: 'Destrucción',
      descripcion:
          'El objeto State queda desvinculado por completo del BuildContext. Jamás podrá reconectarse y el recolector de basura (GC) destruye el objeto.',
      codigoCorrecto:
          '// El objeto State ya no existe en memoria.',
      codigoIncorrecto:
          '// Mantener referencias estáticas o globales al objeto State destruido.',
    ),
  ];

  // 7. build()
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('4. build() ejecutado | mounted: $mounted');

    final pasoActual = _pasos[_pasoIndice];
    final progress = (_pasoIndice + 1) / _pasos.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _construirHeaderSuperior(progress),
            _construirTimelineHorizontal(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _construirBarraInfoPaso(pasoActual),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool esPantallaAncha = constraints.maxWidth > 850;
                        return Flex(
                          direction: esPantallaAncha
                              ? Axis.horizontal
                              : Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: esPantallaAncha ? 5 : 0,
                              child: _construirTarjetaDescripcion(pasoActual),
                            ),
                            if (esPantallaAncha)
                              const SizedBox(width: 20)
                            else
                              const SizedBox(height: 20),
                            Expanded(
                              flex: esPantallaAncha ? 7 : 0,
                              child: _construirVisorCodigo(pasoActual),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            _construirNavegacionInferior(),
            _construirFooterCreditos(),
          ],
        ),
      ),
    );
  }

  Widget _construirHeaderSuperior(double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        border: Border(bottom: BorderSide(color: Color(0xFF1F2937))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.hub_rounded, color: Color(0xFF6366F1), size: 28),
                  SizedBox(width: 12),
                  Text(
                    'State Lifecycle Lab',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF6366F1)),
                ),
                child: Text(
                  'Paso ${_pasoIndice + 1} de 10',
                  style: const TextStyle(
                    color: Color(0xFFA5B4FC),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF1F2937),
              color: const Color(0xFF6366F1),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirTimelineHorizontal() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xFF0D1322),
        border: Border(bottom: BorderSide(color: Color(0xFF1F2937))),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _pasos.length,
        itemBuilder: (context, index) {
          final paso = _pasos[index];
          final esSeleccionado = index == _pasoIndice;

          return GestureDetector(
            onTap: () {
              // ignore: avoid_print
              print('\n---> Se ejecuta setState() al cambiar paso');
              setState(() {
                _pasoIndice = index;
                _pestanaCodigo = 0;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: esSeleccionado
                    ? const Color(0xFF6366F1)
                    : const Color(0xFF111827),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: esSeleccionado
                      ? const Color(0xFF818CF8)
                      : const Color(0xFF374151),
                  width: esSeleccionado ? 2 : 1,
                ),
                boxShadow: esSeleccionado
                    ? [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: esSeleccionado
                        ? Colors.white
                        : const Color(0xFF1F2937),
                    child: Text(
                      '${paso.numero}',
                      style: TextStyle(
                        color: esSeleccionado
                            ? const Color(0xFF6366F1)
                            : Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        paso.metodo,
                        style: TextStyle(
                          color: esSeleccionado ? Colors.white : Colors.grey[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        paso.fase,
                        style: TextStyle(
                          color: esSeleccionado
                              ? const Color(0xFFE0E7FF)
                              : Colors.grey[600],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _construirBarraInfoPaso(PasoCicloData paso) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paso.fase.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF818CF8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              paso.metodo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: paso.isMounted
                ? const Color(0xFF065F46).withOpacity(0.4)
                : const Color(0xFF991B1B).withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: paso.isMounted
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                paso.isMounted ? Icons.check_circle : Icons.cancel,
                color: paso.isMounted
                    ? const Color(0xFF34D399)
                    : const Color(0xFFF87171),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'mounted = ${paso.isMounted}',
                style: TextStyle(
                  color: paso.isMounted
                      ? const Color(0xFF34D399)
                      : const Color(0xFFF87171),
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _construirTarjetaDescripcion(PasoCicloData paso) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Color(0xFF818CF8), size: 20),
              SizedBox(width: 8),
              Text(
                'Comportamiento y Reglas',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            paso.descripcion,
            style: const TextStyle(
              color: Color(0xFFD1D5DB),
              fontSize: 15,
              height: 1.6,
            ),
          ),
          if (paso.esBucleSetState) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF064E3B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF059669)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.sync_rounded, color: Color(0xFF34D399)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Bucle setState(): Invocar setState() retorna directo a build() sin volver a ejecutar initState().',
                      style: TextStyle(color: Color(0xFFA7F3D0), fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _construirVisorCodigo(PasoCicloData paso) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF21262D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF161B22),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                _construirBotonPestana(
                  indice: 0,
                  label: '✅ Uso Correcto',
                  colorActivo: const Color(0xFF10B981),
                ),
                const SizedBox(width: 8),
                _construirBotonPestana(
                  indice: 1,
                  label: '❌ Antipatrón / Incorrecto',
                  colorActivo: const Color(0xFFEF4444),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                _pestanaCodigo == 0
                    ? paso.codigoCorrecto
                    : paso.codigoIncorrecto,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  height: 1.5,
                  color: _pestanaCodigo == 0
                      ? const Color(0xFFE6EDF3)
                      : const Color(0xFFFCA5A5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirBotonPestana({
    required int indice,
    required String label,
    required Color colorActivo,
  }) {
    final seleccionada = _pestanaCodigo == indice;

    return InkWell(
      onTap: () {
        // ignore: avoid_print
        print('\n---> Se ejecuta setState() al cambiar pestaña');
        setState(() => _pestanaCodigo = indice);
      },
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: seleccionada ? colorActivo.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: seleccionada ? colorActivo : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: seleccionada ? colorActivo : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _construirNavegacionInferior() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        border: Border(top: BorderSide(color: Color(0xFF1F2937))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            onPressed: _pasoIndice > 0
                ? () {
                    // ignore: avoid_print
                    print('\n---> Se ejecuta setState() al presionar Anterior');
                    setState(() {
                      _pasoIndice--;
                      _pestanaCodigo = 0;
                    });
                  }
                : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Anterior'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF374151)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _pasoIndice < _pasos.length - 1
                ? () {
                    // ignore: avoid_print
                    print('\n---> Se ejecuta setState() al presionar Siguiente');
                    setState(() {
                      _pasoIndice++;
                      _pestanaCodigo = 0;
                    });
                  }
                : null,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Siguiente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirFooterCreditos() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF090D16),
        border: Border(top: BorderSide(color: Color(0xFF1F2937))),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 8,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_outline_rounded, color: Color(0xFF818CF8), size: 16),
              SizedBox(width: 6),
              Text(
                'Estudiante: Heral MirashiroQuispe Quispe',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school_outlined, color: Color(0xFF818CF8), size: 16),
              SizedBox(width: 6),
              Text(
                'Asignatura: Desarrollo de Software',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.5)),
            ),
            child: const Text(
              'Semestre: 2026-2',
              style: TextStyle(
                color: Color(0xFFA5B4FC),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasoCicloData {
  final int numero;
  final String metodo;
  final String subtitulo;
  final bool isMounted;
  final String fase;
  final String descripcion;
  final String codigoCorrecto;
  final String codigoIncorrecto;
  final bool esBucleSetState;

  PasoCicloData({
    required this.numero,
    required this.metodo,
    required this.subtitulo,
    required this.isMounted,
    required this.fase,
    required this.descripcion,
    required this.codigoCorrecto,
    required this.codigoIncorrecto,
    this.esBucleSetState = false,
  });
}