import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          SizedBox(
            height: 69,
            width: 69,
            child: Image.asset('assets/images/dartmouth_logo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              _NavBarItem('Jason Kim'),
              SizedBox(width: 60,),
              _NavBarItem('Jacobson Lab'),
            ]
          )
        ]
      )
    );
  }
}


class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(
    this.title, 
    {Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18),
    );
  }
}