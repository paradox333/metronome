import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:iacc_metronomo/components/components.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
class ScreenPage1 extends StatefulWidget {
  const ScreenPage1({Key? key}) : super(key: key);

  @override
  State<ScreenPage1> createState() => ScreenPage1State();
}

class ScreenPage1State extends State<ScreenPage1> {
  
  //TODO Elementos de audio
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache cache = AudioCache(prefix: 'metronome-click.wav');

  
  var permiso = Permission.microphone.request();
  Timer? timer;
    
  Offset offset = Offset.zero;

  void moverIzquierda() {
    setState(() => offset -= const Offset(5, 0));
  }

  void moverDerecha() {setState(() => offset += const Offset(5, 0));}

  final List<int> _tiempoTap = [];

  String play = 'Play';
  bool estado = false;

  void setEstado(bool value){
    estado = value;
  }

  String containerBPM = '0';
  final textController = TextEditingController();
  bool tapEstado = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Institución'),
          elevation: 0,
          actions: const [
            Icon(Icons.account_balance_sharp, size: 50,)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                const SizedBox(width: 100),
                GuiaVisual(offset: offset),
                const SizedBox(width: 80),
              ],),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomConatinerBPM(text:containerBPM,)
              ],),
              const SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                customGesture('60'),  
                const SizedBox(width: 20,),
                customGesture('90'),             
                const SizedBox(width: 20,),
                customGesture('120'),
                const SizedBox(width: 20,),
                customGesture10('+10'),
              ],),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                customIconButton(context)
        
              ],),
              const SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                customCircleButton(play),
        
                const SizedBox(width: 90),
        
                customGestureTap(),
                
              ],)
            ],
          ),
        )
          ),
        
      );
  }

customGestureTap() {
  return GestureDetector(
              child: const CustomContainerTap(),
              onTap: (){

                  
                  
                  play = 'Stop';
                  tap(estado);
                  
                  if(estado && play == 'Stop'){//TODO
                    estado = false;
                    play = 'Play';
                    detener();
                  }
                  
                  setState(() {});
            
                  }
                
            );
}

customGesture(String text) {
  return GestureDetector(
          child: ContainerCustomGesture(text: text),
          
          onTap: (){
                   
            if(!estado && play == 'Play'){
              estado = true;
              play = 'Stop';
              containerBPM = text;
              click(int.parse(text), estado,);
            } else if(estado && play == 'Stop'){
              estado = false;
              play = 'Play';
              detener();
            }
            setState(() {});
                
            
            },
          );
}

customGesture10(String text) {
  return GestureDetector(
          child: ContainerCustomGesture(text: text),
          
          onTap: (){
            if(containerBPM != '0'){
            if(!estado && play == 'Play'){
              estado = true;
              play = 'Stop';
              containerBPM = (int.parse(containerBPM)+10).toString();
              click((int.parse(containerBPM)+10), estado);
            } else if(estado && play == 'Stop'){
              estado = false;
              play = 'Play';
              detener();
            }
            // setState(() {});
            
            }
          }
          );
}


customIconButton(BuildContext context) {
  return IconButton(
              enableFeedback: false,
              icon: const IconCustomIconButtom(),
              onPressed: (){
                customDialog(context);
              }, 
              );
}
 

customCircleButton(String text) {
  return GestureDetector(
              child: ContainerCircleButton(text: text,),
              onTap: (){         
                if(estado && play == 'Stop' || !estado && tapEstado){
                  estado = false;
                  play = 'Play';
                  detener();
                }
                
                setState(() {});
              },
            );
}


customDialog(BuildContext context){
  
  showDialog(
  context: context, 
  builder: (context) {
    return AlertDialog(
      title: const Text('Ingrese la velocidad en BPM'),
      content: TextField(
        controller: textController,
      ),
      actions: [
        const CancelButton(),
        const SizedBox(width: 80,),
        MaterialButton(
          enableFeedback: false,
          child: const Text('Aceptar'),
          textColor: Colors.blue,
          onPressed:  (){
            click(int.parse(textController.text), estado);
            definirBPM();
            
            setState(() {
              
            });
            Navigator.pop(context);
            // SystemSoundType.click;
          }
        ),
        
      ],
    );
  }
  );
}

// TODO Funciones

  click(int velocidad, bool estado) {
   
    int counter = 0;
    if(estado){
    double tempo = velocidad/60;
    int bpm = 1000~/tempo;
    timer = Timer.periodic(Duration(milliseconds: bpm), (timer) {
      print(counter);
      counter++;
      SystemSound.play(SystemSoundType.click);
      if(offset.dx > 0){
        moverIzquierda();
      }else{
        moverDerecha();
      }
      
      });
    timer;
   }
  }
 
  detener(){
    timer?.cancel();
    print('función detener implementada');
  }

  definirBPM(){
    containerBPM = textController.text;
    if(!estado && play == 'Play'){
      estado = true;
      play = 'Stop';
      containerBPM = textController.text;
      click(int.parse(containerBPM), estado);
    }
    
  }

  tap(bool estado){
    
    if( !estado ){
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
        print(tempo);
        click2(tempo);
      }
    }
    tapEstado = true;
  }

  click2(int bpm){

    int counter = 0;
    print(bpm);
    containerBPM = bpm.toString();
    double tempo = bpm / 60;
    int velocidad = 1000 ~/ tempo;
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: velocidad), (timer) {
      SystemSound.play(SystemSoundType.click);
     
      if(offset.dx > 0){
        moverIzquierda();
      }else{
        moverDerecha();
      }
      });
    timer;
   
  }

  audioPlay(){
    

  }

 
 
}











