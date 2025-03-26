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
    final screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFFD89C),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 255, 180, 67),),
      body: Expanded(
        child: Container(
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
                      color:!showTranslation ? const Color.fromARGB(255, 0, 10, 56):Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 180, 67),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      width: screenwidth*0.8,
                      child: TextField(
                        controller: input,
                        decoration: InputDecoration(
                          labelText: '   translation',
                          hintText: '    Enter the translation',
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 180, 67)
                      ),
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
                      child: Text("submit",style: TextStyle(fontSize: 20),),
                      ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
