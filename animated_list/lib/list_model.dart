import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

typedef RemovedItemBuilder<E> = Widget Function(
  E item,
  BuildContext context,
  Animation<double> animation,
);

@immutable
class ListModel<E> {
  ListModel(
      {@required this.listKey,
      @required this.removedItemBuilder,
      Iterable<E> initialItems})
      : _items = List<E>.from(initialItems ?? <E>[]);
  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;
  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (context, animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }
}
