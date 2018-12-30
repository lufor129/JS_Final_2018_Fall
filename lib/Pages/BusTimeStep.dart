import 'package:flutter/material.dart';

class BusTimeStep extends StatefulWidget{

  @override
  _BusTimeStepState createState()=> new _BusTimeStepState();
}

class _BusTimeStepState extends State<BusTimeStep>{

  int _currentStep = 2;

  List<Step> _myStep(){
    List<Step> _step = [
      Step(
        title: Text("step1"),
        content: TextField(),
        isActive: _currentStep>=0
      ),
      Step(
        title: Text("step1"),
        content: TextField(),
        isActive: _currentStep>=0
      ),
      Step(
        title: Text("step1"),
        content: TextField(),
        isActive: _currentStep>=0
      ),
      Step(
        title: Text("step1"),
        content: TextField(),
        isActive: _currentStep>=0
      )
    ];
    return _step;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("dsadw"),
        backgroundColor: Colors.redAccent,
        
      ),
      body: new Container(
        child: new Stepper(
          steps: _myStep(),
          currentStep: _currentStep,
        )
      ),
    );
  }
}