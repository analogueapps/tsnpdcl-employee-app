import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LMWiseAboveDaysAbstract extends StatefulWidget {

  final String noOfDays;

  const LMWiseAboveDaysAbstract({super.key, required  this.noOfDays});

  @override
  State<LMWiseAboveDaysAbstract> createState() => _LMWiseAboveDaysAbstractState();
}

class _LMWiseAboveDaysAbstractState extends State<LMWiseAboveDaysAbstract> {

  Map<String,int> abstractMap={
    "NA":1,
    "AE":1
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LM Wise above ${widget.noOfDays} days abstract'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh_sharp))
        ],
      ),
      body:ListView.builder(
        itemBuilder:(context,index){
          String key=abstractMap.keys.elementAt(index);
          int value=abstractMap.values.elementAt(index);
          return Container(
            decoration: BoxDecoration(
              color: index%2==0 ? Colors.grey.shade400 : Colors.white,
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
                  child: Text('${value}',style: TextStyle(color: index%2==0 ? Colors.black : Colors.blue.shade600,fontWeight: FontWeight.bold),),
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