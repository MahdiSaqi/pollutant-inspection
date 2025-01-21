import 'package:flutter/material.dart';
import 'package:pollutant_inspection/enums/fueling_type.dart';

class DropdownEnum extends StatefulWidget {
  @override
  _DropdownEnumState createState() => _DropdownEnumState();
}

class _DropdownEnumState extends State<DropdownEnum> {
  FuelingType? _selectedMembership = FuelingType.Carburetor;  // Initial selection

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: DropdownButton<FuelingType>(
          value: _selectedMembership,
          icon: Icon(Icons.arrow_downward),
          onChanged: (FuelingType? newValue) {
            setState(() {
              _selectedMembership = newValue;
            });
          },
          items: FuelingType.values.map<DropdownMenuItem<FuelingType>>((FuelingType value) {
            return DropdownMenuItem<FuelingType>(
              value: value,
              child: Text(_membershipToString(value)),
            );
          }).toList(),
        ),
      );
  }

  // Convert enum to string for display purposes
  String _membershipToString(FuelingType membership) {
    return membership.toString().split('.').last.capitalize();
  }
}

// Extension on String to capitalize the first letter
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
