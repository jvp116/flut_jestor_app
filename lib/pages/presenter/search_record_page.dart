// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchRecordPage extends StatefulWidget {
  const SearchRecordPage({super.key});

  @override
  State<SearchRecordPage> createState() => _SearchRecordPageState();
}

class _SearchRecordPageState extends State<SearchRecordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blue,
          elevation: 0,
          title: const Text(
            'Lançamentos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SearchBar(
            // controller: controller,
            leading: const Icon(Icons.search_rounded, color: blue),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
            hintText: 'Pesquisar por descrição',
            hintStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
            padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
            onChanged: (_) {},
          ),
        ));
  }
}
