import 'package:flutter/material.dart';
import 'package:restaurant/tile_state.dart';

class Tile extends StatelessWidget {
  final double tiledimension;
  final onPressed;
  final TileeState tilestate;
  Tile(
      {Key? key,
      required this.tiledimension,
      required this.tilestate,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: tiledimension,
        height: tiledimension,
        child: TextButton(onPressed: onPressed, child: _widgetfortilestate()));
  }

  Widget _widgetfortilestate() {
    Widget widget;
    switch (tilestate) {
      case TileeState.Empty:
        {
          widget = Container();
        }

        break;
      case TileeState.cross:
        {
          widget = Image.asset('images/cross.png');
        }

        break;
      case TileeState.circle:
        {
          widget = Image.asset('images/circle.png');
        }

        break;
    }
    return widget;
  }
}
