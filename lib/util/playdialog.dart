import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Playdialog extends StatefulWidget {
  const Playdialog({super.key});

  @override
  State<Playdialog> createState() => _PlaydialogState();
}

class _PlaydialogState extends State<Playdialog> {
  final TextEditingController input=TextEditingController();
  final words=Hive.box('wortchatz');
  bool showTranslation = false;
  List worts=[];
  int i=0;
  int correctanswers=0;
  void getwords(){
    List<String> allKeys = words.keys.cast<String>().toList();
    allKeys.shuffle(Random());
    worts = allKeys.take(20).toList();
  }
  @override
  void initState(){
    super.initState();
    getwords();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:  Color.fromARGB(255, 240, 178, 85),
      content: Container(
        height: 300,
        padding: EdgeInsets.only(top: 20),
        child: Center(
            child: Column(
              children: [
                Text(
                correctanswers.toString()+"/"+worts.length.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
                ),
              ),
                Text(
                  showTranslation
                      ? ' ${words.get(worts[i])}'
                      : ' ${worts[i]}',
                  style: TextStyle(
                    fontSize: 42,
                    color: const Color.fromARGB(255, 0, 10, 56),
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: input,
                    decoration: InputDecoration(
                      labelText: 'translation',
                      hintText: 'Enter the translation',
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: (){
                      String userTranslation = input.text.trim();
                      String correctTranslation = words.get(worts[i]) as String;
                      if (userTranslation == correctTranslation) {
                        if (i < worts.length - 1) {
                          setState(() {
                            i++;
                            input.clear();
                            showTranslation = false; 
                          });
                        } else {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context, 
                            builder: (context){
                              return AlertDialog(
                                backgroundColor: Color(0xFFFFD89C),
                                title: Center(
                                  child: Text(
                                    "you have got ${(worts.length-correctanswers).toString()} wrong words",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                ),
                                  content: IconButton.filled(
                                    onPressed: Navigator.of(context).pop, 
                                    icon: Icon(Icons.done),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 255, 180, 67),
                                      foregroundColor: Colors.white, 
                                    ),
                                    ),
                              );
                            }
                            
                            );
                        }
                        setState(() {
                          correctanswers++;
                        });
                      } else {
                        if(showTranslation==true){
                          if(i<worts.length-1){
                          setState(() {
                            i++;
                            input.clear();
                            showTranslation = false; 
                          });
                          }
                          else{
                            Navigator.of(context).pop();
                          showDialog(
                            context: context, 
                            builder: (context){
                              return AlertDialog(
                                backgroundColor: Color(0xFFFFD89C),
                                title: Center(
                                  child: Text(
                                    "you have got ${(worts.length-correctanswers).toString()} wrong words",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                ),
                                  content: IconButton.filled(
                                    onPressed: Navigator.of(context).pop, 
                                    icon: Icon(Icons.done),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 255, 180, 67),
                                      foregroundColor: Colors.white, 
                                    ),
                                    ),
                              );
                            }
                            
                            );
                          }
                        }
                        else{
                        setState(() {
                          showTranslation = true;
                        });
                        }
                      }
                    }, 
                    child: Text("submit"),
                    ),
              ],
            ),
          ),
      ),
    );
  }
}