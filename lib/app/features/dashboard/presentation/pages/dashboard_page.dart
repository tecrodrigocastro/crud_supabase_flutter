import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/repositories/product_repository.dart';
import 'package:supabase_crud_app/app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:supabase_crud_app/app/features/product/presentation/pages/add_product_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ProductRepository repository = ProductRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardBloc = context.read<DashboardBloc>();
    dashboardBloc.add(FetchAllProducts());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: Text(
          'Lady Dayana',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: RefreshIndicator(
            onRefresh: () async {
              dashboardBloc.add(FetchAllProducts());
            },
            child: Column(
              children: [
                Text(
                  'Sua lista de produtos visiveis no site',
                  style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DashboardLoaded) {
                        return GridView.builder(
                          itemCount: state.products.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 270,
                          ),
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    FadeInImage(
                                      height: 150,
                                      width: double.infinity,
                                      placeholder: const NetworkImage(
                                          'https://www.abge.org.br/loja/img/loading.gif'),
                                      image: NetworkImage(product.image),
                                    ),
                                    /* Image(
                                      //fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 150,
                                      image: NetworkImage(product.image),
                                    ), */
                                    Text(
                                      product.name,
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Preço: R\$ ${double.parse('${product.price}').toStringAsFixed(2)}',
                                      style: GoogleFonts.nunito(
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    Text(
                                      'Tamanho: ${product.size}',
                                      style: GoogleFonts.nunito(
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(150, 35),
                                      ),
                                      onPressed: () {
                                        print(product.id);
                                      },
                                      icon: const Icon(Icons.edit_note_sharp),
                                      label: const Text('Editar'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text('Error'),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddProductPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
