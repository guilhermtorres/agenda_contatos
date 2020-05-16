import 'dart:io';

import 'package:agenda_contatos/App/src/models/contact_models.dart';
import 'package:flutter/material.dart';

class HomeViews extends StatefulWidget {
  @override
  _HomeViewsState createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  ContactModels models = ContactModels();

  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    models.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Contact c = Contact();
  //   c.name = 'Guilherme Torres';
  //   c.email = 'diretoria@pontocare.com.br';
  //   c.phone = '21999041803';
  //   c.img = 'imgtest';

  //   models.saveContact(c);
  //   models.getAllContacts().then((list) {
  //     print(list);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})],
        elevation: 5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  "assets/images/icon.png",
                  color: Colors.white,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            SizedBox(
              width: 60,
            ),
            Text(
              'Contatos',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return contactCard(context, index);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 50,
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: contacts[index].img != null
                      ? FileImage(
                          File(
                            contacts[index].img,
                          ),
                        )
                      : Icon(Icons.account_circle),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 26,
                  child: Text(
                    contacts[index].name ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 24,
                  child: Text(
                    contacts[index].email ?? '',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  child: Text(
                    contacts[index].phone ?? '',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 15)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
