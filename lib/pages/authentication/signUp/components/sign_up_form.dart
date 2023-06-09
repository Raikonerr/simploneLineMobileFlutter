import 'package:flutter/material.dart';
import 'package:simplone_final/services/authentications.dart';
import 'package:simplone_final/services/firebase.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../../components/buttons/primary_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;

  FocusNode? _emaildNode;
  FocusNode? _passwordNode;
  FocusNode? _conformPasswordNode;

  String? _fullName, _email, _password, _conformPassword;
  // var auth = Authentications();
  @override
  void initState() {
    super.initState();
    _passwordNode = FocusNode();
    _emaildNode = FocusNode();
    _conformPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordNode!.dispose();
    _emaildNode!.dispose();
    _conformPasswordNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            validator: requiredValidator,
            onSaved: (value) => _fullName = value,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              // Once user click on Next then it go to email field
              _emaildNode!.requestFocus();
            },
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Votre Nom d'utilisateur",
              contentPadding: kTextFieldPadding,
            ),
          ),
          VerticalSpacing(),

          // email
          TextFormField(
            focusNode: _emaildNode,
            validator: emailValidator,
            onSaved: (value) => _email = value,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              // Once user click on Next then it go to password field
              _passwordNode!.requestFocus();
            },
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Votre Email",
              contentPadding: kTextFieldPadding,
            ),
          ),
          VerticalSpacing(),
          // Password Field
          TextFormField(
            focusNode: _passwordNode,
            obscureText: _obscureText,

            // validator: passwordValidator,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => _conformPasswordNode!.requestFocus(),
            // We need to validate our password
            onChanged: (value) => _password = value,
            onSaved: (value) => _password = value,
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Votre Mot de passe",
              contentPadding: kTextFieldPadding,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: kBodyTextColor)
                    : const Icon(Icons.visibility, color: kBodyTextColor),
              ),
            ),
          ),
          VerticalSpacing(),

          // Confirm Password Field
          TextFormField(
            focusNode: _conformPasswordNode,
            obscureText: _obscureText,
            validator: (value) =>
                matchValidator.validateMatch(value!, _password!),
            onSaved: (value) => _conformPassword = value,
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Confirmer votre mot de passe",
              contentPadding: kTextFieldPadding,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: kBodyTextColor)
                    : const Icon(Icons.visibility, color: kBodyTextColor),
              ),
            ),
          ),
          VerticalSpacing(),
          // Sign Up Button
          PrimaryButton(
            text: "S'inscrire",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // auth.signup(
                //     _email, _password, context, _fullName, _phoneNumber);
              } else {
                setState(() {
                  _autoValidate = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
