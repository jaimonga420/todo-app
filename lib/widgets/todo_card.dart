import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.time,
    required this.check,
    required this.selected,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final String time;
  final bool check;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: const Color(0xff5e616a)),
            child: Transform.scale(
              scale: 1.3,
              child: Checkbox(
                value: check,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onChanged: (value) {},
                activeColor: const Color(0xff6cf8a9),
                checkColor: const Color(0xff0e3e26),
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: 75,
            child: Card(
              color: const Color(0xff2a2e3d),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 33,
                    width: 33,
                    decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(iconData, color: iconColor,),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
