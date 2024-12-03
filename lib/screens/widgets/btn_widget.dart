import 'package:flutter/material.dart';

class CBtnWidget extends StatelessWidget {
  const CBtnWidget({
    super.key,
    required this.btnTxt,
    required this.onClicked,
  });

  final String btnTxt;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: const Size.fromHeight(50),
        shape: const StadiumBorder(),
        backgroundColor: Colors.brown,
      ),
      onPressed: onClicked,
      child: FittedBox(
        child: Text(
          btnTxt,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
