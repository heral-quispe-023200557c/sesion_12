import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: TestCicloVidaApp()));
}

class TestCicloVidaApp extends StatefulWidget {
  const TestCicloVidaApp({super.key});

  @override
  State<TestCicloVidaApp> createState() {
    // 1. createState()
    print('1. createState() | Frecuencia: Una vez | mounted: false');
    return _TestCicloVidaAppState();
  }
}

class _TestCicloVidaAppState extends State<TestCicloVidaApp> {
  int _contador = 0;

  @override
  void initState() {
    super.initState();
    // 2. initState()
    print('2. initState() | Frecuencia: Una vez | mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 3. didChangeDependencies()
    print('3. didChangeDependencies() | Frecuencia: 1+ veces | mounted: $mounted');
  }

  @override
  void didUpdateWidget(covariant TestCicloVidaApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 5. didUpdateWidget()
    print('5. didUpdateWidget() | Frecuencia: Condicional | mounted: $mounted');
  }

  @override
  Widget build(BuildContext context) {
    // 4. build()
    print('4. build() | Frecuencia: Repetible | mounted: $mounted');

    return Scaffold(
      appBar: AppBar(title: const Text('Prueba Ciclo de Vida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $_contador'),
            ElevatedButton(
              onPressed: () {
                print('\n---> Presionó setState()');
                setState(() => _contador++);
              },
              child: const Text('Ejecutar setState()'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print('6. deactivate() | Frecuencia: Condicional | mounted: $mounted');
    super.deactivate();
  }

  @override
  void dispose() {
    print('7. dispose() | Frecuencia: Una vez | mounted (previo): $mounted');
    super.dispose();
  }
}