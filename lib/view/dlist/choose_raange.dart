import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseRange extends StatelessWidget {
  const ChooseRange({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> rangeList=["50-5000RS","5001-20000RS","20001-50000RS","50001RS & ABOVE"];
    List<String> valueList=["(4439)","(729)","(135)","(61)"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Range'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4
        ),
        itemBuilder:(item,index){
          return InkWell(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade300
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${rangeList[index]}'),
                  Text('${valueList[index]}')
                ],
              ),
            ),
            onTap: (){
              ///Google maps
            },
          );
        },
        itemCount: rangeList.length,
      ),
    );
  }
}