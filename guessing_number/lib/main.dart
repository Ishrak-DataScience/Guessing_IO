import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(GuessTheNumberGame());

class GuessTheNumberGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _randomNumber=0;
  int _remainingAttempts=5;
  String _message = '';
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    _randomNumber = Random().nextInt(100) + 1; // Generate a random number between 1 and 100
    _remainingAttempts = 5;
    _message = '';
    _textEditingController.clear();
  }

  void _checkGuess(int guess) {
    if (guess == _randomNumber) {
      _showDialog("Congratulations! You guessed the correct number.");
      _startNewGame();
    } else {
      setState(() {
        _remainingAttempts--;
        if (_remainingAttempts == 0) {
          _showDialog("Oops! You have run out of attempts. The number was $_randomNumber.");
          _startNewGame();
        } else {
          _message = guess > _randomNumber ? "Try a lower number." : "Try a higher number.";
        }
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Guess The Number'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess The Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guess the number between 1 and 100:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              _message,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your guess',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  int guess = int.parse(_textEditingController.text);
                  _checkGuess(guess);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
