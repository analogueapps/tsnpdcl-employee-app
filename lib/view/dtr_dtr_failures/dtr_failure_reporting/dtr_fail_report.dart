import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportDTRFailure extends StatefulWidget {
  const ReportDTRFailure({super.key});

  @override
  State<ReportDTRFailure> createState() => _ReportDTRFailureState();
}

class _ReportDTRFailureState extends State<ReportDTRFailure> {
  @override
  Widget build(BuildContext context) {

    String? selectedLocation;
    String? failedEquipmentCode;
    String? selectedStructureCode;
    List<String> locationList=["NAKKALAGUTTA"];
    List<String> failedEquipmentList=["200049446"];
    List<String> failedStructureCodeList=['12234-NAKKALAGUTTA-NKG-SS-0071',
      '12235-NAKKALAGUTTA-NKG-SS-0072',
      '12236-NAKKALAGUTTA-NKG-SS-0073',
      '12237-NAKKALAGUTTA-NKG-SS-0074',
      '12238-NAKKALAGUTTA-NKG-SS-0075',
      '12239-NAKKALAGUTTA-NKG-SS-0076',
      '12240-NAKKALAGUTTA-NKG-SS-0077',
      '12241-NAKKALAGUTTA-NKG-SS-0078',
      '12242-NAKKALAGUTTA-NKG-SS-0079',
      '12243-NAKKALAGUTTA-NKG-SS-0080',];
    TextEditingController _dateController=TextEditingController();
    TextEditingController _timeController=TextEditingController();

    bool highRatingHG=false,highRaringLT=false,ventPipeBurst=false,gasketDamaged=false,earthWireCut=false,looseLinesInTheEarth=false;
    bool phaseTouching=false,phToucing=false,dueToLighting=false,heavyWind=false,dtrInstalled=false,improperHG=false,improperLT=false;
    bool tankCrack=false,MoistureEntry=false,flashover=false,improperEarthing=false,overload=false,hgFuse=false,faultDueToAGL=false;
    bool oilGushing=false,lowOilLevel=false,tankBurst=false,agingOfDTR=false,theftOfOil=false,floodsFallenOil=false,floodsSubmearged=false;
    bool other=false;

    bool estimateRequiredYes=false,estimateRequiredNo=false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Report DTR failure'),
        backgroundColor: CupertinoColors.systemGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(10.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('SELECT SECTION',style: TextStyle(),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField<String>(
                  value: selectedLocation,
                  items: locationList.map((minutes) {
                    return DropdownMenuItem(
                      value: minutes,
                      child: Text(locationList[0]),
                    );
                  }).toList(),
                  onChanged: (value){},
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                  hint: Text('NAKKALAGUTTA'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('NAKKALAGUTTA|402911201',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('SELECT FAILED STRUCTURE CODE',style: TextStyle(color: Colors.red,),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Select Failed Structure Code"),
                          content: SizedBox(
                            height: 300,
                            width: double.maxFinite,
                            child: ListView(
                              children: failedStructureCodeList.map((code) {
                                return ListTile(
                                  title: Text(code),
                                  onTap: () {
                                    selectedStructureCode = code;
                                    Navigator.of(context).pop();
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: selectedStructureCode ?? 'Select Failed Structure Code',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('12235-NAKKALAGUTTA-NKG-SS-0072',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('SELECT FAILED EQUIPMENT CODE',style: TextStyle(color: Colors.red,),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField<String>(
                  value: failedEquipmentCode,
                  items: locationList.map((code) {
                    return DropdownMenuItem(
                      value: failedEquipmentCode,
                      child: Text(failedEquipmentList[0]),
                    );
                  }).toList(),
                  onChanged: (value){},
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                  hint: Text('200049446'),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                  child: Center(child: Text('STRUCTURE DETAILS')),
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('STRUCTURE CODE'),
                    Text('12241-NAKKALAGUTTA-NKG-SS-0078',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LAND MARK'),
                    Text('Corporate office 2',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DISTRIBUTION'),
                    Text('12241-NAKKALAGUTTA-NKG-SS-0078',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SS NO'),
                    Text('SS-0078',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SUB STATION'),
                    Text('12241-NAKKALAGUTTA',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('FEEDER'),
                    Text('NAKKALAGUTTA-NKG-SS-0078',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('STRUCTURE CAPACITY'),
                    Text('1*135',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('STRUCTURE TYPE'),
                    Text('Double pole',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('PLINTH TYPE'),
                    Text('Pillar Type',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('AB SWITCH TYPE'),
                    Text('Horizontal',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('HG FUSE SETS'),
                    Text('Horizontal',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LT FUSE SETS'),
                    Text('Not Available',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LT FUSE TYPE'),
                    Text('Not Available',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LOAD PATTERN'),
                    Text('HT Service',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('STRUCTURE CODE'),
                    Text('18.005345',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LONGITUDE'),
                    Text('79.78788',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DATE OF CREATION'),
                    Text('2024-02-20 09:05:01.0',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EMPLOYEE ID'),
                    Text('40005450',style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 50,
                        child: Icon(Icons.image),
                      ),
                    ),
                    Column(
                      children: [
                        Text('EQ CODE:200049446',style: TextStyle(color: Colors.red),),
                        Text('CAP:315kVA'),
                        Text('MAKE:VIJAYA ELECTRONICS'),
                        Text('SERIAL:1794764'),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text('DTR FAILURE REASON',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity/2,
                  child: Row(
                    children: [
                      Expanded( // Helps the column inside the row to occupy space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Failure Date',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity/2,
                              child: TextField(
                                  onTap: () async  {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade400, // Light grey background
                                    border: InputBorder.none, // No border
                                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded( // Helps the column inside the row to occupy space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Failure Time',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity/2,
                              child: TextField(
                                  onTap: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      final now = DateTime.now();
                                      final formattedTime = TimeOfDay(
                                        hour: pickedTime.hour,
                                        minute: pickedTime.minute,
                                      ).format(context);
                                      _timeController.text = formattedTime;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade400, // Light grey background
                                    border: InputBorder.none, // No border
                                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: highRatingHG,
                          onChanged: (bool? newValue){
                          }
                      ),
                      SizedBox(width: 10,),
                      Text('High Rating HG Fuses Used'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('High Rating LT Fuses Used'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Vent Pipe Burst'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Gasket damaged at tank cover'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Earth wire cut'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Loose lines in the LT Line'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Phase Touching to Ground/Tree'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Ph Touching to body internally'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Due to lightning'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Heavy Wind and Gale'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('DTR installed long back'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Improper HG Fuse wire'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Improper LT Fuse wire'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Tank Crack OR Oil Leakage'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Moisture Entry'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Flashover of Bushing'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Improper Earthing'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Overload'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('HG Fuse Not Standing'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Fault due to AGL Motor'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Oil Gushing Out'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Low Oil Level'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Tank Burst'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Aging of DTR'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Theft of Oil'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Theft of Coils'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Floods-DTR Fallen-Oil shrt,Bushings dmgd'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Floods-DTR submerged in water'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value){value= !value!;}
                      ),
                      SizedBox(width: 10,),
                      Text('Other'),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('ESTIMATE REQUIRED?',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.st,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: estimateRequiredYes,
                            onChanged: (value){
                              setState(() {
                                estimateRequiredYes=value!;
                                estimateRequiredNo=!estimateRequiredYes;
                              });
                            }
                        ),
                        SizedBox(width: 5,),
                        Text('Yes')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: estimateRequiredNo,
                            onChanged: (value){
                              setState(() {
                                estimateRequiredNo=value!;
                                estimateRequiredYes=estimateRequiredNo;
                              });
                            }
                        ),
                        SizedBox(width: 5,),
                        Text('No')
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(thickness: 1,color: Colors.grey.shade300,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){},
                      child: Text('SAVE')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}