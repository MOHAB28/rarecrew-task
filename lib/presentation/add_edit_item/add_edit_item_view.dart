import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/custom_text_form_field.dart';
import '../home/home_viewmodel.dart';
import '../home/model.dart';

class AddEditItemView extends ConsumerStatefulWidget {
  const AddEditItemView({
    super.key,
    this.itemId,
  });
  final String? itemId;

  @override
  ConsumerState<AddEditItemView> createState() => _AddEditItemState();
}

class _AddEditItemState extends ConsumerState<AddEditItemView> {
  bool _isInit = true;
  ItemModel _loadedItem = ItemModel(
    description: '',
    id: null,
    price: 0,
    title: '',
  );
  Map<String, dynamic> _initValues = {
    'title': '',
    'description': '',
    'price': ''
  };
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.itemId != null) {
        _loadedItem = ref.watch(homeViewmodel).findItemById(widget.itemId!);
        _initValues = {
          'title': _loadedItem.title,
          'description': _loadedItem.description,
          'price': _loadedItem.price,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    _loadedItem.id != null
        ? ref.watch(homeViewmodel).updateItem(
              widget.itemId!,
              ItemInput(
                description: _loadedItem.description,
                price: _loadedItem.price,
                title: _loadedItem.title,
              ),
            )
        : ref.watch(homeViewmodel).addItem(
              ItemInput(
                description: _loadedItem.description,
                price: _loadedItem.price,
                title: _loadedItem.title,
              ),
            );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loadedItem.id != null ? 'Edit Item' : 'Add Item'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CustomTextFormField(
                title: 'Title',
                hintText: '',
                keyboardType: TextInputType.text,
                initialValue: _initValues['title'],
                onSaved: (val) {
                  _loadedItem = ItemModel(
                    id: _loadedItem.id,
                    title: val!,
                    description: _loadedItem.description,
                    price: _loadedItem.price,
                  );
                },
                validator: (val) {
                  if (val!.isEmpty || val.length <= 4) {
                    return 'Enter item\'s title greater than 4';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              CustomTextFormField(
                title: 'Price',
                hintText: '',
                keyboardType: TextInputType.number,
                initialValue: _initValues['price'].toString(),
                onSaved: (val) {
                  _loadedItem = ItemModel(
                    id: _loadedItem.id,
                    title: _loadedItem.title,
                    description: _loadedItem.description,
                    price: double.parse(val!),
                  );
                },
                validator: (val) {
                  if (val!.isEmpty || double.parse(val) <= 0) {
                    return 'Enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              CustomTextFormField(
                title: 'Description',
                hintText: '',
                maxLines: 3,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                initialValue: _initValues['description'],
                onSaved: (val) {
                  _loadedItem = ItemModel(
                    id: _loadedItem.id,
                    title: _loadedItem.title,
                    description: val!,
                    price: _loadedItem.price,
                  );
                },
                validator: (val) {
                  if (val!.isEmpty || val.length < 10) {
                    return 'Enter a valid description greater than 10';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
