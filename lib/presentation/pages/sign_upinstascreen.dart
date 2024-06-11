import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/presentation/controllers/signup_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class SignUpInstaScreen extends StatefulWidget {
  @override
  _SignUpInstaScreenState createState() => _SignUpInstaScreenState();
}

class _SignUpInstaScreenState extends State<SignUpInstaScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true, obscureConfirmPassword = true;
  bool _companyUnderConstruction = false;
  File? _image;

  final _signUpController = SignUpController();

  final Map<String, TextEditingController> _controllers = {
    'nomInstagrammeur': TextEditingController(),
    'email': TextEditingController(),
    'numeroTelephone': TextEditingController(),
    'matriculeFiscale': TextEditingController(),
    'lienInstagram': TextEditingController(),
    'motDePasse': TextEditingController(),
    'confirmMotDePasse': TextEditingController(),
    'street': TextEditingController(),
    'city': TextEditingController(),
    'postCode': TextEditingController(),
    'cin': TextEditingController(),
    'companyName': TextEditingController(),
  };

  void togglePasswordVisibility() =>
      setState(() => obscurePassword = !obscurePassword);
  void toggleConfirmPasswordVisibility() =>
      setState(() => obscureConfirmPassword = !obscureConfirmPassword);
  void resetFields() =>
      _controllers.forEach((_, controller) => controller.clear());

  Future<void> _selectAndUploadImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

Future<void> _registerAccountWithImage() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        print('Veuillez sélectionner une image.');
        return;
      }

      final uri =
          Uri.parse('http://192.168.100.12:8000/api/register'); // Replace with your API endpoint
      final request = http.MultipartRequest('POST', uri);

      // Add form fields
      request.fields['name'] = _controllers['nomInstagrammeur']!.text;
      request.fields['phone'] = _controllers['numeroTelephone']!.text;
      request.fields['email'] = _controllers['email']!.text;
      request.fields['password'] = _controllers['motDePasse']!.text;
      request.fields['role'] = 'provider-intern';
      request.fields['accountLink'] = _controllers['lienInstagram']!.text;
      request.fields['street'] = _controllers['street']!.text;
      request.fields['city'] = _controllers['city']!.text;
      request.fields['post_code'] = _controllers['postCode']!.text;
      request.fields['CIN'] = _controllers['cin']!.text;
      request.fields['taxNumber'] = _controllers['matriculeFiscale']!.text;
      request.fields['companyName'] = _controllers['companyName']!.text;
      request.fields['companyUnderConstruction'] =
          _companyUnderConstruction.toString();

      // Add image file
      final imageFile = await http.MultipartFile.fromPath(
        'image', // This is the name of the field in the request
        _image!.path,
        filename: path.basename(_image!.path),
      );
      request.files.add(imageFile);

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          print(
              'Compte créé avec succès pour ${_controllers['nomInstagrammeur']!.text}');
        } else {
          print(
              'Erreur lors de la création du compte: ${response.reasonPhrase}');
        }
      } catch (error) {
        print('Erreur lors de la création du compte: $error');
      }
    } else {
      print(
          'Erreur: Impossible de créer le compte. Veuillez remplir tous les champs.');
    }
  }


  Widget buildTextField(String label, String key,
      {TextInputType? keyboardType,
      bool obscureText = false,
      Widget? suffixIcon,
      FormFieldValidator<String>? validator,
      List<TextInputFormatter>? inputFormatters}) {
    return CustomTextField(
      controller: _controllers[key]!,
      labelText: label,
      keyboardType: keyboardType,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: Icon(Icons.add_a_photo), onPressed: _selectAndUploadImage)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              buildTextField('Nom Instagrammeur', 'nomInstagrammeur'),
              SizedBox(height: 10.0),
              buildTextField('Numéro de téléphone', 'numeroTelephone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              SizedBox(height: 10.0),
              buildTextField('CIN', 'cin',
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez entrer votre CIN'
                      : (value.length < 8
                          ? 'Le CIN doit avoir au moins 8 chiffres'
                          : null),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              SizedBox(height: 10.0),
              buildTextField('Email', 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez entrer votre adresse email'
                      : (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                              .hasMatch(value)
                          ? 'Veuillez entrer une adresse email valide'
                          : null)),
              SizedBox(height: 10.0),
              buildTextField('Adresse', 'street'),
              SizedBox(height: 10.0),
              buildTextField('Ville', 'city'),
              SizedBox(height: 10.0),
              buildTextField('Code Postale', 'postCode',
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez entrer votre code postale'
                      : (value.length < 4
                          ? 'Le code postale doit avoir au moins 4 chiffres'
                          : null),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              SizedBox(height: 10.0),
              buildTextField('Lien du compte Instagram', 'lienInstagram'),
              SizedBox(height: 10.0),
              buildTextField('Nom de l\'entreprise', 'companyName'),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text('L\'entreprise est en construction?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Checkbox(
                      value: _companyUnderConstruction,
                      onChanged: (value) =>
                          setState(() => _companyUnderConstruction = value!)),
                ],
              ),
              SizedBox(height: 10.0),
              buildTextField('Mot de passe', 'motDePasse',
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                      icon: Icon(obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: togglePasswordVisibility),
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez entrer un mot de passe'
                      : (value.length < 6
                          ? 'Le mot de passe doit avoir au moins 6 caractères'
                          : null)),
              SizedBox(height: 10.0),
              buildTextField('Confirmer le mot de passe', 'confirmMotDePasse',
                  obscureText: obscureConfirmPassword,
                  suffixIcon: IconButton(
                      icon: Icon(obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: toggleConfirmPasswordVisibility),
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez confirmer votre mot de passe'
                      : (value != _controllers['motDePasse']!.text
                          ? 'Les mots de passe ne correspondent pas'
                          : null)),
              SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed: _registerAccountWithImage,
                  child: Text('Créer le compte')),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: validator,
    );
  }
}

void main() {
  runApp(MaterialApp(home: SignUpInstaScreen()));
}
