import 'package:flutter/material.dart';

import 'card_item.dart';
import 'list_model.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem;
  int get _selectedIdex => _list.indexOf(_selectedItem);

  @override
  void initState() {
    super.initState();
    final initialItems = [0, 1, 2];
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: initialItems,
      removedItemBuilder: (item, context, animation) {
        return CardItem(
          animation: animation,
          item: item,
          selected: false,
        );
      },
    );
    _nextItem = initialItems.length;
  }

  void _insert() {
    final index = _selectedItem == null ? _list.length : _selectedIdex;
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_selectedItem == null) {
      _scaffoldKey.currentState.showSnackBar(
          const SnackBar(content: Text('Select item to remove.')));
      return;
    }

    _list.removeAt(_selectedIdex);
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('AnimatedList'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: (context, index, animation) {
              final item = _list[index];
              return CardItem(
                animation: animation,
                item: _list[index],
                selected: _selectedItem == item,
                onTap: () {
                  setState(() {
                    _selectedItem = _selectedItem == item ? null : item;
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
