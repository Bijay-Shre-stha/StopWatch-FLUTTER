import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {


  //function
  int milliseconds=0 ,seconds=0, minutes=0, hours=0;
  String digitalMillisecond="00", digitalSeconds="00",digitalMinutes="00",digitalHours="00";
  Timer?timer;
  bool started=false;
  List laps=[];



  //stop function
  void stop(){
    timer!.cancel();
    setState(() {
      started=false;

    });
  }




  //reset function
  void reset(){
    timer!.cancel();
    setState(() {
      milliseconds=0;
      seconds=0;
      minutes=0;
      hours=0;

      digitalMillisecond="00";
      digitalSeconds="00";
      digitalMinutes="00";
      digitalHours="00";
      started=false;
    });
  }


  //laps function
  void addLaps(){
    String lap="$digitalHours:$digitalMinutes:$digitalSeconds:$digitalMillisecond";
    setState(() {
      laps.add(lap);
    });
  }



  //start function
  void start(){
    started= true;
    timer=Timer.periodic(Duration(milliseconds: 1), (timer) {
      int localMilliseconds = milliseconds+1;
      int localSeconds = seconds;
      int localMinutes= minutes;
      int localHours= hours;
      if(localMilliseconds>99){
        localSeconds++;
        localMilliseconds=0;
      }
      if(localSeconds>59){
        if(localMinutes>59){
          localHours++;
          localMinutes=0;
        }
        else{
          localMinutes++;
          localSeconds=0;
        }
      }

      setState(() {
        milliseconds=localMilliseconds;
        seconds=localSeconds;
        minutes=localMinutes;
        hours=localHours;
        digitalMillisecond=(milliseconds>=10?"$milliseconds":"0$milliseconds");
        digitalSeconds=(seconds>=10)?"$seconds":"0$seconds";
        digitalMinutes=(minutes>=10)?"$minutes":"0$minutes";
        digitalHours=(hours>=10)?"$hours":"0$hours";
      });
    },);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child:
          Padding(padding:  const EdgeInsets.all(8),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //title
            Center(
              child: Text('StopWatch ', style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),)
            ),
            SizedBox(height: 25.0,),
            //000
            Center(
              child:Text("$digitalHours:$digitalMinutes:$digitalSeconds:$digitalMillisecond",style: TextStyle(color: Colors.white, fontSize: 85,fontWeight: FontWeight.w600),),
            ),
            //center part
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Color(0xFF323F68),
                borderRadius: BorderRadius.circular(10),
              ),
              //list builder
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index){
                  return Padding(padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Lap ${index+1}", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      ),
                      Text(
                        "${laps[index]}", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      ),
                    ],
                  )
                  );

                } ,
                
                  ),
            ),
            SizedBox(
              height: 25,
            ),
            //down button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: RawMaterialButton(onPressed:(){
                  (!started)?start():stop();
                },
                shape: StadiumBorder(side:BorderSide(color: Colors.blue),
                ),
                child:Text((!started)?"Start" : "Pause", style: TextStyle(color: Colors.white),) ,
                ),
                ),
                SizedBox(width: 8,),
                IconButton(color: Colors.white,
                onPressed: (){
                  addLaps();
                }, icon:Icon(Icons.flag),
                ),
                SizedBox(width: 8,),

                Expanded(child: RawMaterialButton(onPressed:(){
                  reset();
                },
                fillColor: Colors.blue,
                shape: StadiumBorder ( ),
                child:Text("Restart", style: TextStyle(color: Colors.white),) ,
                ),
                ),

              ],
            ),

          ],
          ),
          )
          ),
    );
  }
}

