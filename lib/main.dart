import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'River pod example',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

const names = [
  'kelvin',
  'kenneth',
  'Alice',
  'prisca',
  'alex',
  'emma',
  'jeniffer',
  'lorrine',
  'sunday',
  'henry',
  'kunle',
  'Ada',
  'pascal',
];
final tickerProvider = StreamProvider<int>(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);
final nameProvider = StreamProvider<Iterable<String>>((ref) =>
    ref.watch(tickerProvider.stream).map((count) => names.getRange(0, count)));

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Riverpod streamProvider'),
      ),
      body: names.when(
        data: (name) => ListView.builder(
          itemCount: name.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              name.elementAt(index),
            ),
          ),
        ),
        error: (error, stackTrace) => const Text(
          'reached the end of the list',
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
