import 'package:flutter/material.dart';

class DoneDialog extends StatelessWidget {
  final String? message;
  DoneDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: SizedBox(
          height: MediaQuery.of(context).size.height * .09,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
              Text(
                message!,
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
      actions: [
        ElevatedButton(
          child: const Center(
            child: Text("Ok", style: TextStyle(fontSize: 20)),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
