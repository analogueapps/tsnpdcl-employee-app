import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LMWiseAbstract extends StatelessWidget {
  const LMWiseAbstract({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> abstractMap = {
      "UNDER FEASIBILITY CHECK BY O&M STAFF": 3,
      "CH.RAMREDDY,LM": 3
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Linemen wise Abstract'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_sharp))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String key = abstractMap.keys.elementAt(index);
          int value = abstractMap.values.elementAt(index);
          return Container(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.grey.shade400 : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(key),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '$value',
                    style: TextStyle(
                        color: index % 2 == 0
                            ? Colors.black
                            : Colors.blue.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: abstractMap.length,
      ),
    );
  }
}
