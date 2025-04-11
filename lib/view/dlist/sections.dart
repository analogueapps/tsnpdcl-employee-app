import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/dlist/choose_raange.dart';



class DList extends StatelessWidget {
  const DList({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> dList=["NAKKALAGUTTA","HYDERABAD"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Sections'),
        backgroundColor:Colors.blue,
        actions: [
          TextButton(onPressed: (){}, child: Text('APR25'))
        ],
      ),
      body: Padding(padding: EdgeInsets.all(11),
        child: ListView.builder(
          itemBuilder: (item,index){
            return InkWell(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${dList[index]}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey.shade500),),
                    Divider(color: Colors.grey.shade400,thickness: 1,),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseRange()));
              },
            );
          },
          itemCount: dList.length,
        ),
      ),
    );
  }
}