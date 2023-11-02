import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:supabase_crud_app/app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:supabase_crud_app/app/features/product/presentation/bloc/product_bloc.dart';
import 'package:supabase_crud_app/app/features/product/presentation/pages/add_product_page.dart';
import 'package:supabase_crud_app/shared/usecases/show_snack_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardRepository repository = DashboardRepository();
  ProductBloc productBloc = ProductBloc();
  // DashboardBloc dashboardBloc = DashboardBloc();
  @override
  void initState() {
    productBloc.add(ProductInitialState());
    //dashboardBloc.add(FetchAllProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardBloc = context.read<DashboardBloc>();
    final productBloc = context.read<ProductBloc>();
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
                  child: BlocConsumer<DashboardBloc, DashboardState>(
                    listener: (context, state) {},
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            print(product.id);
                                          },
                                          icon:
                                              const Icon(Icons.edit_note_sharp),
                                        ),
                                        IconButton(
                                          onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                BlocBuilder<ProductBloc,
                                                    ProductState>(
                                              builder: (context, state) {
                                                if (state is ProductLoading) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Deletar produto'),
                                                  content: Text(
                                                    '${product.name} vai ser apagado, deseja continuar?',
                                                    style: GoogleFonts.nunito(),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: const Text(
                                                          'Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        productBloc.add(
                                                          DeleteProductEvent(
                                                              product: product),
                                                        );
                                                        dashboardBloc.add(
                                                          RemoveProduct(
                                                            product: product,
                                                          ),
                                                        );
                                                        showMessageSnackBar(
                                                          context,
                                                          'Produto deletado com sucesso!',
                                                          color: Colors.red,
                                                        );

                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const DashboardPage(),
                                                          ),
                                                        );
                                                        /* Timer(
                                                                                                                  const Duration(
                                                                                                                      seconds: 5),
                                                                                                                  () {},
                                                                                                                ); */
                                                      },
                                                      child:
                                                          const Text('Deletar'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
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
