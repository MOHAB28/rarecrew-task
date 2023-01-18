import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEditItemView extends ConsumerStatefulWidget {
  const AddEditItemView({super.key});

  @override
  ConsumerState<AddEditItemView> createState() => _AddEditItemState();
}

class _AddEditItemState extends ConsumerState<AddEditItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
    );
  }
}