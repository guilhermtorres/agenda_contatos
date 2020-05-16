import 'package:agenda_contatos/App/src/models/contact_models.dart';
import 'package:flutter/material.dart';

class ContactViews extends StatefulWidget {
  final Contact contact;

  ContactViews({this.contact});
  @override
  _ContactViewsState createState() => _ContactViewsState();
}

class _ContactViewsState extends State<ContactViews> {
  Contact editedContact;

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      editedContact = Contact();
    } else {
      editedContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              width: 50,
            ),
            Text(
              editedContact.name ?? 'Novo Contato',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
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
                          child: Image.asset(
                            'assets/images/icons8.png',
                            scale: 0.8,
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
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(
                              color: Colors.brown,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          style: TextStyle(color: Colors.brown, fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.brown),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          style: TextStyle(color: Colors.brown, fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 60,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Telefone',
                            labelStyle: TextStyle(color: Colors.brown),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                          style: TextStyle(color: Colors.brown, fontSize: 24, fontWeight: FontWeight.bold),
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
        onPressed: () {},
        child: Icon(
          Icons.save,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
