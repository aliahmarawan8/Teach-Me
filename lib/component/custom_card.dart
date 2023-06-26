import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  CustomCard({super.key, required this.imageUrl, required this.cardTitle,required this.onClick});

  String imageUrl;
  String cardTitle;
  void Function()? onClick;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey.withOpacity(0.4),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Image(
                image: AssetImage(widget.imageUrl),
                width: double.infinity,
                fit: BoxFit.fill,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.cardTitle,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
