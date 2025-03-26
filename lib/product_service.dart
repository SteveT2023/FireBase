import 'package:cloud_firestore/cloud_firestore.dart';
import 'product.dart';

class ProductService {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');

  // Create a new product
  Future<void> createProduct(Product product) async {
    await _productCollection.doc(product.id).set(product.toMap());
  }

  // Read a product by ID
  Future<Product?> getProduct(String id) async {
    DocumentSnapshot doc = await _productCollection.doc(id).get();
    if (doc.exists) {
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Read all products
  Future<List<Product>> getAllProducts() async {
    QuerySnapshot querySnapshot = await _productCollection.get();
    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Update a product
  Future<void> updateProduct(Product product) async {
    await _productCollection.doc(product.id).update(product.toMap());
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    await _productCollection.doc(id).delete();
  }
}
