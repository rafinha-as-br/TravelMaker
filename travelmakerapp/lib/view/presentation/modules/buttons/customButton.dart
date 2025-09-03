import 'package:flutter/material.dart';

class SmallButton1 extends StatelessWidget {
  const SmallButton1({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;



  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border.all(
                width: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(icon, color: Theme.of(context).primaryColor,),
                Text(text, style: Theme.of(context).textTheme.displaySmall),
              ],)
        )
    );
  }
}
class SmallButton2 extends StatelessWidget {
  const SmallButton2({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;



  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              border: Border.all(
                width: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(icon, color: Theme.of(context).primaryColor,),
                Text(text, style: Theme.of(context).textTheme.displaySmall),
              ],)
        )
    );
  }
}

class MediumButton1 extends StatelessWidget {
  const MediumButton1({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              SizedBox(width: 10,),
              Icon(icon, color: Theme.of(context).primaryColor,),
              Text(text, style: Theme.of(context).textTheme.displaySmall),
            ],)
      )
    );
  }
}

class MediumButton2 extends StatelessWidget {
  const MediumButton2({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              SizedBox(width: 10,),
              Icon(icon, color: Theme.of(context).primaryColor,),
              Text(text, style: Theme.of(context).textTheme.displaySmall),
            ],)
      )
    );
  }
}


class MediumButton3 extends StatelessWidget {
  //text and icon on center
  const MediumButton3({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              Icon(icon, color: Theme.of(context).primaryColor,),
              Text(text, style: Theme.of(context).textTheme.displayMedium),
            ],)
      )
    );
  }
}


