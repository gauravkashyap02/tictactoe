import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tapgame/tictac.dart';

class PlayerNameScreen extends StatefulWidget {
  @override
  _PlayerNameScreenState createState() => _PlayerNameScreenState();
}

class _PlayerNameScreenState extends State<PlayerNameScreen> {
  late TextEditingController _playerXController;
  late TextEditingController _playerOController;

  @override
  void initState() {
    super.initState();
    _playerXController = TextEditingController();
    _playerOController = TextEditingController();
  }

  @override
  void dispose() {
    _playerXController.dispose();
    _playerOController.dispose();
    super.dispose();
  }

  void _startGame() {
    if (_playerXController.text.isNotEmpty && _playerOController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicTacToe(
            playerXName: _playerXController.text,
            playerOName: _playerOController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both player names')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text(
          'Enter Player Names',
          style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _playerXController,
              decoration: InputDecoration(
                labelText: 'Player X Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.person, color: Colors.blue),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _playerOController,
              decoration: InputDecoration(
                labelText: 'Player O Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.person, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: Text(
                'Start Game',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

