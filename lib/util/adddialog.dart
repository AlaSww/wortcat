import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController translationController = TextEditingController();
  final words=Hive.box('wortchatz');
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 226, 178, 106),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: wordController,
            decoration: InputDecoration(
              labelText: 'Word',
              hintText: 'Enter the word',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: translationController,
            decoration: InputDecoration(
              labelText: 'Translation',
              hintText: 'Enter the translation',
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