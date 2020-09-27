import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:go_hair/models/appointment.dart';
import 'package:go_hair/pages/auth/prendreRDV.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:go_hair/pages/front/home.dart';
import 'package:intl/intl.dart'; 
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

void main() => runApp(StepperApp());

class StepperApp extends StatelessWidget {
  
 
  
  @override
  Widget build(BuildContext context) {
    return StepperPage();
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
  String time;
  String detail;
  DateTime _currentDate;
  DateTime today;
  var _markedDateMap;
  

  
  @override
  void initState() {
    String month = DateTime.now().month.toString();
    String day = DateTime.now().day.toString();
    if(month.length == 1)month = '0$month';
    if(day.length == 1)day = '0$day';
    today = DateTime.parse("${DateTime.now().year}-$month-$day");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation'),
      ),
      body: SafeArea(
        child: _buildStepper(StepperType.horizontal)
      ),
    );
  }

  _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 3;
    var i = 0;
        return Stepper(
          type: type,
          currentStep: currentStep,
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
          onStepContinue: canContinue ? (){
              setState(() => ++currentStep);
          }  : null,
          steps: [

          _buildStep(
            title: Text('Date'),
            content:  dateDuRDV()
          ),
            _buildStep(
            title: Text('Heur'),
            content:  heurDuRDV()
          ),
          _buildStep(
            title: Text('Disabled'),
            content:  Text('hello')
          ),
          _buildStep(
              title: Text('Step ${i + 1}'),
              content: step1()
            ),
      ],
    );
  }

  Step _buildStep({
    @required Widget title,
    @required Widget content,
    StepState state = StepState.indexed,
    bool isActive = false,
     labelPadding: Checkbox.width,
  }) {
    return Step(
      title: title,
      state: state,
      isActive: isActive,
      content:content
    );
  }

  step1(){
    return Column(children: <Widget>[
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Prenom",
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Contact",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                clientPhone = value;
              },
            ),
    ],);
  }
   saveAppointement() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    CollectionReference reference = Firestore.instance.collection(Appointment.table_name);
    reference.document().setData({
      Appointment.label_id : reference.document().documentID,
      Appointment.label_shop_id : shopId,
      Appointment.label_user_id : user.uid,
      Appointment.label_client_name : clientName,
      Appointment.label_client_phone : clientPhone,
      Appointment.label_date: date,
      Appointment.label_time: time,
      Appointment.label_details : detail,
      
    });
     Navigator.push(context, MaterialPageRoute(builder: (context)=>new FrontHomePage()));
  }

  showMyDialog() async{
    await showDialog(context: context, builder: (buildContext){
      return SimpleDialog(children: <Widget>[Text('BOOM')],);
    });
  }
  Widget heurDuRDV(){
    return Column(children: <Widget>[
       Wrap(children: <Widget>[
    RDVTime('12:00'),
    RDVTime('12:00'),
    RDVTime('12:00'),
    RDVTime('12:00'),
    RDVTime('12:00'),
    RDVTime('12:00'),
    RDVTime('12:00'),
  ],)
    ],);
  }

  Widget dateDuRDV() {
 
    return Column(
      children: <Widget>[
        Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        height: 300,
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
          print(date);
        },
        minSelectedDate: today,
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.white,
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
            
        },
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        selectedDayButtonColor: Colors.orange,
        selectedDayBorderColor: Colors.orange,
      selectedDateTime: _currentDate,
      daysHaveCircularBorder: true,
    ),
  ),
 
      ],
    );
}


}
class RDVTime extends StatelessWidget {
 final String lheur;
 const RDVTime(this.lheur);
  final bool isSelected = false;




 @override
 Widget build(BuildContext context) {
   return Container(
    margin: EdgeInsets.symmetric(horizontal: 4, vertical:2),
    height: 40,
    width: 100,
    child: FlatButton(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      onPressed: (){
        
      },
      child: Text(lheur)
    ),
  
   );
 }
}