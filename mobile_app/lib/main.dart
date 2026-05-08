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
      backgroundColor: Colors.grey[300],
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isBlack = !_isBlack;
            });
          },
          child: Container(
            width: 280,
            height: 580,
            decoration: BoxDecoration(
              color: _isBlack ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: _isBlack ? Colors.white54 : Colors.black87,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 20,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Phone speaker
                Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _isBlack ? Colors.white54 : Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isBlack ? Colors.white : Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                // Message display
                Expanded(
                  child: _buildMessageDisplay(),
                ),
                // Next button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isBlack ? Colors.white : Colors.deepPurple,
                        foregroundColor: _isBlack ? Colors.black : Colors.white,
                      ),
                      child: const Text('next'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Phone icon
                Icon(
                  Icons.phone_iphone,
                  size: 40,
                  color: _isBlack ? Colors.white : Colors.deepPurple,
                ),
                const SizedBox(height: 20),
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
          color: _isBlack ? Colors.white : Colors.deepPurple,
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _error!,
            style: TextStyle(
              color: _isBlack ? Colors.red[300] : Colors.red,
              fontSize: 12,
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
            color: _isBlack ? Colors.white54 : Colors.black54,
            fontSize: 14,
          ),
        ),
      );
    }

    final message = _messages[_currentIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        message['content'] ?? '',
        style: TextStyle(
          color: _isBlack ? Colors.white : Colors.black87,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
