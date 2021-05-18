import 'package:mobx/mobx.dart';
import 'package:mobx_flutter/controllers/item_controller.dart';

part 'principal_controller.g.dart';

class PrincipalController = PrincipalControllerBase with _$PrincipalController;

abstract class PrincipalControllerBase with Store {
  @observable
  String novoItem = "";

  @action
  void setNovoItem(String valor) => novoItem = valor;

  ObservableList<ItemController> listaItens = ObservableList<ItemController>();

  @action
  void adicionarItem() {
    listaItens.add(ItemController(novoItem));
  }
}
