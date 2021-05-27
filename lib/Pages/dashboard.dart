import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            child: ListTile(
              subtitle: FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green,
                ),
                label: Text('12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green)),
              ),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.people_outline,color: Colors.indigo),
                              label:
                                  Text("Users", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900))),
                          subtitle: Text(
                            '7',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 40.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                            padding: EdgeInsets.only(right: 13),
                              onPressed: null,
                              icon: Icon(Icons.category,color: Colors.indigo),
                              label: Text(
                                "Categories",
                                style: TextStyle(fontSize: 12),
                              )),
                          subtitle: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 40.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                            padding: EdgeInsets.only(right: 13),
                              onPressed: null,
                              icon: Icon(Icons.track_changes,color: Colors.indigo),
                              label: Text("Producs",
                                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.w900))),
                          subtitle: Text(
                            '120',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 40.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.tag_faces,color: Colors.indigo),
                              label:
                                  Text("Sold", style: TextStyle(fontSize: 12,fontWeight: FontWeight.w900))),
                          subtitle: Text(
                            '13',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 40.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                            padding: EdgeInsets.only(right: 13),
                              onPressed: null,
                              icon: Icon(Icons.shopping_cart,color: Colors.indigo),
                              label: Text("Orders",
                                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.w900))),
                          subtitle: Text(
                            '5',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 40.0),
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.close,color: Colors.indigo,),
                                label: Text("Return",
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w900))),
                            subtitle: Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 40.0),
                            )),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
