class Usuario {
  late String _idUsuario;
  late String _nome;
  late String _email;
  late String _senha;
  late String _cpf;
  late String _DataNascimento;

  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "nome": this.nome,
      "email": this.email,
      "cpf": this._cpf,
      "DataNascimento": this._DataNascimento
    };
    return map;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get dataNascimento => _cpf;

  set dataNascimento(String value) {
    _cpf = value;
  }
}
