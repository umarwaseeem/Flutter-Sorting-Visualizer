import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/models/array_item.dart';

class ArrayItemWidget extends StatelessWidget {
  const ArrayItemWidget({
    Key? key,
    required this.heightByValue,
    required this.widthByArraySize,
  }) : super(key: key);

  final ArrayItem heightByValue;
  final double widthByArraySize;
  // builder  method

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          heightByValue.value.toString(),
          style: const TextStyle(
              color: Colors.red, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          width: widthByArraySize,
          height:
              MediaQuery.of(context).size.height * 0.01 + heightByValue.value,
          child: Container(
            decoration: BoxDecoration(
              color: heightByValue.color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
