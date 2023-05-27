import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 80, 80, 80), fontSize: 23),
          )
        ],
      ),
    );
  }
}
