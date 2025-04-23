import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/widgets/Calculator/calculatorButton.dart';
import 'package:flutter_application_1/app/widgets/Calculator/customInput.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<Calculator> {
  int x = 0;
  int y = 0;
  num z = 0;

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller1.text = x.toString();
    controller2.text = y.toString();
  }

  void action(actionName) {
    if (num.tryParse(controller1.text) != null &&
        num.tryParse(controller2.text) != null) {
      switch (actionName) {
        case 'add':
          setState(() {
            z = (num.tryParse(controller1.text)! +
                num.tryParse(controller2.text)!);
          });
          break;
        case 'subtract':
          setState(() {
            z = (num.tryParse(controller1.text)! -
                num.tryParse(controller2.text)!);
          });
          break;
        case 'multiply':
          setState(() {
            z = (num.tryParse(controller1.text)! *
                num.tryParse(controller2.text)!);
          });
          break;
        case 'divide':
          setState(() {
            z = (num.tryParse(controller1.text)! /
                num.tryParse(controller2.text)!);
          });
          break;
        default:
          setState(() {
            z = 0;
          });
          break;
      }
    } else {
      setState(() {
        z = 0;
      });
    }
  }

  void clear() {
    setState(() {
      z = 0;
      x = 0;
      y = 0;
      controller1.clear();
      controller2.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Input(
            controller: controller1,
            hint: 'Enter First Number',
          ),
          const SizedBox(height: 16.0),
          Input(
            controller: controller2,
            hint: 'Enter Second Number',
          ),
          const SizedBox(height: 16.0),
          Text(z.toString(), style: const TextStyle(fontSize: 44.0)),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Button(
                action: () {
                  action('add');
                },
                icon: '+'),
            Button(
              action: () {
                action('subtract');
              },
              icon: '-',
            ),
            Button(
              action: () {
                action('multiply');
              },
              icon: 'x',
            ),
            Button(
              action: () {
                action('divide');
              },
              icon: '/',
            )
          ]),
          const SizedBox(height: 15.0),
          Button(
              action: () {
                clear();
              },
              icon: 'Clear'),
          const SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
