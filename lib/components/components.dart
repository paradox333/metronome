import 'package:flutter/material.dart';

class CustomConatinerBPM extends StatelessWidget {
  const CustomConatinerBPM({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
                height: 80,
                width: 300,
                color: Colors.blue,
                child: Center(
                  child: Text(text, 
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 30),)),
              );
  }
}

class ContainerCustomGesture extends StatelessWidget {
  const ContainerCustomGesture({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      color: Colors.blue,
      child: Center(
        child: Text(text, 
        style: const TextStyle(fontSize: 30, color: Colors.white)
        )
      ),
    );
  }
}


class IconCustomIconButtom extends StatelessWidget {
  const IconCustomIconButtom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.settings, size: 40, color: Colors.blue,));
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      enableFeedback: false,
      child: const Text('Cancelar'),
      textColor: Colors.blue,
      onPressed:  () => Navigator.pop(context)
    );
  }
}

class GuiaVisual extends StatelessWidget {
  const GuiaVisual({
    Key? key,
    required this.offset,
  }) : super(key: key);

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
    offset: offset,
    duration: const Duration(milliseconds: 20),
    child: Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.blue
      )
    ),
    );
  }
}

class ContainerCircleButton extends StatelessWidget {
  const ContainerCircleButton({
    Key? key, required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue
        ),
      child: Center(
        child: Text(text, 
        style: const TextStyle(color: Colors.white, fontSize: 25),)
        ),
    );
  }
}

class CustomContainerTap extends StatelessWidget {
  const CustomContainerTap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue
        ),
      child: const Center(
        child: Text('Tap', 
        style: TextStyle(color: Colors.white, fontSize: 25))
        ),
    );
  }
}



