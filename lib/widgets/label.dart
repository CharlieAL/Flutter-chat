import 'package:chat/Screens/login_screen.dart';
import 'package:chat/Screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Label extends StatelessWidget {
  final Widget screen;
  final PageTransitionType transitionType;
  final String textButton;
  final bool isLogin;
  const Label(
      {super.key,
      required this.screen,
      required this.transitionType,
      this.textButton = 'Crear cuenta nueva',
      this.isLogin = true});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(8), // Borde redondeado del contenedor
            color: Colors.white, // Color de fondo blanco del contenedor
          ),
          child: OutlinedButton(
            onPressed: () {
              // Acción cuando se presiona el botón
              if (isLogin) {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 400),
                      reverseDuration: const Duration(milliseconds: 400),
                      type: PageTransitionType.bottomToTop,
                      child: const RegisterScreen(),
                      childCurrent: const LoginScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 400),
                      reverseDuration: Duration(milliseconds: 400),
                      type: PageTransitionType.topToBottomPop,
                      child: const LoginScreen(),
                      childCurrent: const RegisterScreen()),
                );
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              side: const BorderSide(
                  color: Color.fromARGB(
                      255, 0, 0, 0)), // Color del borde azul del botón
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(25), // Borde redondeado del botón
              ),
            ),
            child: Text(
              textButton,
              style: const TextStyle(
                  color: Color.fromARGB(
                      255, 0, 0, 0), // Color del texto azul del botón
                  fontSize: 18,
                  fontWeight: FontWeight.w400 // Tamaño del texto del botón
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'Al continuar aceptas nuestros términos y condiciones de uso',
            style:
                TextStyle(color: Color.fromARGB(255, 80, 80, 80), fontSize: 15),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
