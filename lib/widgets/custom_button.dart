import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.text = 'Aceptar',
  });

  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding:
              const EdgeInsets.all(0), // Elimina el padding interno del botón
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25), // Borde redondeado del botón
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 225, 255),
                Color.fromARGB(255, 1, 50, 227)
              ], // Colores del degradado
              begin: Alignment.centerLeft, // Punto de inicio del degradado
              end: Alignment.centerRight, // Punto de fin del degradado
            ),
            borderRadius: BorderRadius.circular(
                25), // Borde redondeado del fondo degradado
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white, // Color del texto
                fontSize: 20, // Tamaño del texto
                fontWeight: FontWeight.w400, // Grosor del texto
              ),
            ),
          ),
        ),
      ),
    );
  }
}
