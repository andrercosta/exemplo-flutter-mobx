import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_flutter/screens/principal.dart';
import 'package:provider/provider.dart';

import '../controllers/controller.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Controller? controller;
  ReactionDisposer? reactionDisposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<Controller>(context);
    reactionDisposer =
        reaction((_) => controller?.usuarioLogado, (usuarioLogado) {
      if (usuarioLogado as bool) {
        if (usuarioLogado) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => Principal()));
        }
      }
    });
  }

  @override
  void dispose() {
    reactionDisposer?.reaction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(labelText: "Email"),
                onChanged: controller?.setEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(labelText: "Senha"),
                onChanged: controller?.setSenha,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Observer(builder: (_) {
                return Text(controller!.formularioValidado
                    ? "Validado"
                    : '* Campos não validados');
              }),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: Observer(builder: (_) {
                  return ElevatedButton(
                    child: controller!.carregando
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text("Logar"),
                    onPressed: controller!.formularioValidado
                        ? () {
                            controller!.logar();
                          }
                        : null,
                  );
                })),
            //   Text(
            //     'You have pushed the button this many times:',
            //   ),
            //  Observer(builder: (_){
            //    return  Text(
            //     '${controller.contador}',
            //     style: Theme.of(context).textTheme.headline4,
            //   );
            //  },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller!.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
