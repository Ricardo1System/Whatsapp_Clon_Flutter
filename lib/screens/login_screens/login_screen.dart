import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:whatsapp_clone/blocs/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc authBloc;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool setCode=false;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    setCode=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: !setCode? Form(
          key: _formKey,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 300.0),
              child: Column(
                children: [
                  const Text(
                'Tu número de teléfono',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const Text(
                'Por favor, confirma el código de tu pais y pon tu número de teléfono.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: PhoneNumberInputForm(controller: _numberController)),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final phoneNumber = _numberController.text;
                        authBloc.add(SendCode(number: phoneNumber));
                      }
                      setState(() {
                        setCode=!setCode;
                      });
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ):Form(
          key: _formKey,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 300.0),
              child: Column(
                children: [
                  const Text(
                'Confirmar Código',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const Text(
                'Por favor, ingresa el código generado.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: CodeInputForm(controller: _codeController)),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final code = _codeController.text;
                        authBloc.add(SetCode(smsCode: code));
                      }
                      setState(() {
                        // setCode=!setCode;
                      });
                    },
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNumberInputForm extends StatefulWidget {
  final TextEditingController controller;
  PhoneNumberInputForm({required this.controller});
  @override
  _PhoneNumberInputFormState createState() => _PhoneNumberInputFormState();
}

class _PhoneNumberInputFormState extends State<PhoneNumberInputForm> {
  var maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####', // Define el formato del número telefónico
    filter: {"#": RegExp(r'[0-9]')}, // Define qué caracteres son permitidos
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Número de teléfono',
        hintText: 'Ejemplo: (123) 456-7890',
        // Puedes personalizar más el InputDecoration según tus necesidades
      ),
      validator: (value) {
        // Aquí puedes realizar validaciones adicionales si es necesario
        if (value == '' || value == null) {
          return 'Por favor, ingresa un número de teléfono';
        }
        // Puedes agregar más validaciones según tus necesidades
        return null;
      },
    );
  }
}

class CodeInputForm extends StatefulWidget {
  final TextEditingController controller;
  CodeInputForm({required this.controller});
  @override
  _CodeInputFormState createState() => _CodeInputFormState();
}

class _CodeInputFormState extends State<CodeInputForm> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Ingresa el Codigo',
      ),
      validator: (value) {
        if (value == '' || value == null) {
          return 'Por favor, ingresa el código enviado';
        }
        return null;
      },
    );
  }
}
