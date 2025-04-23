import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.controller,
    this.hint = 'Enter a number',
    this.label,
    this.required = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final String? label;
  final bool? required;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null && label!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  spacing: 6.0,
                  children: [
                    Text(label!),
                    required != null && required!
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFD8DCDD),
                    width: 1.0,
                  )),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD8DCDD), // border when enabled
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 128, 128, 1), // border when focused
                  width: 2.0,
                ),
              ),
              hintText: hint,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 94, 86, 86))),
          keyboardType: keyboardType ?? TextInputType.text,
        ),
      ],
    );
  }
}
