import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String txtInfo = "Insira as informações";

  void resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      txtInfo = 'Insira as informações';
      formKey = GlobalKey<FormState>();
    });
  }

  void _calculo() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        txtInfo = "Abaixo do peso(${imc.toStringAsPrecision(4)})";
      } else if (imc < 24.9) {
        txtInfo = "Peso Ideal(${imc.toStringAsPrecision(4)})";
      } else if (imc < 29.9) {
        txtInfo = "Levemente acima do peso(${imc.toStringAsPrecision(4)})";
      } else if (imc < 34.9) {
        txtInfo = "Obesidade grau I(${imc.toStringAsPrecision(4)})";
      } else if (imc < 39.9) {
        txtInfo = "Obesidade grau II(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        txtInfo = "Obesidade mórbida grau III(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          actions: [
            IconButton(
              onPressed: resetFields,
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        backgroundColor: Color.fromARGB(221, 94, 94, 94),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 200,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: pesoController,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Peso (KG)',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20)),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira seu peso";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: alturaController,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Altura (CM)',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira sua altura.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _calculo();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Text('Calcular'),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 27, 27, 27),
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      txtInfo,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
