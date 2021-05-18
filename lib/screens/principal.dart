import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_flutter/controllers/principal_controller.dart';
import 'package:provider/provider.dart';

import '../controllers/controller.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  PrincipalController controller = PrincipalController();

  _dialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Adicionar item"),
            content: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Digite uma descrição..."),
              onChanged: controller.setNovoItem,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    controller.adicionarItem();
                    Navigator.pop(context);
                  },
                  child: Text("Salvar"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final controllerHome = Provider.of<Controller>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${controllerHome.email}",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: controller.listaItens.length,
          itemBuilder: (_, indice) {
            var item = controller.listaItens[indice];
            return Observer(
              builder: (_) {
                return ListTile(
                  title: Text(
                    item.titulo,
                    style: TextStyle(
                        decoration:
                            item.marcado ? TextDecoration.lineThrough : null),
                  ),
                  onTap: () {
                    item.marcado = !item.marcado;
                  },
                  leading: Checkbox(
                    value: item.marcado,
                    onChanged: (valor) => item.alterarMarcado,
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
