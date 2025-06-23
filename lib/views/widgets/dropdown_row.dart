import 'package:flutter/material.dart';

class DropdownRow extends StatelessWidget {
  final String label;
  final String value;
  final Map currencies;
  final void Function(String?) onChanged;

  const DropdownRow({
    required this.label,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(15),
          menuMaxHeight: 500.0,
          value: value,
          icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
          isExpanded: true,
          onChanged: onChanged,
          // This controls the selected value's text style
          style: TextStyle(
            color: Colors.white, // Selected item (when dropdown is closed)
            fontSize: 16,
          ),

          // Custom dropdown background (glass-like feel)
          dropdownColor: Colors.white.withOpacity(0.85), // glass effect
          items: currencies.keys.map<DropdownMenuItem<String>>((currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(
                '$currency - ${currencies[currency]}',
                style: TextStyle(
                  color: const Color.fromARGB(255, 78, 78, 78), // dropdown menu items
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        )),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
