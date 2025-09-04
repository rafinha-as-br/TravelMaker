import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key });

  @override
  Widget build(BuildContext context) {
    final Image logoIcon;
    final Image logoText;

    if(Theme.of(context).brightness == Brightness.dark){
      logoIcon = Image.asset('assets/images/cello_trips_logo_icon_dark_theme.jpg', width: 300, height: 150,);
      logoText = Image.asset('assets/images/cello_trips_logo_text_dark_theme.jpg', width: 300,);
    } else{
      logoIcon = Image.asset('assets/images/cello_trips_logo_icon_light_theme.jpg', width: 300, height: 150, );
      logoText = Image.asset('assets/images/cello_trips_logo_text_light_theme.jpg', width: 300, );
    }

    return Scaffold(
      body:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 160,
                          width: 140,
                          child: logoIcon
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 160,
                          width: 160,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          )
                      ),
                    )

                  ],
                ),
                SizedBox(height: 30,),
                logoText
              ],
            )
          ),


    );
  }
}
