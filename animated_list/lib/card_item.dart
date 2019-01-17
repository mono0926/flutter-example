import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.animation,
    @required this.onTap,
    @required this.item,
    this.selected = false,
  })  : assert(item >= 0),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle() {
      final textStyle = Theme.of(context).textTheme.display1;
      if (selected) {
        return textStyle.copyWith(color: Colors.lightGreenAccent[400]);
      } else {
        return textStyle;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque, // TODO: what?
          onTap: onTap,
          child: SizedBox(
            height: 128,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Item $item',
                  style: textStyle(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
