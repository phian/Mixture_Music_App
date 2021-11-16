import 'package:flutter/material.dart';

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  /// The value that will receive when user selected the item
  final T value;

  /// The custom child to display the content inside the item
  final Widget child;

  const DropdownItem({Key? key, required this.value, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
