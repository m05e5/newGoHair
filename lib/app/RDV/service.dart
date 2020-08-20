import 'package:go_hair/app/RDV/class.dart';

import 'package:uuid/uuid.dart';
List<Vote> getVoteList(){
  //Mock data
  List <Vote> voteList = List<Vote>();
  
  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Election presidentielle',
      options: [
        {'Popole': 70},
        {'Kamto': 10},
        {'Donne Kabral': 1}, 
        {'Njoya': 1},
      
      ]
    ),
  );

   voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Election municipalle',
      options: [
        {'Nodem': 70},
        {'Sandjom': 95},
        {'Gwegou': 67},
        {'Caleb': 80},
      
      ]
    ),
  );

   voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'meilleur cheffe de class',
      options: [
        {'Nangue': 3},
        {'Souvenir': 30},
        {'Massock': 29},
        {'Emmerence': 21},
      
      ]
    ),
  );

  return voteList;
}