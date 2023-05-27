import 'package:chat/Screens/register_screen.dart';
import 'package:chat/widgets/custom_Input.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/label.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Logo(
                  title: 'Inicio de secion',
                ),
                _Form(),
                const Label(
                  screen: RegisterScreen(),
                  transitionType: PageTransitionType.bottomToTop,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCrtl = TextEditingController();
  final passwordCrtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          icon: Icons.email_outlined,
          placeholder: 'Correo electrónico',
          keyboardType: TextInputType.emailAddress,
          textController: emailCrtl,
        ),
        CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Contraseña',
          keyboardType: TextInputType.text,
          textController: passwordCrtl,
          isPassword: true,
        ),
        CustomButton(
          onPressed: () {
            print(emailCrtl.text);
            print(passwordCrtl.text);
          },
          text: 'Entrar',
        )
      ],
    );
  }
}
