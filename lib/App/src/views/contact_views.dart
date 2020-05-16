import 'dart:io';

import 'package:agenda_contatos/App/src/models/contact_models.dart';
import 'package:flutter/material.dart';

class ContactViews extends StatefulWidget {
  final Contact contact;

  ContactViews({this.contact});
  @override
  _ContactViewsState createState() => _ContactViewsState();
}

class _ContactViewsState extends State<ContactViews> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocus = FocusNode();

  bool userEdited = false;

  Contact editedContact;

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      editedContact = Contact();
    } else {
      editedContact = Contact.fromMap(widget.contact.toMap());

      nameController.text = editedContact.name;
      emailController.text = editedContact.email;
      phoneController.text = editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: requestPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Container(
                width: 200,
                height: 50,
                child: FittedBox(
                  child: Text(
                    editedContact.name ?? 'Novo Contato',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: 170,
                          height: 170,
                          child: CircleAvatar(
                            child: editedContact.img != null
                                ? FileImage(
                                    File(
                                      editedContact.img,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/icons8.png',
                                    scale: 0.8,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          child: TextField(
                            focusNode: nameFocus,
                            controller: nameController,
                            onChanged: (text) {
                              userEdited = true;
                              setState(() {
                                editedContact.name = text;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                color: Colors.brown,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(color: Colors.brown, fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              userEdited = true;

                              editedContact.email = text;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.brown),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(color: Colors.brown, fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          child: TextField(
                            controller: phoneController,
                            onChanged: (text) {
                              userEdited = true;

                              editedContact.phone = text;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Telefone',
                              labelStyle: TextStyle(color: Colors.brown),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                            ),
                            style: TextStyle(color: Colors.brown, fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            if (editedContact.name != null && editedContact.name.isNotEmpty) {
              Navigator.pop(context, editedContact);
            } else {
              FocusScope.of(context).requestFocus(nameFocus);
            }
          },
          child: Icon(
            Icons.save,
            size: 30,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  Future<bool> requestPop() {
    if (userEdited) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Decartar Alterações'),
            content: Text('Caso saia, as alterações serão perdidas.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Sim'),
              ),
            ],
          );
        },
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
