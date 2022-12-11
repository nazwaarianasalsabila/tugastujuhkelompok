import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:something/models/barang.dart';
import 'package:something/persediaan_provider.dart';

class Stok extends StatelessWidget {
  const Stok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: Consumer<StokProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.cart.length,
            itemBuilder: (context, index) {
              var quantity = value.cart[index].quantity;

              return ListTile(
                title: Text(value.cart[index].name),
                subtitle: Text('Jumlah barang : ${value.cart[index].quantity}'),
                onTap: () {},
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Edit Jumlah Barang',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () async {
                                          final barang = value.cart[index];

                                          if (barang.quantity < 2) {
                                            return;
                                          }

                                          value.updateBarang(
                                            Barang(
                                              id: barang.id,
                                              name: barang.name,
                                              price: barang.price,
                                              description: barang.description,
                                              quantity: barang.quantity - 1,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(context.watch<StokProvider>().cart[index].quantity.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () async {
                                          final barang = value.cart[index];

                                          value.updateBarang(
                                            Barang(
                                              id: barang.id,
                                              name: barang.name,
                                              price: barang.price,
                                              description: barang.description,
                                              quantity: barang.quantity + 1,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await context.read<StokProvider>().hapusBarang(value.cart[index].id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
