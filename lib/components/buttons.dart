import 'package:flutter/material.dart';

class PatienceBackButton extends StatelessWidget {
  final VoidCallback callback;
  const PatienceBackButton({required this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: ListTile(
          leading:
              Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 27),
          title: Padding(
            child: Text(
              "Back",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(80, 0, 50, 0),
          )),
      onPressed: () => Navigator.pop(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Theme.of(context).primaryColor.withOpacity(0.5);
            return Theme.of(context)
                .primaryColor; // Use the component's default.
          },
        ),
      ),
    );
  }
}
