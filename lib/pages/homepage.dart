import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wortcat/util/adddialog.dart';
import 'package:wortcat/util/playdialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final words=Hive.box('wortchatz');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD89C),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color:  Color.fromARGB(255, 255, 180, 67),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'WORTCAT',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Color.fromARGB(255, 0, 24, 70)
                  ),
                  ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AddDialog();
                      },
                    );
                },
                child: Text('ADD',style: TextStyle(color: Color.fromARGB(255, 0, 23, 44),fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 55),
                  backgroundColor:Color(0xFFFFD89C)
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('home');
                },
                child: Text('LIST',style: TextStyle(color: Color.fromARGB(255, 0, 23, 44),fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xFFFFD89C),
                  minimumSize: Size(100, 55),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if(Hive.box("wortchatz").isNotEmpty){
                    Navigator.of(context).pushNamed('add');
                  }
                },
                child: Text('PLAY',style: TextStyle(color: Color.fromARGB(255, 0, 23, 44),fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 55),
                  backgroundColor: Color(0xFFFFD89C)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
