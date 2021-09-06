import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CommonAsyncDropdown<T> extends StatefulWidget {
  final Future<dartz.Either<Failure, List<T>>> itemSource;

  final String controlName;
  final String? placeHolderText;

  final dynamic validationMessages;

  CommonAsyncDropdown(
      {required this.itemSource,
      required this.controlName,
      this.validationMessages,
      this.placeHolderText});

  @override
  _CommonAsyncDropdownState<T> createState() => _CommonAsyncDropdownState<T>();
}

class _CommonAsyncDropdownState<T> extends State<CommonAsyncDropdown> {
  List<T> items = [];

  @override
  void initState() {
    loadItemSource();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReactiveDropdownField<T>(
        formControlName: widget.controlName,
        validationMessages: widget.validationMessages,
        menuMaxHeight: MediaQuery.of(context).size.height * .7,
        decoration: InputDecoration(
          labelText: widget.placeHolderText,
        ),
        items: items.map<DropdownMenuItem<T>>((e) {
          return DropdownMenuItem<T>(
            value: e,
            child: Text(e.toString()),
          );
        }).toList(),
        onChanged: (value) {},
        isExpanded: true,
        isDense: true,
      ),
    );
  }

  void loadItemSource() {
    widget.itemSource.then((value) => value.fold((l) => null, (r) {
          setState(() {
            items = r as List<T>;
          });
        }));
  }
}
