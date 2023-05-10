import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    //Probably will be removed later
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        style: const TextStyle(fontSize: 14),
        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 30,
        isDense: true,
        elevation: 0,
        dropdownColor: Colors.lightGreen.withOpacity(0.25),
        borderRadius: BorderRadius.circular(25),
        items: const [
          DropdownMenuItem(
            value: '1',
            child: Text('Log out'),
          ),
          DropdownMenuItem(
            child: Text('Option 2'),
            value: '2',
          )
        ],
        onChanged: (val) {},
      ),
    );
  }
}
