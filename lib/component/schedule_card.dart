import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  ScheduleCard({super.key, required this.optionTitle,required this.onClick});

  String optionTitle;
  void Function()? onClick;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(color: Colors.lightBlue),
        child: Center(
          child: Text(
            widget.optionTitle,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
