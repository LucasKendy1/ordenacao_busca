// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ordenacao_busca/contato.dart';

class CardContato extends StatelessWidget {
  Contato contato;
  CardContato({super.key, required this.contato});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 5, right: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(
                    Icons.person,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(contato.nome + " ",
                            style: TextStyle(fontSize: 18)),
                        Text(contato.sobrenome, style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Text(contato.telefone)
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
