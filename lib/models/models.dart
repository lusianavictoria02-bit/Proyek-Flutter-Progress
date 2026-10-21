import 'package:flutter/foundation.dart';

class Product {
  final String id, name, shop, category, distance, pickupTime, description, image;
  final int originalPrice, price, stock;

  const Product({
    required this.id,
    required this.name,
    required this.shop,
    required this.category,
    required this.distance,
    required this.pickupTime,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.price,
    required this.stock,
  });

  int get discountPercent => ((1 - price / originalPrice) * 100).round();
}

class CartItem {
  final Product product;
  int qty;
  CartItem(this.product, this.qty);
}

/// State keranjang sederhana (singleton + ChangeNotifier).
class CartModel extends ChangeNotifier {
  CartModel._();
  static final CartModel instance = CartModel._();

  final List<CartItem> items = [];

  int get count => items.fold(0, (sum, i) => sum + i.qty);
  int get total => items.fold(0, (sum, i) => sum + i.product.price * i.qty);

  void add(Product p, int qty) {
    final index = items.indexWhere((i) => i.product.id == p.id);
    if (index >= 0) {
      items[index].qty += qty;
    } else {
      items.add(CartItem(p, qty));
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    items.remove(item);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

String rupiah(int v) {
  final s = v.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
    b.write(s[i]);
  }
  return 'Rp$b';
}

// Data dummy (ganti nama toko/menu sesuai idemu)
const dummyProducts = <Product>[
  Product(id: '1', name: 'Surprise Bag Roti', shop: 'Bakery Sinar Pagi', category: 'Bakery', distance: '0,8 km', pickupTime: '19.00 - 20.00', description: 'Campuran roti manis dan tawar hari ini yang tidak terjual. Masih segar dan layak konsumsi.', image: 'assets/images/roti.jpg', originalPrice: 60000, price: 20000, stock: 5),
  Product(id: '2', name: 'Paket Nasi Ayam', shop: 'Resto Bunda', category: 'Resto', distance: '1,2 km', pickupTime: '20.00 - 21.00', description: 'Nasi dengan ayam goreng dan sayur, porsi surplus dari penjualan makan siang.', image: 'assets/images/nasi.jpg', originalPrice: 35000, price: 15000, stock: 8),
  Product(id: '3', name: 'Croissant & Kopi', shop: 'Cafe Senja', category: 'Cafe', distance: '2,0 km', pickupTime: '18.30 - 19.30', description: 'Croissant butter dan kopi susu sisa stok hari ini.', image: 'assets/images/croissant.jpg', originalPrice: 48000, price: 22000, stock: 3),
  Product(id: '4', name: 'Donat Assorted (6 pcs)', shop: 'Bakery Sinar Pagi', category: 'Bakery', distance: '0,8 km', pickupTime: '19.00 - 20.00', description: 'Enam donat dengan topping berbeda.', image: 'assets/images/donat.jpg', originalPrice: 42000, price: 18000, stock: 6),
  Product(id: '5', name: 'Mie Goreng Spesial', shop: 'Resto Bunda', category: 'Resto', distance: '1,2 km', pickupTime: '20.00 - 21.00', description: 'Mie goreng dengan telur dan sayuran.', image: 'assets/images/mie.jpg', originalPrice: 28000, price: 12000, stock: 10),
  Product(id: '6', name: 'Cheesecake Slice', shop: 'Cafe Senja', category: 'Cafe', distance: '2,0 km', pickupTime: '18.30 - 19.30', description: 'Potongan cheesecake sisa display hari ini.', image: 'assets/images/cheesecake.jpg', originalPrice: 38000, price: 17000, stock: 4),
];
