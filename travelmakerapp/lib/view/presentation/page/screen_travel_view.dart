import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../entities/travel.dart';
import '../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../usecase/repositories/repository_comment.dart';
import '../../../usecase/repositories/repository_person.dart';
import '../../../usecase/repositories/repository_travel.dart';
import '../../../usecase/repositories/repository_travel_stop.dart';
import '../modules/views/view_travel.dart';


/// This screen is responsible for creating the TravelViewProvier and
/// calling the viewTravelWidet
class TravelScreen extends StatelessWidget {
  ///
  const TravelScreen({super.key, required this.travel});

  /// travel that is going to be visualized
  final Travel travel;


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => TravelViewProvider(
        travel,
        context.read<TravelRepository>(),
        context.read<StopRepository>(),
        context.read<CommentRepository>(),
        context.read<PersonRepository>(),
      ),
      child: TravelView()
    ) ;
  }
}


