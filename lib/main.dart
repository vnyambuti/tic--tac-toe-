import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/board_tile.dart';
import 'package:restaurant/tile_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final _images = [
    'color-1F7-silver_metallic.jpg',
    'color-1G3-grey_metallic.jpg',
    'color-3R3-red_mica_metallic.jpg',
    'color-4T3-bronze_mica_metallic.jpg',
    'color-202-black.jpg'
  ];
  final navigatorKey = GlobalKey<NavigatorState>();
  var _boardstate = List.filled(9, TileeState.Empty);
  var _currentTurn = TileeState.cross;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Tic Tac Toe'),
          ),
          body: Center(
            child: Stack(
              children: [_boardTiles(), Image.asset("images/board.png")],
            ),
          )),
    );
  }

  Widget _boardTiles() {
    return Builder(builder: (context) {
      final dimensions = MediaQuery.of(context).size.width;
      final tiledimension = dimensions / 3;
      return Container(
        width: dimensions,
        height: dimensions,
        child: Column(
          children: chunk(_boardstate, 3).asMap().entries.map((entry) {
            final chunkindex = entry.key;
            final tilestatechunk = entry.value;
            return Row(
              children: tilestatechunk.asMap().entries.map((innerEntry) {
                final innerIndex = innerEntry.key;
                final TileeState = innerEntry.value;
                final tileindex = (chunkindex * 3) + innerIndex;
                return Tile(
                  tilestate: TileeState,
                  tiledimension: tiledimension,
                  onPressed: () {
                    print('tapped');
                    _updatetilestateforindex(tileindex);
                  },
                );
              }).toList(),
            );
          }).toList(),
        ),
      );
    });
  }

  _updatetilestateforindex(int selectedindex) {
    if (_boardstate[selectedindex] == TileeState.Empty) {
      setState(() {
        _boardstate[selectedindex] = _currentTurn;
        _currentTurn = _currentTurn == TileeState.cross
            ? TileeState.circle
            : TileeState.cross;
      });
      final winner = _findwinner();
      if (winner != null) {
        print('winner is $winner');
        _showWinnwerDialog(winner);
      }
    }
  }

  TileeState _findwinner() {
    Function(int, int, int) winnerForMatch = (a, b, c) {
      if (_boardstate[a] != TileeState.Empty) {
        if ((_boardstate[a] == _boardstate[b]) &&
            (_boardstate[b] == _boardstate[c])) {
          return _boardstate[a];
        }
      }
      return null;
    };
    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
    ];

    var winner;
    for (var i = 0; i < checks.length; i++) {
      if (checks[i] != null) {
        winner = checks[i];
        break;
      }
    }
    return winner;
  }

  _showWinnwerDialog(TileeState tilestate) {
    final newcontext = navigatorKey.currentState!.overlay!.context;
    showDialog(
        context: newcontext,
        builder: (res) {
          return AlertDialog(
            title: Text('  Winner'),
            content: Image.asset(tilestate == TileeState.cross
                ? 'images/x.png'
                : 'images/o.png'),
            actions: [
              TextButton(
                  onPressed: () {
                    _resetGame();
                    Navigator.of(newcontext).pop();
                  },
                  child: Text('New Game'))
            ],
          );
        });
  }

  _resetGame() {
    setState(() {
      _boardstate = List.filled(9, TileeState.Empty);
      _currentTurn = TileeState.cross;
    });
  }
}
