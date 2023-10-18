import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rpgtracker_app/data/details/coc/ammo.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/ui/inputs.dart';

class CoCAmmoDetailScreenArgs {
  CoCAmmoDTO ammo;

  CoCAmmoDetailScreenArgs(this.ammo);
}

class CoCAmmoDetailScreen extends StatefulWidget {
  const CoCAmmoDetailScreen({super.key});

  @override
  State<CoCAmmoDetailScreen> createState() => _CoCAmmoDetailScreenState();
}

class _CoCAmmoDetailScreenState extends State<CoCAmmoDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CoCAmmoDetailScreenArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'listings:coc.ammo.title'.translate(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomInput(
                      name: 'name',
                      required: true,
                      initialValue: args.ammo.name,
                      label: 'listings:coc.ammo.form.mappings.name.label'
                          .translate(context),
                      requiredText:
                          'listings:coc.ammo.form.mappings.name.notNullMessage'
                              .translate(context),
                    ),
                    CustomInput(
                      name: 'roundsShotWithEach',
                      required: true,
                      initialValue: args.ammo.roundsShotWithEach?.toString(),
                      keyboardType: TextInputType.number,
                      label: 'listings:coc.ammo.form.mappings.roundsShot.label'
                          .translate(context),
                      requiredText:
                          'listings:coc.ammo.form.mappings.roundsShot.notNullMessage'
                              .translate(context),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          debugPrint(
                              _formKey.currentState?.instantValue.toString());
                        }
                      },
                      child: Text('general:buttons.save'.translate(context)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
