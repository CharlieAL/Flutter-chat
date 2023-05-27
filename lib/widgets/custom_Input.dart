import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromARGB(255, 217, 217, 217),
                      blurRadius: 10,
                      offset: Offset(0, 5))
                ]),
            child: TextField(
              autocorrect: false,
              keyboardType: keyboardType,
              controller: textController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: placeholder,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: Icon(
                    icon,
                    color: Colors.black38,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
