import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/models/array_item.dart';

import 'widgets/array_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<ArrayItem> array = [];
  final controller = TextEditingController();

  int speed = 1000;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(actions: [
        Center(
          child: Text(
            "Speed $speed",
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (speed > 100) {
                speed -= 100;
              }
            });
          },
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              speed += 100;
            });
          },
          icon: const Icon(Icons.remove),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter comma or space separated numbers',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                    child: const Text("Clear Values"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        array.clear();
                      });
                    },
                    child: const Text("Clear Visual"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.text.isNotEmpty
                        ? () async {
                            saveInputValuesToArray();
                            // visualize bubble sort
                            await bubbleSort();
                          }
                        : null,
                    child: const Text("Bubble Sort"),
                  ),
                  ElevatedButton(
                    onPressed: controller.text.isNotEmpty
                        ? () async {
                            saveInputValuesToArray();
                            // visualize insersion sort
                            await insertionSort();
                          }
                        : null,
                    child: const Text("Insersion Sort"),
                  ),
                  ElevatedButton(
                    onPressed: controller.text.isNotEmpty
                        ? () async {
                            saveInputValuesToArray();
                            // visualize selection sort
                            await selectionSort();
                          }
                        : null,
                    child: const Text("Selection Sort"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.72,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.1),
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < array.length; i++)
                      ArrayItemWidget(
                        heightByValue: array[i],
                        widthByArraySize: MediaQuery.of(context).size.width *
                            0.85 /
                            array.length,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> bubbleSort() async {
    for (int i = 0; i < array.length; i++) {
      array[i].color = Colors.green;
      for (int j = 0; j < array.length - i - 1; j++) {
        if (array[j].value > array[j + 1].value) {
          array[j].color = Colors.red;
          array[j + 1].color = Colors.red;
          await Future.delayed(
            Duration(milliseconds: speed),
            () {
              setState(() {
                ArrayItem temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
              });
            },
          );
          array[j].color = Colors.green;
          array[j + 1].color = Colors.green;
        }
      }
    }
  }

  Future<void> insertionSort() async {
    for (int i = 1; i < array.length; i++) {
      array[i].color = Colors.green;
      int j = i - 1;
      while (j >= 0 && array[j].value > array[j + 1].value) {
        array[j].color = Colors.red;
        array[j + 1].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
          () {
            setState(() {
              ArrayItem temp = array[j];
              array[j] = array[j + 1];
              array[j + 1] = temp;
            });
          },
        );
        array[j].color = Colors.green;
        array[j + 1].color = Colors.green;
        j--;
      }
    }
  }

  Future<void> selectionSort() async {
    for (int i = 0; i < array.length; i++) {
      array[i].color = Colors.green;
      int minIndex = i;
      for (int j = i + 1; j < array.length; j++) {
        if (array[j].value < array[minIndex].value) {
          minIndex = j;
        }
      }
      array[minIndex].color = Colors.red;
      array[i].color = Colors.red;
      await Future.delayed(
        Duration(milliseconds: speed),
        () {
          setState(() {
            ArrayItem temp = array[i];
            array[i] = array[minIndex];
            array[minIndex] = temp;
          });
        },
      );
      array[minIndex].color = Colors.green;
      array[i].color = Colors.green;
    }
  }

  void saveInputValuesToArray() {
    array = controller.text
        .trim()
        .split(',')
        .map(
          (e) => ArrayItem(value: int.parse(e), color: Colors.black),
        )
        .toList();
    setState(() {});
  }
}
