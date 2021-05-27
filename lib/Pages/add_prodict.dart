import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_edmin/databse/brand.dart';
import 'package:e_edmin/databse/catagory.dart';
import 'package:e_edmin/databse/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  ProductService _productService = ProductService();
  TextEditingController catagoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  GlobalKey<FormState> _catagoryformKey = GlobalKey();
  GlobalKey<FormState> _brandformKey = GlobalKey();
  BrandService _brandService = BrandService();
  CatagoryService _catagoryService = CatagoryService();
  List<DocumentSnapshot> brands = [];
  List<DocumentSnapshot> catagories = [];
  List<DropdownMenuItem<String>> catagoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCatagory;
  String _currentBrand;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> selectedSizes = <String>[];
  File _image1;
  File _image2;
  File _image3;
  final picker = ImagePicker();
  bool isLoading = false;
  String image1;
  String image2;
  String image3;

  @override
  void initState() {
    _getcatagories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCatagoriesDropDown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < catagories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(
                  catagories[i].data()["category"],
                ),
                value: catagories[i].data()["category"]));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandosDropDown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data()["brand"]),
                value: brands[i].data()["brand"]));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Add Photo",
                  style: TextStyle(fontSize: 15, color: Colors.orange[800]),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: () async {
                            final pickedFile = await picker.getImage(
                                source: ImageSource.gallery);

                            setState(() {
                              if (pickedFile != null) {
                                _image1 = File(pickedFile.path);
                              } else {
                                print('No image selected.');
                              }
                            });
                          },
                          child: _displayChild1(),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: OutlineButton(
                    //         borderSide: BorderSide(
                    //             color: grey.withOpacity(0.5), width: 2.5),
                    //         onPressed: () async {
                    //           final pickedFile = await picker.getImage(
                    //               source: ImageSource.gallery);

                    //           setState(() {
                    //             if (pickedFile != null) {
                    //               _image2 = File(pickedFile.path);
                    //             } else {
                    //               print('No image selected.');
                    //             }
                    //           });
                    //         },
                    //         child: _displayChild2()),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: OutlineButton(
                    //         borderSide: BorderSide(
                    //             color: grey.withOpacity(0.5), width: 2.5),
                    //         onPressed: () async {
                    //           final pickedFile = await picker.getImage(
                    //               source: ImageSource.gallery);

                    //           setState(() {
                    //             if (pickedFile != null) {
                    //               _image3 = File(pickedFile.path);
                    //             } else {
                    //               print('No image selected.');
                    //             }
                    //           });
                    //         },
                    //         child: _displayChild3()),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      hintText: "Product Name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You Have to Add Product Name';
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                    DropdownButton(
                      items: catagoriesDropDown,
                      onChanged: changeselectedCatagory,
                      value: _currentCatagory,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Brand: ',
                        style: TextStyle(color: red),
                      ),
                    ),
                    DropdownButton(
                      items: brandsDropDown,
                      onChanged: changeSelectedBrand,
                      value: _currentBrand,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: quatityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      hintText: "Quantity",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You Have to Add Product Name';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      hintText: "Price",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You Have to Add Price';
                      }
                    },
                  ),
                ),
                Text(
                  "Availabse Sizes",
                  style: TextStyle(fontSize: 15, color: Colors.orange[800]),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: selectedSizes.contains('S'),
                        onChanged: (value) => changeSelectedSize("S")),
                    Text("S"),
                    Checkbox(
                        value: selectedSizes.contains('M'),
                        onChanged: (value) => changeSelectedSize("M")),
                    Text("M"),
                    Checkbox(
                        value: selectedSizes.contains('L'),
                        onChanged: (value) => changeSelectedSize("L")),
                    Text("L"),
                    Checkbox(
                        value: selectedSizes.contains('XL'),
                        onChanged: (value) => changeSelectedSize("XL")),
                    Text("XL"),
                    Checkbox(
                        value: selectedSizes.contains('XXL'),
                        onChanged: (value) => changeSelectedSize("XXL")),
                    Text("XXL"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: selectedSizes.contains('28'),
                      onChanged: (value) => changeSelectedSize("28"),
                    ),
                    Text("28"),
                    Checkbox(
                        value: selectedSizes.contains('30'),
                        onChanged: (value) => changeSelectedSize("30")),
                    Text("30"),
                    Checkbox(
                        value: selectedSizes.contains('32'),
                        onChanged: (value) => changeSelectedSize("32")),
                    Text("32"),
                    Checkbox(
                        value: selectedSizes.contains('34'),
                        onChanged: (value) => changeSelectedSize("34")),
                    Text("34"),
                    Checkbox(
                        value: selectedSizes.contains('36'),
                        onChanged: (value) => changeSelectedSize("36")),
                    Text("36"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: selectedSizes.contains('40'),
                        onChanged: (value) => changeSelectedSize("40")),
                    Text("40"),
                    Checkbox(
                        value: selectedSizes.contains('42'),
                        onChanged: (value) => changeSelectedSize("42")),
                    Text("42"),
                    Checkbox(
                        value: selectedSizes.contains('44'),
                        onChanged: (value) => changeSelectedSize("44")),
                    Text("44"),
                    Checkbox(
                        value: selectedSizes.contains('46'),
                        onChanged: (value) => changeSelectedSize("46")),
                    Text("46"),
                    Checkbox(
                        value: selectedSizes.contains('48'),
                        onChanged: (value) => changeSelectedSize("48")),
                    Text("48"),
                  ],
                ),
                FlatButton(
                    textColor: Colors.white,
                    color: Colors.orange[800],
                    onPressed: () {
                      validateAndUpload();
                    },
                    child: Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getcatagories() async {
    List<DocumentSnapshot> data = await _catagoryService.getCatagory();
    setState(() {
      catagories = data;
      catagoriesDropDown = getCatagoriesDropDown();
      _currentCatagory = catagories[0].data()["category"];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBrandosDropDown();
      _currentBrand = brands[0].data()['brand'];
    });
  }

  changeselectedCatagory(String selectedCatagory) {
    setState(() => _currentCatagory = selectedCatagory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.add(size);
      });
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  // Widget _displayChild2() {
  //   if (_image2 == null) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
  //       child: new Icon(
  //         Icons.add,
  //         color: grey,
  //       ),
  //     );
  //   } else {
  //     return Image.file(
  //       _image2,
  //       fit: BoxFit.fill,
  //       width: double.infinity,
  //     );
  //   }
  // }

  // Widget _displayChild3() {
  //   if (_image3 == null) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
  //       child: new Icon(
  //         Icons.add,
  //         color: grey,
  //       ),
  //     );
  //   } else {
  //     return Image.file(
  //       _image3,
  //       fit: BoxFit.fill,
  //       width: double.infinity,
  //     );
  //   }
  // }

  Future<void> validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        if (selectedSizes.isNotEmpty) {
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          UploadTask task1 = storage.ref().child(picture1).putFile(_image1);
          task1.then((TaskSnapshot tasksnapshot) {
            tasksnapshot.ref.getDownloadURL().then((snapshot) {
              image1 = snapshot;
            });
          });

          // final String picture2 =
          //     "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          // UploadTask task2 = storage.ref().child(picture2).putFile(_image2);
          // task2.then((TaskSnapshot tasksnapshot) {
          //   tasksnapshot.ref.getDownloadURL().then((snapshot) {
          //     image2 = snapshot;
          //   });
          // });

          // final String picture3 =
          //     "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          // UploadTask task3 = storage.ref().child(picture3).putFile(_image3);
          // task3.then((TaskSnapshot tasksnapshot) {
          //   tasksnapshot.ref.getDownloadURL().then((snapshot) {
          //     image3 = snapshot;
          //   });
          // });
          if (image1 != null) {
            _productService.uploadProduct(
              productName: productNameController.text,
              category: _currentCatagory,
              brand: _currentBrand,
              quantity: int.parse(quatityController.text),
              price: double.parse(priceController.text),
              sizes: selectedSizes,
              images: [image1.toString()],
            );
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Fluttertoast.showToast(msg: "Product Added");
          }
        } else {
          setState(() => isLoading = false);
          Fluttertoast.showToast(msg: 'select atleast one size');
        }
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
