import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/models/array_item.dart';

class ArrayItemWidget extends StatefulWidget {
  const ArrayItemWidget({
    Key? key,
    required this.heightByValue,
    required this.widthByArraySize,
    required this.speed,
  }) : super(key: key);

  final ArrayItem heightByValue;
  final double widthByArraySize;
  final int speed;

  @override
  State<ArrayItemWidget> createState() => _ArrayItemWidgetState();
}

class _ArrayItemWidgetState extends State<ArrayItemWidget> {
  // builder  method
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          widget.heightByValue.value.toString(),
          style: const TextStyle(
              color: Colors.red, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        AnimatedContainer(
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          curve: Curves.easeInOutQuart,
          duration: Duration(milliseconds: widget.speed),
          margin: const EdgeInsets.symmetric(horizontal: 1),
          width: widget.widthByArraySize,
          height: MediaQuery.of(context).size.height * 0.01 +
              widget.heightByValue.value * 0.5,
          decoration: BoxDecoration(
            color: widget.heightByValue.color,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ],
    );
  }
}
