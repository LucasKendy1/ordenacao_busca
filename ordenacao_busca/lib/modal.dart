// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  final nome;
  final sobrenome;
  final telefone;
  VoidCallback onSave;
  VoidCallback onCancel;

  Modal({
    super.key,
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color(0xFF26408B),
        content: Container(
          height: 315,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Adicionar contato",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: nome,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nome",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: sobrenome,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Sobrenome",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: telefone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Telefone",
                ),
              ),
              Container(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: Text("Salvar"),
                      onPressed: () {
                        onSave();
                      }),
                  ElevatedButton(
                      child: Text("Cancelar"),
                      onPressed: () {
                        onCancel();
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
