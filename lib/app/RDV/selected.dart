import 'package:flutter/material.dart';
import 'package:go_hair/app/RDV/class.dart';
import 'package:go_hair/app/RDV/service.dart';


class VoteState with ChangeNotifier {
  List <Vote> _voteList = List<Vote>();
  Vote _activeVote;
  String _selectedOptionInActiveVote;

  void loadVoteList() async{
    _voteList = getVoteList();
    notifyListeners();
  }


  void clearState(){
    _activeVote = null;
    _selectedOptionInActiveVote = null;
  }  

  List <Vote> get voteList => _voteList;
  Vote get activeVote => _activeVote;
  String get selectedOptionInActiveVote => _selectedOptionInActiveVote; 

  set activeVote(newValue){
    _activeVote = newValue;
    notifyListeners();
  }

  void set selectedOptionInActiveVote(String newValue){
    _selectedOptionInActiveVote = newValue;
    notifyListeners();
  }

}