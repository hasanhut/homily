import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:homily/screens/shopping_list/suggestions.dart';

class ShoppingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToShop - Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TodoList(title: 'Shopping List'),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TodoListState createState() => _TodoListState();
}

// Possible Actions in PopUpMenu
enum MenuActions { ClearSuggestions }

class _TodoListState extends State<TodoList> {
  List<String> _items = [];
  List<String> _completedItems = [];

  Suggestions _suggestions = Suggestions();
  FocusNode _keyboardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = prefs.getStringList("items") ?? [];
      _completedItems = prefs.getStringList("completedItems") ?? [];
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("items", _items);
    prefs.setStringList("completedItems", _completedItems);
  }

  TextEditingController inputController = new TextEditingController();
  void _addItem() {
    String item = inputController.text;
    if (item.length > 0) {
      setState(() {
        _items.add(item);
        _suggestions.add(item);

        // Reset input
        inputController.text = "";
      });
      _saveData();
    } else {
      Fluttertoast.showToast(
        msg: "Add some text to add a new item.",
      );
    }
  }

  void _completeItem(int index) {
    setState(() {
      _completedItems.insert(0, _items.removeAt(index));
    });
    _saveData();
  }

  void _uncompleteItem(int index) {
    setState(() {
      _items.add(_completedItems.removeAt(index));
    });
    _saveData();
  }

  void _clearCompleted() {
    if (_completedItems.length > 0) {
      setState(() {
        _completedItems.clear();
      });
      _saveData();
    } else {
      Fluttertoast.showToast(
        msg:
            "This will only clear completed entries. Tap an entry to mark it as completed.",
      );
    }
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemCount: _items.length + _completedItems.length,
      itemBuilder: (context, index) {
        if (index < _items.length) {
          return _buildListItem(index, _items[index]);
        } else {
          int completedIndex = index - _items.length;
          return _buildCompletedListItem(
              completedIndex, _completedItems[completedIndex]);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildListItem(int itemIndex, String todoText) {
    return new ListTile(
        title: new Text(todoText), onTap: () => _completeItem(itemIndex));
  }

  // Build a single completed todo item
  Widget _buildCompletedListItem(int itemIndex, String todoText) {
    return new ListTile(
      title: new Text(
        todoText,
        style: TextStyle(
            color: Colors.grey, decoration: TextDecoration.lineThrough),
      ),
      onTap: () => _uncompleteItem(itemIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the TodoList object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: _clearCompleted,
            ),
            PopupMenuButton<MenuActions>(
              onSelected: (MenuActions action) {
                switch (action) {
                  case MenuActions.ClearSuggestions:
                    _suggestions.clear();
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<MenuActions>(
                    child: Text("Clear Autocomplete Suggestions"),
                    value: MenuActions.ClearSuggestions,
                  ),
                ];
              },
            )
          ]),
      body: Stack(
        children: <Widget>[
          Container(
            child: _buildTodoList(),
            padding: EdgeInsets.only(bottom: 60),
          ),
          Positioned(
              bottom: 0.0,
              width: MediaQuery.of(context).size.width, // width 100%
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0x80000000),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: inputController,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (dynamic x) => _addItem(),
                      autofocus: true,
                      focusNode: _keyboardFocusNode,
                      decoration: InputDecoration(
                        hintText: "New Item..",
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                    direction: AxisDirection.up,
                    hideOnEmpty: true,
                    suggestionsCallback: (pattern) {
                      if (pattern.length > 0) {
                        return _suggestions.get(pattern);
                      } else {
                        return [];
                      }
                    },
                    debounceDuration: Duration(milliseconds: 100),
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.toString()),
                      );
                    },
                    transitionBuilder:
                        (context, suggestionsBox, animationController) =>
                            suggestionsBox, // no animation
                    onSuggestionSelected: (suggestion) {
                      var object = inputController.text = suggestion.toString();
                      _addItem();
                      if (!_keyboardFocusNode.hasFocus) {
                        FocusScope.of(context).requestFocus(_keyboardFocusNode);
                      }
                    },
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


















































































































/*
class _ShoppingListPageState extends State<ShoppingListPage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ListItem> items = List.from(listItems);
  
  get builder => null;

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: AnimatedList(
            key: listKey,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) => ListItemWidget(
                  item: items[index],
                  animation: animation,
                  OnClicked: () => removeItem(index),
                  // OnClicked: () {},
                )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: insertItem,
        ),
      );

  void insertItem() {
    showDialog(context: context, builder: builder);
    final newIndex = 0;
    final newItem = ListItem(
      title: "Apple",
    );
    items.insert(newIndex, newItem);
    listKey.currentState!.insertItem(
      newIndex,
    );
  }

  void removeItem(int index) {
    final removedItem = items[index];

    items.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        OnClicked: () {},
      ),
    );
  }
}

*/
