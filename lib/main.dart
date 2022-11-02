import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Matriz de Fibonacci',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Scaffold(body: MatrizBody()));
  }
}

class MatrizBody extends StatefulWidget {
  const MatrizBody({Key? key}) : super(key: key);

  @override
  State<MatrizBody> createState() => _MatrizBodyState();
}

class _MatrizBodyState extends State<MatrizBody> {
  late List<int> listaFibonacci;
  var matriz = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];
  int nInicial = 0;
  int nFimal = 0;
  int sumaMatriz = 0;
  TextEditingController initalNumberControler = TextEditingController();
  TextEditingController finalNumberControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double spaceHeight = 30.00;
    final _formKey = GlobalKey<FormState>();
    FocusNode focusFinal = FocusNode();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Matriz de Fibonacci",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: spaceHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(matriz[0][0].toString()),
                Text(matriz[0][1].toString()),
                Text(matriz[0][2].toString()),
              ],
            ),
            SizedBox(
              height: spaceHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(matriz[1][0].toString()),
                Text(matriz[1][1].toString()),
                Text(matriz[1][2].toString()),
              ],
            ),
            SizedBox(
              height: spaceHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(matriz[2][0].toString()),
                Text(matriz[2][1].toString()),
                Text(matriz[2][2].toString()),
              ],
            ),
            SizedBox(
              height: spaceHeight,
            ),
            Text(
              "Suma de matriz: $sumaMatriz",
            ),
            SizedBox(
              height: spaceHeight,
            ),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Elemento Inicial: "),
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          showSnapError('Numero inicial es requerido');
                          return "";
                        }
                        return null;
                      },
                      controller: initalNumberControler,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      onEditingComplete: () {
                        focusFinal.requestFocus();
                      },
                    ),
                  ),
                  const Text("Elemento Final: "),
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          showSnapError('Numero final es requerido');
                          return "";
                        }
                        return null;
                      },
                      focusNode: focusFinal,
                      controller: finalNumberControler,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: spaceHeight,
            ),
            Container(
              width: size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    generateFibonacci(
                        int.parse(initalNumberControler.value.text),
                        int.parse(finalNumberControler.value.text));
                  }
                },
                child: const Text("Generar Matriz"),
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  rotarMatriz();
                },
                child: const Text("Rotar a la derecha"),
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  limpiarDatos();
                },
                child: const Text("Limpiar matriz"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  generateFibonacci(int numInicial, int numFinal) {
    nInicial = numInicial;
    nFimal = numFinal;
    if (numFinal < numInicial) {
      showSnapError("Numero Final debe ser mayor a numero inicial");
      return;
    }
    listaFibonacci = [];

    int numero = 0;
    listaFibonacci.add(numero);
    numero = 1;
    listaFibonacci.add(numero);
    for (int i = 0; i <= numFinal; i++) {
      var indice = listaFibonacci.length;
      numero = listaFibonacci[indice - 2] + listaFibonacci[indice - 1];
      listaFibonacci.add(numero);
      if (numero > nFimal && listaFibonacci.length > 9) {
        break;
      }
    }
    print(listaFibonacci);
    getMatriz3by3();
  }

  List<int> rango = [];

  getMatriz3by3() {
    rango = [];
    var posicion = 0;
    for (var item in listaFibonacci) {
      if (item >= nInicial && item <= nFimal) {
        rango.add(item);
      }
    }
    if (kDebugMode) {
      print(rango);
      print(rango.length);
    }
    if (rango.length < 9) {
      for (var i = 0; i < 9; i++) {
        var numero = 0;
        if (rango.length == 1) {
          var posicion = listaFibonacci.indexOf(rango[0]);
          numero = listaFibonacci[posicion - 1] + rango[rango.length - 1];
        } else {
          numero = rango[rango.length - 2] + rango[rango.length - 1];
        }
        rango.add(numero);
        if (rango.length == 9) {
          break;
        }
      }
      setState(() {});
    }
    showMatriz();
    if (kDebugMode) {
      print(rango);
      print(rango.length);
    }

    if (rango.length > 9) {
      showSnapError("Rango sobrepasa cantidad maxima de la matriz");
      return;
    }
  }

  showMatriz() {
    sumaMatriz = 0;
    var contador = 0;
    for (var x = 0; x < 3; x++) {
      for (var y = 0; y < 3; y++) {
        matriz[x][y] = rango[contador];
        sumaMatriz = sumaMatriz + rango[contador];
        contador++;
      }
    }
  }

  rotarMatriz() {
    var rotado = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
    var inverter = 2;
    for (var x = 0; x < matriz.length; x++) {
      for (var y = 0; y < matriz[0].length; y++) {
        rotado[y][inverter] = matriz[x][y];
      }
      inverter--;
    }
    matriz = rotado;
    setState(() {});
    print(rotado);
  }

  limpiarDatos() {
    sumaMatriz = 0;
    matriz = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
    initalNumberControler.clear();
    finalNumberControler.clear();
    setState(() {});
  }

  showSnapError(String text) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ojo. algo salio mal.'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Salir'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}
