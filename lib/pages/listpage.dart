import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wortcat/util/adddialog.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  Map<String, bool> _showTranslation = <String, bool>{};
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final Box<dynamic> wortchatz = Hive.box<dynamic>('wortchatz'); 

    List<String> filteredKeys = wortchatz.keys
        .cast<String>()
        .where((key) => key.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Color(0xFFFFD89C),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 178, 85),
        title: Center(child: Text('WORS LIST')),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 240, 178, 85),
                    title: Text('Total words: ${wortchatz.length}'),
                  );
                }
              );
            },
            icon: Icon(Icons.info)
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter a word',
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), 
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), 
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: wortchatz.listenable(),
              builder: (context, Box<dynamic> box, widget) {
                return ListView.builder(
                  itemCount: filteredKeys.length,
                  itemBuilder: (context, index) {
                    String key = filteredKeys[index];
                    String value = box.get(key) as String;
                    bool showTranslation = _showTranslation[key] ?? false;

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 178, 85), 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              showTranslation ? value : key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 14, 75),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.translate, color: Colors.white), 
                            onPressed: () {
                              setState(() {
                                _showTranslation[key] = !showTranslation;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red), 
                            onPressed: () {
                              box.delete(key);
                              setState(() {
                                _showTranslation.remove(key);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}