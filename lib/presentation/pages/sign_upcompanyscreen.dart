import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/presentation/controllers/signup_controller.dart';
import 'package:image_picker/image_picker.dart';

class SignUpCompanyScreen extends StatefulWidget {
  @override
  _SignUpCompanyScreenState createState() => _SignUpCompanyScreenState();
}

class _SignUpCompanyScreenState extends State<SignUpCompanyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _companyWebsiteController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();

  bool _companyUnderConstruction = false;
  final SignUpController _signUpController = SignUpController();

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  void resetFields() {
    _companyNameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _taxNumberController.clear();
    _companyWebsiteController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _streetController.clear();
    _cityController.clear();
    _postCodeController.clear();

    setState(() {
      _companyUnderConstruction = false;
    });
  }

  Future<void> _selectAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Envoi de l'image sélectionnée au serveur
      File image = File(pickedFile.path);
      // _registerAccountWithImage(image);
    } else {
      print('Aucune image sélectionnée.');
    }
  }

  // Future<void> _registerAccountWithImage(File image) async {
  //   if (_formKey.currentState!.validate()) {
  //     String companyName = _companyNameController.text;
  //     var payload = {
  //       "name": _companyNameController.text,
  //       "phone": _phoneNumberController.text,
  //       "email": _emailController.text,
  //       "password": _passwordController.text,
  //       "role": 'provider-intern',
  //       "website": _companyWebsiteController.text,
  //       "street": _streetController.text,
  //       "city": _cityController.text,
  //       "post_code": _postCodeController.text,
  //       "taxNumber": _taxNumberController.text,
  //       "companyUnderConstruction": _companyUnderConstruction,
  //     };
  //     _signUpController.registerAccountWithJson(payload).then((_) {
  //       print('Compte créé avec succès pour $companyName');
  //     }).catchError((error) {
  //       print('Erreur lors de la création du compte: $error');
  //     });
  //   } else {
  //     print(
  //         'Erreur: Impossible de créer le compte. Veuillez remplir tous les champs.');
  //   }
  // }

  // void _registerAccount() {
  //   if (_formKey.currentState!.validate()) {
  //     String companyName = _companyNameController.text;
  //     var payload = {
  //       "name": _companyNameController.text,
  //       "phone": _phoneNumberController.text,
  //       "email": _emailController.text,
  //       "password": _passwordController.text,
  //       "role": 'provider-intern',
  //       "website": _companyWebsiteController.text,
  //       "street": _streetController.text,
  //       "city": _cityController.text,
  //       "post_code": _postCodeController.text,
  //       "taxNumber": _taxNumberController.text,
  //       "companyUnderConstruction": _companyUnderConstruction,
  //     };
  //     _signUpController.registerAccountWithJson(payload).then((_) {
  //       print('Compte créé avec succès pour $companyName');
  //     }).catchError((error) {
  //       print('Erreur lors de la création du compte: $error');
  //     });
  //   } else {
  //     print(
  //         'Erreur: Impossible de créer le compte. Veuillez remplir tous les champs.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Créer un compte entreprise',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              // Implement image selection and upload logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(
                  labelText: 'Nom de l\'entreprise',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le nom de l\'entreprise';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  if (value.length < 8) {
                    return 'Le numéro de téléphone doit avoir au moins 8 chiffres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre adresse email';
                  }
                  if (!RegExp(
                          r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                      .hasMatch(value)) {
                    return 'Veuillez entrer une adresse email valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Ville',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _postCodeController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Code Postale',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre code postale';
                  }
                  if (value.length < 4) {
                    return 'Le code postale doit avoir au moins 4 chiffres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _taxNumberController,
                decoration: InputDecoration(
                  labelText: 'Matricule fiscale de l\'entreprise',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _companyWebsiteController,
                decoration: InputDecoration(
                  labelText: 'Lien du compte de l\'entreprise',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    'L\'entreprise est en construction?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: _companyUnderConstruction,
                    onChanged: (value) {
                      setState(() {
                        _companyUnderConstruction = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    onPressed: togglePasswordVisibility,
                    icon: Icon(obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                obscureText: obscurePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit avoir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    onPressed: toggleConfirmPasswordVisibility,
                    icon: Icon(obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                obscureText: obscureConfirmPassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez confirmer votre mot de passe';
                  }
                  if (value != _passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // _registerAccount();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Créer le compte',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpCompanyScreen(),
  ));
}
