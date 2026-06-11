import 'package:cstore/models.dart';
import 'package:cstore/repository.dart';
import 'package:cstore/statemodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product model', () {
    test('creates with correct values', () {
      final product = const Product(
        category: Category.accessories,
        id: 0,
        isFeatured: true,
        name: 'Test Product',
        price: 100,
      );
      expect(product.name, 'Test Product');
      expect(product.price, 100);
      expect(product.category, Category.accessories);
      expect(product.isFeatured, true);
    });

    test('assetName generates correct URL', () {
      final product = const Product(
        category: Category.clothing,
        id: 5,
        isFeatured: false,
        name: 'Shirt',
        price: 50,
      );
      expect(product.assetName, 'https://picsum.photos/50');
    });
  });

  group('ProductsRepository', () {
    test('loadProducts returns all products for Category.all', () {
      final products = ProductsRepository.loadProducts(Category.all);
      expect(products.length, 38);
    });

    test('loadProducts filters by category', () {
      final clothing = ProductsRepository.loadProducts(Category.clothing);
      expect(clothing.length, 19);
      expect(clothing.every((p) => p.category == Category.clothing), true);
    });
  });

  group('AppStateModel', () {
    test('starts with no products loaded', () {
      final model = AppStateModel();
      expect(model.totalCartQuantity, 0);
      expect(model.subtotalCost, 0.0);
    });

    test('loadProducts loads from repository', () {
      final model = AppStateModel();
      model.loadProducts();
      expect(model.getProducts().length, 38);
    });

    test('addProductToCart adds items', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      expect(model.productsInCart[0], 1);
      expect(model.totalCartQuantity, 1);
    });

    test('addProductToCart increments quantity for duplicate', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      model.addProductToCart(0);
      expect(model.productsInCart[0], 2);
      expect(model.totalCartQuantity, 2);
    });

    test('removeItemFromCart decrements quantity', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      model.addProductToCart(0);
      model.removeItemFromCart(0);
      expect(model.productsInCart[0], 1);
    });

    test('removeItemFromCart removes item when quantity reaches 1', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      model.removeItemFromCart(0);
      expect(model.productsInCart.containsKey(0), false);
    });

    test('clearCart removes all items', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      model.addProductToCart(1);
      model.clearCart();
      expect(model.totalCartQuantity, 0);
    });

    test('subtotalCost calculates correctly', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      model.addProductToCart(1);
      final expected = model.getProductById(0).price.toDouble() +
          model.getProductById(1).price.toDouble();
      expect(model.subtotalCost, expected);
    });

    test('totalCost includes subtotal, shipping, and tax', () {
      final model = AppStateModel();
      model.loadProducts();
      model.addProductToCart(0);
      expect(model.totalCost,
          model.subtotalCost + model.shippingCost + model.tax);
    });

    test('search finds matching products', () {
      final model = AppStateModel();
      model.loadProducts();
      final results = model.search('sunglasses');
      expect(results.isNotEmpty, true);
      expect(results.first.name.toLowerCase(), contains('sunglasses'));
    });

    test('setCategory filters products', () {
      final model = AppStateModel();
      model.loadProducts();
      model.setCategory(Category.home);
      expect(model.getProducts().every((p) => p.category == Category.home),
          true);
    });

    test('getProductById returns correct product', () {
      final model = AppStateModel();
      model.loadProducts();
      final product = model.getProductById(0);
      expect(product.name, 'Vagabond sack');
    });
  });
}
