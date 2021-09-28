import 'package:flutter/material.dart';

class InputList extends StatefulWidget {

  final List<TextEditingController> controllers;
  final List<String> labels;

  const InputList(this.labels, this.controllers, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputListState();
}

class _InputListState extends State<InputList> {

  late List<TextEditingController> _controllers;
  late List<String> _labels;

  @override
  void initState() {
    super.initState();
    _controllers = widget.controllers;
    _labels = widget.labels;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: getInputList(),
      ),
    );
  }

  List<Widget> getInputList() {
    List<Widget> fields = [];
    for(int i = 0; i < _controllers.length; i++) {
      fields.add(Container(height: 6));
      fields.add(TextField(
        controller: _controllers[i],
        decoration: InputDecoration(
          labelText: _labels[i],
          border: const OutlineInputBorder(),
        ),
      ));
    }
    return fields;
  }

}