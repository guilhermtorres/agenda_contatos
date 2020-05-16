import 'dart:io';

import 'package:agenda_contatos/App/src/models/contact_models.dart';
import 'package:agenda_contatos/App/src/views/contact_views.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderaz, orderza }

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

    getAllContacts();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Contact c = Contact();
  //   c.name = 'Guilherme Torres';
  //   c.email = 'diretoria@pontocare.com.br';
  //   c.phone = '21999041803';
  //   c.img = null;

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
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text(
                  'Ordenar de A-Z',
                ),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text(
                  'Ordenar de Z-A',
                ),
                value: OrderOptions.orderza,
              ),
            ],
            onSelected: orderList,
          ),
        ],
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
        color: Colors.brown[700],
        child: Container(
          height: 50,
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showContactView();
        },
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
            SizedBox(width: 10),
            Container(
              width: 70,
              height: 70,
              child: CircleAvatar(
                child: contacts[index].img != null
                    ? FileImage(
                        File(
                          contacts[index].img,
                        ),
                      )
                    : Image.asset(
                        'assets/images/icons8.png',
                        scale: 2,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  height: 35,
                  width: 240,
                  child: FittedBox(
                      child: Text(
                    contacts[index].name ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 35,
                  width: 240,
                  child: FittedBox(
                    child: Text(
                      contacts[index].email ?? '',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 35,
                  width: 240,
                  child: FittedBox(
                    child: Text(
                      contacts[index].phone ?? '',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(height: 15)
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        showOptions(context, index);
      },
    );
  }

  void showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        onPressed: () {
                          launch('tel:${contacts[index].phone}');
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Ligar',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showContactView(
                            contact: contacts[index],
                          );
                        },
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: () {
                          models.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Excluir',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void showContactView({Contact contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactViews(
          contact: contact,
        ),
      ),
    );
    if (recContact != null) {
      if (contact != null) {
        await models.updateContact(recContact);
      } else {
        await models.saveContact(recContact);
      }
      getAllContacts();
    }
  }

  void getAllContacts() {
    models.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        contacts.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {});
  }
}
