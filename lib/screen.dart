import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({Key? key}) : super(key: key);

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  
  Timer? timer;
  
  Offset offset = Offset.zero;

  void _slideLeft() {
    setState(() => offset -= const Offset(5, 0));
  }

  void _slideRight() {
    setState(() => offset += const Offset(5, 0));
  }

  final List<int> _tiempoTap = [];

  String play = 'Play';
  bool estado = false;
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
          title: const Text('UAHC'),
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
                guiaVisual(),
                const SizedBox(width: 80),
              ],),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                customConatinerBPM(containerBPM)
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
                ingresarBPM(context)
        
              ],),
              const SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                customCircleButton(play),
        
                const SizedBox(width: 90),
        
                GestureDetector(
                  child: Container(
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
                  ),
                  onTap: (){
                      play = 'Stop';
                      tap(estado);
                      
      
                      if(estado && play == 'Stop'){//TODO
                        estado = false;
                        play = 'Play';
                        detener();
                      }
                      
                      setState(() {
                        

                      });
                      
                      }
                    
                ),
                
              ],)
            ],
          ),
        )
          ),
        
      );
  }

  IconButton ingresarBPM(BuildContext context) {
    return IconButton(
                enableFeedback: false,
                icon: const Center(child: Icon(Icons.settings, size: 40, color: Colors.blue,)),
                onPressed: (){
                 customDialog(context);
                }, 
                );
  }

  AnimatedSlide guiaVisual() {
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

  Container customConatinerBPM(String text) {
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

  GestureDetector customCircleButton(String text) {
    return GestureDetector(
                child: Container(
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
                ),
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

  GestureDetector customGesture(String text) {
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
          MaterialButton(
            enableFeedback: false,
            child: const Text('Cancelar'),
            textColor: Colors.blue,
            onPressed:  () => Navigator.pop(context)
          ),
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

  click(int velocidad, bool estado){

    if(estado){
    double tempo = velocidad/60;
    int bpm = 1000~/tempo;
    timer = Timer.periodic(Duration(milliseconds: bpm), (timer) {
      SystemSound.play(SystemSoundType.click);
      // _slideLeft();
      if(offset.dx > 0){
        _slideLeft();
      }else{
        _slideRight();
      }
      //  _slideRigth();
      //  _slideLeft();
      
      });
    timer;
   }
  }
 
  detener(){
    timer?.cancel();
  }

  GestureDetector customGesture10(String text) {
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
        _slideRight();
      }
      //  _slideRigth();
      //  _slideLeft();
      
      });
    timer;
   
  }

  

}

