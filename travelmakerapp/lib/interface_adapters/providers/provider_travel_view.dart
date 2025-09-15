
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/travel.dart';
import '../../usecase/generate_booklet.dart';
import '../../usecase/repositories/repository_comment.dart';
import '../../usecase/repositories/repository_person.dart';
import '../../usecase/repositories/repository_travel.dart';
import '../../usecase/repositories/repository_travel_stop.dart';

/// this provider is destinated to control the travelViewScreen and further
/// screens
class TravelViewProvider with ChangeNotifier{

  /// default constructor
  TravelViewProvider(
      Travel receiveTravel,
      TravelRepository travelRepo,
      StopRepository stopRepo,
      CommentRepository commentRepo,
      PersonRepository personRepo
    ){
    travel = Travel(
      receiveTravel.travelName,
      receiveTravel.description,
      receiveTravel.origin,
      receiveTravel.finish,
      receiveTravel.desiredVehicle,
      receiveTravel.travelStopList,
      receiveTravel.membersList,
      receiveTravel.experiencesList
    );
  }


  /// travel to be shown
  late Travel travel;

  /// trying to generate a booklet
  Future<void> generateBooklet() async {
    final bytes = await generateTravelBookletPdf(travel);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/travel_booklet.pdf');
    await file.writeAsBytes(bytes);

  }

}