import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imagemController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: Text(
          'Adicionar Produto',
          style: GoogleFonts.nunito(
            color: Colors.grey.shade800,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome do Produto',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome do Produto obrigatorio';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.pink.shade100,
                        border: InputBorder.none,
                        hintText: 'Bolsa Eco Bag'),
                    style: GoogleFonts.nunito(),
                  ),
                ),
                Text(
                  'Image do Produto',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: imagemController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Image do Produto obrigatorio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.pink.shade100,
                      border: InputBorder.none,
                      hintText: 'Cole aqui a URL da imagem',
                    ),
                    style: GoogleFonts.nunito(),
                  ),
                ),
                Text(
                  'Informações extras',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: priceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preço do Produto obrigatorio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink.shade100,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.attach_money),
                          hintText: 'Preço',
                        ),
                        style: GoogleFonts.nunito(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                        controller: sizeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tamanho do Produto obrigatorio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink.shade100,
                          border: InputBorder.none,
                          hintText: 'Tamanho',
                        ),
                        style: GoogleFonts.nunito(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade100,
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Adicionar produto',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid != true) return;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
