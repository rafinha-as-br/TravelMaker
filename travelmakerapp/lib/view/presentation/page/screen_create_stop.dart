import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../interface_adapters/providers/createTravelProvider.dart';
import '../modules/dialogs/confirmBackDialog.dart';
import '../modules/travelForm/stopForm.dart';

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
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () async {

                  // to make shure that the user won't lose the changes in case of editing a stop
                  if(createTravelProvider.isEditingStop == true){
                    final bool? answer = await showDialog(
                        context: context,
                        builder: (context) => ConfirmbackDialog()
                    );

                    if(answer == true && context.mounted){
                      createTravelProvider.clearStopData();
                      createTravelProvider.sfc!.dispose();
                      Navigator.of(context).pop();
                    }
                  } else{
                    Navigator.of(context).pop();
                  }



                }),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor:  Theme.of(context).canvasColor,
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
