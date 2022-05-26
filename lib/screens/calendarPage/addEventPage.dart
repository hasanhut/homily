import 'package:flutter/material.dart';
import 'package:homily/service/currentUser.dart';
import 'package:homily/service/database.dart';
import 'package:provider/provider.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  void _createCalendarEvent(BuildContext context, String title,
      String description, DateTime? eventDate) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase().addCalendarEvents(
        _currentUser.getCurrentUser.groupId!, title, description, eventDate);
    if (_returnString == "success") {
      print("BASARIYLA TAMAMLANDI");
    }
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  DateTime? _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool? processing;

  @override
  void initState() {
    super.initState();
    _eventDate = DateTime.now();
    processing = false;
  }

  TextEditingController _titleNameController = TextEditingController();
  TextEditingController _descriptionNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M I L Y"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _titleNameController,
                  validator: (value) =>
                      (value!.isEmpty) ? "Please Enter title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionNameController,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                      (value!.isEmpty) ? "Please Enter description" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text(
                    "${_eventDate!.year} - ${_eventDate!.month} - ${_eventDate!.day}"),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _eventDate!,
                      firstDate: DateTime(_eventDate!.year - 5),
                      lastDate: DateTime(_eventDate!.year + 5));
                  if (picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              processing!
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                processing = true;
                              });
                              _createCalendarEvent(
                                  context,
                                  _titleNameController.text,
                                  _descriptionNameController.text,
                                  _eventDate);
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });
                            }
                          },
                          child: Text(
                            "Save",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleNameController.dispose();
    _descriptionNameController.dispose();
    super.dispose();
  }
}
