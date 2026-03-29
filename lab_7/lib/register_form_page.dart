import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  // focus nodes
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmPassFocus = FocusNode();

  // password visibility flags
  bool _hidePass = true;
  bool _hideConfirmPass = true;

  @override
  void dispose() {
    // dispose all controllers and focus nodes
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _confirmPassFocus.dispose();
    super.dispose();
  }

  // focus change helper
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // email validator
  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  // password validator
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return '6 characters required for password';
    }
    return null;
  }

  // confirm password validator
  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passController.text) {
      return 'Password does not match';
    }
    return null;
  }

  // form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Form is valid');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoPage(
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
          ),
        ),
      );
    } else {
      print('Form is not valid! Please review and correct');
    }
  }

  // reusable border
  OutlineInputBorder _enabledBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.black, width: 2.0),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    );
  }

  OutlineInputBorder _errorBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // ── Full Name
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What do people call you?',
                prefixIcon: const Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _errorBorder(),
              ),
              // validator
              validator: (val) => val!.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 10),

            // ── Phone Number
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _emailFocus);
              },
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              // restrict to digits only
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'Where can we reach you?',
                helperText: 'Phone format: (XXX)XXX-XXXX',
                prefixIcon: const Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _phoneController.clear();
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _errorBorder(),
              ),
              validator: (val) =>
                  val!.isEmpty ? 'Phone number is required' : null,
            ),
            const SizedBox(height: 10),

            // ── Email Address
            TextFormField(
              focusNode: _emailFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _emailFocus, _passFocus);
              },
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _emailController.clear();
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _errorBorder(),
              ),
              validator: (val) => _validateEmail(val!),
            ),
            const SizedBox(height: 10),

            // ── Password
            TextFormField(
              focusNode: _passFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _passFocus, _confirmPassFocus);
              },
              controller: _passController,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Enter the password',
                prefixIcon: const Icon(Icons.security),
                // toggle icon button
                suffixIcon: IconButton(
                  icon: Icon(
                      _hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _errorBorder(),
              ),
              validator: (val) => _validatePassword(val!),
            ),
            const SizedBox(height: 10),

            // ── Confirm Password 
            TextFormField(
              focusNode: _confirmPassFocus,
              controller: _confirmPassController,
              obscureText: _hideConfirmPass,
              decoration: InputDecoration(
                labelText: 'Confirm Password *',
                hintText: 'Re-enter the password',
                prefixIcon: const Icon(Icons.edit),
                suffixIcon: IconButton(
                  icon: Icon(_hideConfirmPass
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hideConfirmPass = !_hideConfirmPass;
                    });
                  },
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _errorBorder(),
              ),
              validator: (val) => _validateConfirmPassword(val!),
            ),
            const SizedBox(height: 20),

            // ── Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit Form',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
