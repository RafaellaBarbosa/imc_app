import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_app/models/pessoa.dart';
import 'package:imc_app/widget/text_form_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isWoman = true;
  bool isMan = false;
  String genero = "";
  TextEditingController idadeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora IMC'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Descura qual é o seu índice de Massa Comporal'),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sexo:'),
                  const SizedBox(width: 30),
                  IconButton.filled(
                    icon: const Icon(Icons.woman_sharp),
                    isSelected: isWoman,
                    onPressed: () {
                      setState(() {
                        isWoman = !isWoman;
                        isMan = !isWoman;
                      });
                    },
                  ),
                  IconButton.filled(
                    icon: const Icon(Icons.man_sharp),
                    isSelected: isMan,
                    onPressed: () {
                      setState(() {
                        isMan = !isMan;
                        isWoman = !isMan;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              ATextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: idadeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não pode ser vazio";
                  }
                  return null;
                },
                labelText: 'Idade',
                hintText: 'Ex:21',
              ),
              const SizedBox(height: 20),
              ATextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: 'Ex:74.5',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não pode ser vazio";
                  }
                  return null;
                },
                controller: pesoController,
                labelText: 'Peso (Kg)',
              ),
              const SizedBox(height: 20),
              ATextFormField(
                labelText: 'Altura (cm)',
                hintText: 'Ex:165 cm',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não pode ser vazio";
                  }
                  return null;
                },
                controller: alturaController,
              ),
              const SizedBox(height: 50),
              SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                      onPressed: () {
                        Pessoa pessoa = Pessoa(
                          nome: "",
                          peso: pesoController.text,
                          altura: alturaController.text,
                          genero: addGenero(isWoman),
                        );
                        if (_formKey.currentState!.validate()) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                Dialog.fullscreen(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    calcularImc(
                                      peso:
                                          double.tryParse(pesoController.text)!,
                                      altura: double.tryParse(
                                          alturaController.text)!,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 36,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('fechar'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text("Calcular"))),
            ],
          ),
        ),
      ),
    );
  }

  String calcularImc({required double peso, required double altura}) {
    double imc = peso / (altura / 100 * altura / 100);

    if (imc < 16) {
      return 'Magreza grave ${imc.toStringAsFixed(2)}';
    } else if (imc < 17) {
      return 'Magreza moderada ${imc.toStringAsFixed(2)}';
    } else if (imc < 18.5) {
      return 'Magreza leve ${imc.toStringAsFixed(2)}';
    } else if (imc < 25) {
      return 'Saudável ${imc.toStringAsFixed(2)}';
    } else if (imc < 30) {
      return 'Sobrepeso ${imc.toStringAsFixed(2)}';
    } else if (imc < 35) {
      return 'Obesidade – GRAU I ${imc.toStringAsFixed(2)}';
    } else if (imc < 40) {
      return 'Obesidade – GRAU II | Severa ${imc.toStringAsFixed(2)}';
    } else {
      return 'Obesidade – GRAU III | Mórbida ${imc.toStringAsFixed(2)}';
    }
  }

  String addGenero(isWoman) {
    switch (isWoman) {
      case true:
        genero = "feminino";
        break;
      case false:
        genero = "masculino";
        break;
      default:
        genero = "null";
    }
    return genero;
  }
}
