class Pessoa {
  String _nome = "";
  String _peso = "";
  String _altura = "";
  String _genero = "";

  void setNome(String nome) {
    _nome = nome;
  }

  String getNome() {
    return _nome;
  }

  void setPeso(String peso) {
    _peso = peso;
  }

  String getPeso(String peso) {
    return _peso;
  }

  void setAltura(String altura) {
    _altura = altura;
  }

  String getAltura(String altura) {
    return _altura;
  }

  void setGenero(String genero) {
    _genero = genero;
  }

  String getGenero(String genero) {
    return _genero;
  }

  Pessoa(
      {required String nome,
      required String peso,
      required String altura,
      required String genero}) {
    _nome = nome;
    _peso = peso;
    _altura = altura;
    _genero = genero;
  }

  @override
  String toString() {
    return {
      "nome": _nome,
      "peso": _peso,
      "altura": _altura,
      "genero": _genero,
    }.toString();
  }
}
