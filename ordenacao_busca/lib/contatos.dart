// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ordenacao_busca/card_contato.dart';
import 'package:ordenacao_busca/contato.dart';
import 'package:ordenacao_busca/modal.dart';

class Contatos extends StatefulWidget {
  Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  String termoDePesquisa = '';

  final _nome = TextEditingController();
  final _sobrenome = TextEditingController();
  final _telefone = TextEditingController();

  List<Contato> listaDeContatos = [
    Contato(nome: "Daniele", sobrenome: "Fab.", telefone: "123-456-7890"),
    Contato(nome: "Maria", sobrenome: "Eduarda", telefone: "987-654-3210"),
    Contato(nome: "Lucas", sobrenome: "Kendy", telefone: "543-456-1223"),
    Contato(nome: "Pedro", sobrenome: "Barreiro", telefone: "324-6124-3210"),
    Contato(nome: "Anderson", sobrenome: "Silva", telefone: "543-456-1223"),
    Contato(nome: "Andreza", sobrenome: "Domingues", telefone: "324-6124-3210"),
  ];

  void ordenarContatosPorNome(List<Contato> listaDeContatos) {
    int n = listaDeContatos.length;
    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < n; i++) {
        Contato temp = listaDeContatos[i];
        int j = i;
        while (j >= gap &&
            listaDeContatos[j - gap].nome.compareTo(temp.nome) > 0) {
          listaDeContatos[j] = listaDeContatos[j - gap];
          j -= gap;
        }
        listaDeContatos[j] = temp;
      }
    }
  }

  salvarContato() {
    setState(() {
      Contato newContato = Contato(
          nome: _nome.text,
          sobrenome: _sobrenome.text,
          telefone: _telefone.text);
      listaDeContatos.add(newContato);
      _nome.clear();
      _sobrenome.clear();
      _telefone.clear();
    });
    Navigator.of(context).pop();
  }

  void criarContato() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            return Modal(
              nome: _nome,
              telefone: _telefone,
              sobrenome: _sobrenome,
              onSave: salvarContato,
              onCancel: () => Navigator.of(context).pop(),
            );
          });
    });
  }

  Contato? buscaBinaria(List<Contato> lista, String termo) {
    int inicio = 0;
    int fim = lista.length - 1;

    while (inicio <= fim) {
      int meio = (inicio + fim) ~/ 2;
      int comparacao = lista[meio].nome.compareTo(termo);
      int comparacao2 = lista[meio].sobrenome.compareTo(termo);

      if (comparacao == 0 && comparacao2 == 0) {
        return lista[meio]; // Contato encontrado
      } else if (comparacao < 0 && comparacao2 < 0) {
        inicio = meio + 1;  // Contato pode estar no meio acima
      } else {
        fim = meio - 1;     // Contato pode estar no meio abaixo
      }
    }

    return null;            // Contato não encontrado
  }

  @override
  Widget build(BuildContext context) {
    List<Contato> contatosExibidos = listaDeContatos;

    if (termoDePesquisa.isNotEmpty) {
      contatosExibidos = listaDeContatos
          .where((contato) => contato.nome
              .toLowerCase()
              .contains(termoDePesquisa.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de contatos "),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              ordenarContatosPorNome(listaDeContatos);
              setState(() {});
            },
            icon: Icon(Icons.sort_by_alpha),
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        termoDePesquisa = value;
                        buscaBinaria(listaDeContatos, value);
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.search),
                      hintText: "Pesquisar",
                    ),
                  ),
                  Text(
                      termoDePesquisa.isNotEmpty && contatosExibidos.length == 0
                          ? "Nenhum resultado encontrado"
                          : ''),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contatosExibidos.length,
                itemBuilder: (context, index) {
                  return CardContato(contato: contatosExibidos[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          criarContato();
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
