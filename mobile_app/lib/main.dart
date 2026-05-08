import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MobilePhoneFrame(),
    );
  }
}

class MobilePhoneFrame extends StatefulWidget {
  const MobilePhoneFrame({super.key});

  @override
  State<MobilePhoneFrame> createState() => _MobilePhoneFrameState();
}

class _MobilePhoneFrameState extends State<MobilePhoneFrame> {
  bool _isBlack = false;
  List<dynamic> _messages = [];
  int _currentIndex = 0;
  bool _loading = true;
  String? _error;

  // Configurable API URL
  static const String _apiUrl = 'https://YOUR_PROJECT.supabase.co/functions/v1/messages';
  static const String _apiKey = 'YOUR_ANON_KEY';

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'apikey': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _messages = data['messages'] ?? [];
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Connection failed';
        _loading = false;
      });
    }
  }

  void _nextMessage() {
    if (_messages.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _messages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: _buildPhone(),
      ),
    );
  }

  Widget _buildPhone() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isBlack = !_isBlack;
        });
      },
      child: Container(
        width: 300,
        height: 620,
        decoration: BoxDecoration(
          color: _isBlack ? Colors.grey[900] : Colors.grey[800],
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            color: Colors.grey[700]!,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 25,
              offset: const Offset(15, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: _isBlack ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Top bar with speaker and camera
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Camera
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Speaker
                      Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
                // Screen title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isBlack ? Colors.greenAccent : Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Message display (screen area)
                Expanded(
                  child: _buildMessageDisplay(),
                ),
                // Next button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _nextMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isBlack ? Colors.greenAccent : Colors.deepPurple,
                        foregroundColor: _isBlack ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'next',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // Home indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageDisplay() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(
          color: _isBlack ? Colors.greenAccent : Colors.deepPurple,
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            _error!,
            style: TextStyle(
              color: _isBlack ? Colors.red[300] : Colors.red,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_messages.isEmpty) {
      return Center(
        child: Text(
          'No messages',
          style: TextStyle(
            color: _isBlack ? Colors.grey[500] : Colors.grey[500],
            fontSize: 16,
          ),
        ),
      );
    }

    final message = _messages[_currentIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        message['content'] ?? '',
        style: TextStyle(
          color: _isBlack ? Colors.white : Colors.black87,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
