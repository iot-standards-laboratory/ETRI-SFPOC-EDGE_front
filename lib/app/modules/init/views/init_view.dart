import 'package:flutter/material.dart';
import 'package:front/app/components/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class InitView extends StatelessWidget {
  InitView({super.key});
  var mqttAddr = '';
  final formKey = GlobalKey<FormState>();

  Widget renderBody(BuildContext context, {required double maxWidth}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            const Icon(Icons.android, size: 120),
            if (!Responsive.isMobile(context)) const SizedBox(height: 10),
            Text(
              'ETRI Smart Greenhouse',
              style: GoogleFonts.bebasNeue(
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome our smart greenhouse service',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'MQTT Address',
                      border: InputBorder.none,
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'MQTT Address는 필수사항입니다.';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      mqttAddr = val!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (ctx, ctis) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: ctis.maxWidth >= 700
                      ? renderBody(context, maxWidth: 700)
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: renderBody(
                            context,
                            maxWidth: ctis.maxWidth,
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
