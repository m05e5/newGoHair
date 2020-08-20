import 'package:flutter/material.dart';
import 'package:go_hair/app/RDV/dateRDV.dart';
import 'package:go_hair/app/RDV/heurRDV.dart';
import 'package:go_hair/app/RDV/selected.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentStep = 0;
  
  @override
  void initState() {
    super.initState();
  
  // loading votes
  Future.microtask(() {
    Provider.of<VoteState>(context, ).clearState();
    Provider.of<VoteState>(context, ).loadVoteList();
  }
    
      );
      }
    
    
      @override
      Widget build(BuildContext context) {
        return Container(
          child: Material(
            child: Column(
              children: <Widget>[
                 Expanded(
                              child: Stepper(
                     type: StepperType.horizontal ,
                     currentStep: _currentStep,
                     steps: [
                       getStep(
                         title: 'Choose',
                         child: Text('bob'),
                         isActive: true, 
                       ),
                        getStep(
                         title: 'Vote',
                         child:  Text('hello'),
                         isActive: _currentStep >= 1 ? true: false, 
                       ),
                        getStep(
                         title: 'Vote',
                         child: Text('last step'),
                         isActive: _currentStep >= 2 ? true: false, 
                       ),
                     ],
                     
                     onStepContinue: (){
                       if(_currentStep == 0){
                         if(step2Required()){
                            setState(() {
                         _currentStep = (_currentStep + 1) > 2 ? 2 : _currentStep + 1;
                       });
                        }else{
                          showSnackBar(context, 'please select a vote first');
                        }
                       } else if(_currentStep == 1){
                         if (step3Required()){
                           Navigator.pop(context);
                         }else{
                           showSnackBar(context, 'please mark your vote!');
                         }
                       }

                      
                     },
                     onStepCancel: (){
                       if(_currentStep <= 0){
                         Provider.of<VoteState>(context, listen: false).activeVote = null;
                       }

                       setState(() {
                         _currentStep = (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
                       });
                     },
                     ),
                 ),
              ],
            )
            
          ),
        );
      }


      bool step2Required(){
        if(Provider.of<VoteState>(context, listen: false).activeVote == null){
          return false;
        }
        return true;
      }
     bool step3Required(){
        if(Provider.of<VoteState>(context, listen: false).selectedOptionInActiveVote == null){
          return false;
        }
        return true;
      }

      void showSnackBar(BuildContext context, String msg){
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              msg,
              style: TextStyle(fontSize: 22),
            ), 
          ),
        );
      }
      Step getStep({String title, Widget child, bool isActive = false}){
          return Step(
            title: Text(title),
            content: child,
            isActive: isActive,
          );
      }
    } 