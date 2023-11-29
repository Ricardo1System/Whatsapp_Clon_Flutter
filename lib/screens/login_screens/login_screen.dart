import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/auth/auth_bloc.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/utils/common_dialog.dart';

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
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SendCodeLoading) {
            showProgress(context);
          }
          if (state is SendCodeLoaded) {
            hideProgress(context);
          }
        },
        child: Stack(
        children: [
          const _BackgroundDecoration(),
          SingleChildScrollView(
            child: !setCode? Form(
              key: _formKey,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 300.0),
                  child: Column(
                    children: [
                      Text(
                    'Tu número de teléfono',
                    style: appTheme.textTheme.bodyLarge!.copyWith(color: appTheme.colorScheme.surface) ,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.05,
                  ),
                  Text(
                    'Por favor, confirma el código de tu pais y pon tu número de teléfono.',
                    textAlign: TextAlign.center,
                    style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface) ,
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
                            _numberController.clear();
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
                      Text(
                    'Confirmar Código',
                    style: appTheme.textTheme.bodyLarge!.copyWith(color: appTheme.colorScheme.surface) ,
                  ),
                  Text(
                    'Por favor, ingresa el código generado.',
                    textAlign: TextAlign.center,
                    style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface) ,
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
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(onPressed: () {
                        setState(() {
                          setCode=false;
                        });
                      }, child: const Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 20,),
                          Text('Corregir número'),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      )
       
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(
          color: appTheme.colorScheme.primary,
          isWrite: false
        ),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
    final Color color;
    final bool isWrite;

  _HeaderWavePainter({super.repaint, required this.color,required this.isWrite,});
  @override
  void paint(Canvas canvas, Size size) {
    
    final lapiz = Paint();

    // Propiedades
    lapiz.color = color;
    // lapiz.color = const Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = Path();
    final path2 = Path();

    // Dibujar con el path y el lapiz
    path.lineTo( 0, size.height * 0.25 );
    path.quadraticBezierTo(size.width , size.height * 0.25, size.width , size.height * 0.25 );
    path.quadraticBezierTo(size.width , size.height * 0.50, size.width, size.height * 0.70 );
    path.lineTo( size.width, size.height * 0.50 );
    
  //   // Dibujar con el path y el lapiz
  //   path2.moveTo ( size.width,  size.height  );
  //   path2.lineTo( 0,  size.height );
  //   path2.quadraticBezierTo(size.width * 0.0, size.height * 0.50, size.width * 0.0, size.height * 0.0 );
  //   path2.quadraticBezierTo(size.width * 0.00, size.height * 0.50, size.width * 0.40, size.height * 0.70 );
  //   path2.quadraticBezierTo(size.width * 0.15, size.height * 0.80, size.width, size.height * 0.90 );
  //   path2.lineTo( size.width, size.height );

  
  // if (!isWrite) {
  //    canvas.drawPath(path2, lapiz );
  // }
    canvas.drawPath(path, lapiz );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return TextFormField(
      controller: widget.controller,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.phone,
      style: TextStyle(color: appTheme.colorScheme.surface),
      decoration:  InputDecoration(
        // fillColor:  appTheme.colorScheme.primary,
        // focusColor: appTheme.colorScheme.primary,
        // hoverColor: appTheme.colorScheme.primary,
        labelText: 'Número de teléfono',
        // hintStyle: TextStyle(color: Colors.blue),
        labelStyle: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface),
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
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      style: TextStyle(color: appTheme.colorScheme.surface),
      decoration: InputDecoration(
        // fillColor:  appTheme.colorScheme.primary,
        // focusColor: appTheme.colorScheme.primary,
        hoverColor: appTheme.colorScheme.primary,
        labelText: 'Ingresa el Codigo',
        labelStyle: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface),
        // prefixIconColor: appTheme.colorScheme.primary,
        // suffixIconColor: appTheme.colorScheme.primary
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
