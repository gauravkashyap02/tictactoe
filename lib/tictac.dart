import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  final String playerXName;
  final String playerOName;

  TicTacToe({required this.playerXName, required this.playerOName});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _initializeGame();
  }

  void _initializeGame() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _winner = '';
    _confettiController.stop();
  }

  void _handleTap(int row, int col) {
    if (_board[row][col] == '' && _winner == '') {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner()) {
          _winner = _currentPlayer;
          _confettiController.play();
        } else if (_board.every((row) => row.every((cell) => cell != ''))) {
          _winner = 'Draw';
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner() {
    // Check rows, columns, and diagonals
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] && _board[i][1] == _board[i][2] && _board[i][0] != '') return true;
      if (_board[0][i] == _board[1][i] && _board[1][i] == _board[2][i] && _board[0][i] != '') return true;
    }
    if (_board[0][0] == _board[1][1] && _board[1][1] == _board[2][2] && _board[0][0] != '') return true;
    if (_board[0][2] == _board[1][1] && _board[1][1] == _board[2][0] && _board[0][2] != '') return true;
    return false;
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_winner != '')
            Column(
              children: [
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                ),
                Text(
                  _winner == 'Draw' ? 'It\'s a Draw!' : '${_winner == 'X' ? widget.playerXName : widget.playerOName} Wins!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          SizedBox(height: 20),
          for (int i = 0; i < 3; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < 3; j++)
                  GestureDetector(
                    onTap: () => _handleTap(i, j),
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: _board[i][j] == 'X'
                            ? Colors.blue
                            : _board[i][j] == 'O'
                            ? Colors.red
                            : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          _board[i][j],
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text(
              'Restart Game',
              style: TextStyle(color: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }
}
