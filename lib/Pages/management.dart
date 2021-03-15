import 'package:flutter/material.dart';
import 'package:e_edmin/databse/brand.dart';
import 'package:e_edmin/databse/catagory.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Management extends StatefulWidget {
  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  TextEditingController catagoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _catagoryformKey = GlobalKey();
  GlobalKey<FormState> _brandformKey = GlobalKey();
  BrandService _brandService = BrandService();
  CatagoryService _catagoryService = CatagoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add product"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.change_history),
            title: Text("Products list"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text("Add category"),
            onTap: () {
              _catagoryMethod();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text("Category list"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text("Add brand"),
            onTap: () {
              _brandMethod();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("brand list"),
            onTap: () {},
          ),
          Divider(),
        ],
      )),
    );
  }

  void _catagoryMethod() {
    var alert = new AlertDialog(
      content: Form(
        key: _catagoryformKey,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "Catagory cannot be empty";
            }
          },
          controller: catagoryController,
          decoration: InputDecoration(hintText: "Add Catagory"),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              if (catagoryController.text != null) {
                _catagoryService.creatCatagory(catagoryController.text);
              }
              Fluttertoast.showToast(msg: "Catagory Created");
              
            },
            child: Text("add")),
        FlatButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Cancle"))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandMethod() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandformKey,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "Brand cannot be empty";
            }
          },
          controller: catagoryController,
          decoration: InputDecoration(hintText: "Add Brand"),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              if (brandController.text != null) {
                _brandService.creatBrands(brandController.text);
              }
              Fluttertoast.showToast(msg: "Brand Created");
              
            },
            child: Text("add")),
        FlatButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Cancle"))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
