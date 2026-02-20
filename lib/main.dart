import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            CounterText(counter: _counter),
            const SizedBox(height: 20),
            const Expanded(child: ListWidget()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Do nothing, just the ripple effect rebuild the providerscope
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key, required this.counter});

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Text('$counter', style: Theme.of(context).textTheme.headlineMedium);
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 100,
          color: Colors.blue,
          margin: EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ContainerWidget();
            },
          ),
        );
      },
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Container(
        width: double.infinity,
        height: 100,
        color: Colors.green,
      ),
    );
  }
}
