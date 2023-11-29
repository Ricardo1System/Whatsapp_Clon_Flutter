import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme=Provider.of<ThemeChange>(context).currenttheme;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                'assets/images/community.jpg',
                height: 380,
                scale: 1.0,
                width: 420,
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Usa una comunidad para mantenerte en contacto',
                textAlign: TextAlign.center,
                style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface, fontSize: 20),
                    ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text:
                          'Las comunidades reúnen a los miembros en grupos por temas y facilitan la recepción de avisos de los administradores. Cualquier comunidad a la que te añadan aparecerá aquí.',
                      style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Más información',
                            style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface, fontWeight: FontWeight.bold),
                            ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FlipInY(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Iniciar tu comunidad')),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
