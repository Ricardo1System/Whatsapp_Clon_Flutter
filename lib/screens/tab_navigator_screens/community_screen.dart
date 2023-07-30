import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/classic_theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                'assets/images/community.jpg',
                height: 380,
                width: 420,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Usa una comunidad para mantenerte en contacto',
                    ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text:
                          'Las comunidades reúnen a los miembros en grupos por temas y facilitan la recepción de avisos de los administradores. Cualquier comunidad a la que te añadan aparecerá aquí.',
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Más información',
                            ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Iniciar tu comunidad')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
