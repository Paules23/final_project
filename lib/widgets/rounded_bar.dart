import 'package:flutter/material.dart';

class RoundedBar extends StatelessWidget {
  final List<String> buttonTitles;
  final ValueChanged<int> onPressed;

  const RoundedBar({
    Key? key,
    required this.buttonTitles,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 161, 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buttonTitles
            .asMap()
            .map(
              (index, title) => MapEntry(
                index,
                ElevatedButton(
                  onPressed: () {
                    onPressed(index);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 188, 72),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                          color: const Color.fromARGB(255, 248, 171, 37)),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
