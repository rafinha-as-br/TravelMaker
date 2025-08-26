import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/stopForm.dart';

import '../../Themes/getTheme.dart';
import '../modules/dialogs/confirmBackDialog.dart';
import '../provider/createTravelProvider.dart';

class StopScreen extends StatefulWidget {
  const StopScreen({super.key});

  static const routeName = '/StopScreen';

  @override
  State<StopScreen> createState() => _StopScreenState();
}

class _StopScreenState extends State<StopScreen> {
  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Adicionar parada", style: Theme.of(context).textTheme.displayMedium,),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: getPrimaryColor(),),
                onPressed: () async {

                  // to make shure that the user won't lose the changes in case of editing a stop
                  if(createTravelProvider.isEditingStop == true){
                    final bool? answer = await showDialog(
                        context: context,
                        builder: (context) => ConfirmbackDialog()
                    );

                    if(answer == true && context.mounted){
                      createTravelProvider.clearStopData();
                      Navigator.of(context).pop();
                    }
                  }



                }),
            iconTheme: IconThemeData(color: getPrimaryColor()),
            backgroundColor: getCanvasColor(),
            floating: true,
            snap: true,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: StopForm(),
          )
        ],
      ),
    );
  }
}
