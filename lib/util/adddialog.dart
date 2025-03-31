import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController translationController = TextEditingController();
  final words=Hive.box('wortchatz');
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<dynamic> settings = Hive.box<dynamic>('settings');
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 226, 178, 106),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "NEW WORD",
              style: TextStyle(
                fontSize: screenwidth*0.06,
                fontWeight: FontWeight.bold,
              ),
              ),
          ),
          SizedBox(height: 20,),
          Container(
            width: screenwidth*0.7,
            padding:EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 174, 52),
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              controller: wordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Word',
                labelStyle: TextStyle(
                  color: Colors.black
                ),
                hintText: 'Enter the word',
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: screenwidth*0.7,
            padding:EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 174, 52),
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              controller: translationController,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Translation',
                labelStyle: TextStyle(
                  color: Colors.black
                ),
                hintText: 'Enter the translation',
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: Text('Cancel',style: TextStyle(color: const Color.fromARGB(255, 75, 75, 75)),),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 174, 52),
          ),
          onPressed: () {
            if( wordController.text!="" && translationController.text!=""){
              words.put(wordController.text, translationController.text);
            }
            print(words.keys);
            print(words.values);
            Navigator.of(context).pop(); 
          },
          child: Text('Submit',style: TextStyle(color: const Color.fromARGB(255, 0, 10, 36)),),
        ),
      ],
    );
  }
}