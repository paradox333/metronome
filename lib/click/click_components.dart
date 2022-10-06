import 'package:flutter/material.dart';


import 'dart:math';

import 'dart:async';
import 'package:flutter/services.dart';
 
  clickFunction(int velocidad, bool estado, Timer? timer, Offset offset, Function _slideLeft, Function _slideRight){

    if(estado){
    double tempo = velocidad/60;
    int bpm = 1000~/tempo;
    timer = Timer.periodic(Duration(milliseconds: bpm), (timer) {
      SystemSound.play(SystemSoundType.click);
      // _slideLeft();
      if(offset.dx > 0){
        _slideLeft;
      }else{
        _slideRight;
      }
      //  _slideRigth();
      //  _slideLeft();
      
      });
    timer;
   }
  }
 
  stop(Timer? timer){
    timer?.cancel();
  }

  GestureDetector customGesture10(String text, String containerBPM, bool estado, String play, Function clickFunction, Function stop, void setState) {
    return GestureDetector(
            child: Container(
              height: 80,
              width: 80,
              color: Colors.blue,
              child: Center(
                child: Text(text, 
                style: const TextStyle(fontSize: 30, color: Colors.white)
                )
              ),
            ),
            
            onTap: (){
              if(containerBPM != '0'){
              if(!estado && play == 'Play'){
                estado = true;
                play = 'Stop';
                containerBPM = (int.parse(containerBPM)+10).toString();
                clickFunction((int.parse(containerBPM)+10), estado);
              } else if(estado && play == 'Stop'){
                estado = false;
                play = 'Play';
                stop();
              }
              setState;
              
              }
            }
            );
  }

  definirBPM( String containerBPM, bool estado, String play, Function clickFunction, TextEditingController textController, void setState){
    containerBPM = textController.text;
    if(!estado && play == 'Play'){
      estado = true;
      play = 'Stop';
      containerBPM = textController.text;
      clickFunction(int.parse(containerBPM), estado);
    }
    setState;
  }

  tap(bool estado, List<int> _tiempoTap, String containerBPM, Timer? timer, Offset offset, Function _slideLeft, Function _slideRigth){
    if(!estado){
    
      int tap = DateTime.now().millisecondsSinceEpoch;
      _tiempoTap.add(tap);
      if(_tiempoTap.length > 3){
        _tiempoTap.remove(0);
      }

      int cuenta = 0;
      int intervalo = 0;

      for(int i = _tiempoTap.length -1; i >= 1; i--){
        int tapActual = _tiempoTap[i];
        int tapPrevio = _tiempoTap[i-1];
        int intervaloActual = tapActual - tapPrevio;
        
        if(intervaloActual > 3000) break;

        intervalo += (intervaloActual ~/ 60);
        cuenta++;
      }

      if(cuenta > 0){

        int millisegundos = intervalo ~/ cuenta; // media entre los tiempos de tap
        int bpm = 1000~/millisegundos;
        int tempo = min(max((bpm).toInt(), 1), 300);
        clickFunction2(tempo, containerBPM, timer, offset, _slideLeft, _slideRigth);
      }
    }
  }

  clickFunction2(int bpm, String containerBPM, Timer? timer, Offset offset, Function _slideLeft, Function _slideRigth){
    containerBPM = bpm.toString();
    double tempo = bpm / 60;
    int velocidad = 1000 ~/ tempo;
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: velocidad), (timer) {
      SystemSound.play(SystemSoundType.click);
      // _slideLeft();
      if(offset.dx > 0){
        _slideLeft();
      }else{
        _slideRigth();
      }
      //  _slideRigth();
      //  _slideLeft();
      
      });
    timer;
   
  }
