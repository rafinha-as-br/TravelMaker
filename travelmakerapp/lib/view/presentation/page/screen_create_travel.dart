import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../usecase/repositories/repository_person.dart';
import '../../../usecase/repositories/repository_travel_stop.dart';
import '../../../usecase/repositories/repository_travel.dart';
import '../../../usecase/repositories/repository_user.dart';
import '../modules/travelForm/travelForm.dart';
class CreateTravelScreen extends StatelessWidget {
  const CreateTravelScreen({super.key,});

  static const routeName = '/CreateTravelScreen';


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => CreateTravelProvider(
        context.read<UserRepository>(),
        context.read<TravelRepository>(),
        context.read<StopRepository>(),
        context.read<PersonRepository>(),
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "Criando uma viagem!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
            ),
            SliverToBoxAdapter(
              child: TravelForm(),
            )
          ],
        ),
      ),
    );
  }
}
