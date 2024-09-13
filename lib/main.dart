import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Генератор Паролів Powereb by @Andriymk',
      theme: ThemeData.dark(

      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _passwordLength = 6;
  bool _includeUppercase = false;
  bool _includeLowercase = true;
  bool _includeNumbers = false;
  bool _includeSpecialCharacters = false;
  String _generatedPassword = '';

  void _generatePassword() {
    final length = _passwordLength;
    final uppercase = _includeUppercase ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '';
    final lowercase = _includeLowercase ? 'abcdefghijklmnopqrstuvwxyz' : '';
    final numbers = _includeNumbers ? '0123456789' : '';
    final specialCharacters = _includeSpecialCharacters ? '!@#\$%^&*()-_=+[]{}|;:,.<>?/~`' : '';

    final allCharacters = '$uppercase$lowercase$numbers$specialCharacters';
    if (allCharacters.isEmpty) return;

    final random = Random();
    final password = List.generate(length, (index) {
      return allCharacters[random.nextInt(allCharacters.length)];
    }).join();

    setState(() {
      _generatedPassword = password;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedPassword));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Пароль зкопійовано в буфер')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Згенеруй надійний пароль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Згенерований пароль:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: double.infinity,
              color: Colors.white10,
              child: SelectableText(
                _generatedPassword,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Кількість симфолів: $_passwordLength'),
              ],
            ),
            Slider(
              value: _passwordLength.toDouble(),
              min: 6,
              max: 20,
              divisions: 14,
              label: _passwordLength.toString(),
              activeColor: Colors.cyan,
              inactiveColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _passwordLength = value.toInt();
                });
              },
            ),
            CheckboxListTile(
              title: Text(
                  'Великі літери'),
              value: _includeUppercase,
              onChanged: (bool? value) {
                setState(() {
                  _includeUppercase = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Малі літери'),
              value: _includeLowercase,
              onChanged: (bool? value) {
                setState(() {
                  _includeLowercase = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Цифри'),
              value: _includeNumbers,
              onChanged: (bool? value) {
                setState(() {
                  _includeNumbers = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Спеціальні символи'),
              value: _includeSpecialCharacters,
              onChanged: (bool? value) {
                setState(() {
                  _includeSpecialCharacters = value ?? false;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _generatePassword,
                  child: Text(
                    'Згенерувати пароль',
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _copyToClipboard,
                  child: Text(
                      'Копіювати пароль',
                       style: TextStyle(color: Colors.cyan)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
