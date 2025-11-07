import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/farmer_model.dart';
import '../models/order_model.dart';
import '../utils/constants.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Farmers
  Future<void> createFarmer(FarmerModel farmer) async {
    await _firestore
        .collection(AppConstants.farmersCollection)
        .doc(farmer.id)
        .set(farmer.toMap());
  }

  Future<FarmerModel?> getFarmer(String id) async {
    final doc = await _firestore
        .collection(AppConstants.farmersCollection)
        .doc(id)
        .get();
    
    if (doc.exists) {
      return FarmerModel.fromFirestore(doc);
    }
    return null;
  }

  Stream<List<FarmerModel>> getAvailableFarmers({
    String? district,
    double? minQuantity,
  }) {
    Query query = _firestore
        .collection(AppConstants.farmersCollection)
        .where('availableForSale', isEqualTo: true);

    if (district != null) {
      query = query.where('location.district', isEqualTo: district);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => FarmerModel.fromFirestore(doc))
        .where((farmer) => 
            minQuantity == null || 
            (farmer.harvestInfo?.actualQuantity ?? 0) >= minQuantity)
        .toList());
  }

  // Orders
  Future<String> createOrder(OrderModel order) async {
    final docRef = await _firestore
        .collection(AppConstants.ordersCollection)
        .add(order.toMap());
    return docRef.id;
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore
        .collection(AppConstants.ordersCollection)
        .doc(orderId)
        .update({'status': status});
  }

  Stream<List<OrderModel>> getUserOrders(String userId, {bool isBuyer = true}) {
    final field = isBuyer ? 'buyerId' : 'sellerId';
    return _firestore
        .collection(AppConstants.ordersCollection)
        .where(field, isEqualTo: userId)
        .orderBy('requestDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromFirestore(doc))
            .toList());
  }

  // Notifications
  Stream<QuerySnapshot> getNotifications(String userId) {
    return _firestore
        .collection(AppConstants.notificationsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots();
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    await _firestore
        .collection(AppConstants.notificationsCollection)
        .doc(notificationId)
        .update({'isRead': true});
  }
}
