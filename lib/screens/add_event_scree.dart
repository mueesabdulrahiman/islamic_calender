import 'package:calendar/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  //Function showNotification;
  AddEventScreen(
      //this.showNotification
      );

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();

  final _detailsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime? formattedDate;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _detailsController.dispose();
  }

  bool isLoading = false;

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      // print(DateFormat('yyyy-MM-dd').format(selectedDate));

      // await widget.showNotification(
      //   _titleController.text,
      //   _detailsController.text,
      //   selectedDate,
      // );
      await Provider.of<Data>(context, listen: false).insertLocalEvent(
          DateFormat('yyyy-MM-dd').format(selectedDate), _titleController.text);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Event added successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
      _titleController.text = "";
      _detailsController.text = "";
    } catch (error) {
      print(error.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  helperText: "Enter title",
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                width: 15,
              ),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  helperText: "Enter details",
                ),
                maxLines: 3,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the details';
                  }
                  return null;
                },
              ),
              const SizedBox(
                width: 15,
              ),
              TextFormField(
                controller: _dateController,
                keyboardType: TextInputType.none,
                decoration: const InputDecoration(
                  helperText: 'click to choose other date',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'date should not be empty';
                  } else {
                    return null;
                  }
                },
                onTap: () async {
                  final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)));

                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                    _dateController.text =
                        DateFormat('dd-MM-yyyy').format(selectedDate);
                  }
                },
              ),
              // DateTimePicker(
              //   type: DateTimePickerType.dateTimeSeparate,
              //   dateMask: 'd MMM, yyyy',
              //   initialValue: DateTime.now().toString(),
              //   firstDate: DateTime(2000),
              //   lastDate: DateTime(2100),
              //   icon: Icon(Icons.event),
              //   dateLabelText: 'Date',
              //   timeLabelText: "Hour",
              //   selectableDayPredicate: (date) {
              //     return true;
              //   },
              //   onChanged: (val) {
              //     setState(() {
              //       selectedDate = DateTime.parse(val);
              //     });
              //   },
              //   validator: (val) {
              //     // print(val);
              //     return null;
              //   },
              //   onSaved: (val) {
              //     setState(() {
              //       selectedDate = DateTime.parse(val!);
              //     });
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                // textColor: Colors.white,
                //  color: Colors.green,
                onPressed: isLoading
                    ? null
                    : () {
                        _saveForm();
                      },
                // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                // textColor: Colors.white,
                //  color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                  ],
                ),
                // shape: new RoundedRectangleBorder(
                //   borderRadius: new BorderRadius.circular(30.0),
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
