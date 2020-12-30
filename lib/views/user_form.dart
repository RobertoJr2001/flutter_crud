import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final User user = ModalRoute.of(context).settings.arguments;

    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate;
              if (isValid) {
                _form.currentState.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Digite um nome!';
                  }

                  if (value.trim().length < 3) {
                    return 'O nome precisa de no mínimo 3 letras.';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData['email'] = value),
              TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                  onSaved: (value) => value == null
                      ? {
                          _formData['avatarUrl'] == null
                              ? _formData['avatarUrl'] =
                                  "https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_960_720.png"
                              : _formData['avatarUrl'] = value,
                        }
                      : _formData['avatarUrl'] = value),
            ],
          ),
        ),
      ),
    );
  }
}
