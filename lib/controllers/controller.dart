import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  ControllerBase() {
    autorun((_) {
      print(email);
      print(senha);
      print(formularioValidado);
    });
  }
  @observable
  int contador = 0;

  @action
  increment() {
    contador++;
  }

  @observable
  String email = '';

  @observable
  String senha = '';

  @observable
  bool usuarioLogado = false;

  @observable
  bool carregando = false;

  @computed
  String get emailSenha => "$email - $senha";

  @computed
  bool get formularioValidado => email.length > 5 && senha.length > 5;

  @action
  void setEmail(valor) => email = valor;

  @action
  void setSenha(valor) => senha = valor;

  @action
  Future<void> logar() async {
    carregando = true;
    //Processamento
    await Future.delayed(Duration(seconds: 3));

    carregando = false;
    usuarioLogado = true;
  }
  // var _contador = Observable(0);

  // Action? increment;

  // Controller(){
  //   increment = Action(_incrementing);
  // }

  // int get contador => _contador.value;
  // set contador(int novoValor) => _contador.value = novoValor;

  // _incrementing(){
  //   contador ++;
  //   print(contador);
  // }

}
