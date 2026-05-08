import 'package:flutter/material.dart';

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
                const SizedBox(height: 40),
                // Hello word text (clickable)
                Text(
                  'hello word',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _isBlack ? Colors.white : Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                // Phone icon
                Icon(
                  Icons.phone_iphone,
                  size: 80,
                  color: _isBlack ? Colors.white : Colors.deepPurple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
