import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: [
              Icons.call,
              Icons.camera,
              Icons.message,
              Icons.photo,
              Icons.person,
            ],
            builder: (icon) {
              return Container(
                constraints: const BoxConstraints(minWidth: 48),
                height: 48,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      Colors.primaries[icon.hashCode % Colors.primaries.length],
                ),
                child: Center(child: Icon(icon, color: Colors.white)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Dock<T> extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
    required this.builder,
  });

  final List<T> items;
  final Widget Function(T) builder;

  @override
  State<Dock<T>> createState() => _DockState<T>();
}

class _DockState<T> extends State<Dock<T>> {
  late final List<T> _items = widget.items.toList();
  // ignore: unused_field
  int? _draggingIndex;

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_items.length, (index) {
          final item = _items[index];

          return LongPressDraggable<int>(
            data: index,
            onDragStarted: () => setState(() => _draggingIndex = index),
            onDragCompleted: () => setState(() => _draggingIndex = null),
            onDraggableCanceled: (_, __) =>
                setState(() => _draggingIndex = null),
            feedback: Material(
              color: Colors.transparent,
              child: widget.builder(item),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: widget.builder(item),
            ),
            child: DragTarget<int>(
              onWillAccept: (fromIndex) => fromIndex != index,
              onAccept: (fromIndex) => _onReorder(fromIndex, index),
              builder: (context, candidateData, rejectedData) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: candidateData.isNotEmpty
                      ? const EdgeInsets.symmetric(horizontal: 12)
                      : const EdgeInsets.symmetric(horizontal: 4),
                  child: widget.builder(item),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
