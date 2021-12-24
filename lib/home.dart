import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _preco = "0";

  void _recuperarPreco() async {
    Uri url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString().replaceAll(".", ",");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/bitcoin.png'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'R\$ ' + _preco,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              ElevatedButton(
                onPressed: _recuperarPreco,
                child: Text(
                  'Atualizar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
