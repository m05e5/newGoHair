import 'package:flutter/cupertino.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/pages/auth/prendreRDV.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart'; 
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

void main() => runApp(StepperApp());

class StepperApp extends StatelessWidget {
  
 
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'CupertinoStepper for Flutter',
      debugShowCheckedModeBanner: false,
      home: StepperPage(),
    );
  }
}

class StepperPage extends StatefulWidget {
  
  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  final format = DateFormat("yyyy-MM-dd");
  int currentStep = 0;
   final _formKey = GlobalKey<FormState>();
  String clientName;
  String clientPhone;
  String userId;
  String shopId;
  String barberId;
  String hairStyleId;
  String date;
  String detail;
  
  

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Reservation'),
      ),
      child: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            switch (orientation) {
              case Orientation.portrait:
                return _buildStepper(StepperType.horizontal);
              case Orientation.landscape:
                return _buildStepper(StepperType.vertical );
              default:
                throw UnimplementedError(orientation.toString());
            }
          },
        ),
      ),
    );
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 3;
    var i = 0;
        return CupertinoStepper(
          type: type,
          currentStep: currentStep,
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
          onStepContinue: canContinue ? () => setState(() => ++currentStep) : null,
          steps: [
         
              _buildStep(
                title: Text('Step ${i + 1}'),
                // isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep ? StepState.complete : StepState.indexed,
                content:  LimitedBox(
        maxWidth: 300,
        maxHeight: 300,
        child: Material(
          color: Colors.white,
          child: ListView(children: <Widget>[
            TextFormField(
               keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Nom",
          border: OutlineInputBorder(),
        ),
        onChanged: (String value) {
          setState(() {
             clientName = value;
          });
         },
            ),
SizedBox(height: 15.0),

             TextFormField(

            // controller: _emailController,
            // validator: _validateEmail,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Contact",
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              clientPhone = value;
            },
          ),

SizedBox(height: 15.0),

          Column(children: <Widget>[
          Text('Basic date field (${format.pattern})'),
            DateTimeField(
             decoration: InputDecoration(
           labelText: "Date du rendezvous",
           border: OutlineInputBorder(),
            ),
           format: format,
           onShowPicker: (context, currentValue) {
             return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]),


          ],),
          ),
      ),
          ),
        _buildStep(
          title: Text('Error'),
          // isActive: i == currentStep + 1 ,
            state: i == currentStep
                ? StepState.indexed
                : i < currentStep ? StepState.editing : StepState.complete,
          content:  LimitedBox(
        maxWidth: 300,
        maxHeight: 300,
        child: Container(
          color: CupertinoColors.systemGrey,
          child:Container(
            child:Column(children: <Widget>[
               
            ],) ,
            ) ,
        
        ),
      ),
          
        ),
        _buildStep(
          title: Text('Disabled'),
          state: StepState.indexed,
          content:  LimitedBox(
        maxWidth: 300,
        maxHeight: 300,
        child: Container(
          color: CupertinoColors.systemGrey,
          child:Text('hello') ,
        
        ),
      ),
       
        )
      ],
    );
  }

  Step _buildStep({
    @required Widget title,
    @required Widget content,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      subtitle: Text('Subtitle'),
      state: state,
      isActive: isActive,
      content:content
    );
  }
}