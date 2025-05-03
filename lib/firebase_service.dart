import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  static String? get currentUserId => _auth.currentUser?.uid;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user data
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    return await _firestore.collection('users').doc(userId).get();
  }

  // Update prayer count
  static Future<void> updatePrayerCount(String prayer) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    
    await _firestore.collection('users').doc(userId).update({
      'prayers.$prayer': FieldValue.increment(1),
      'lastPrayerTimestamp': FieldValue.serverTimestamp(),
    });
  }

  // Update ablution count
  static Future<void> updateAblutionCount() async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    
    await _firestore.collection('users').doc(userId).update({
      'ablutionCount': FieldValue.increment(1),
      'lastAblutionTimestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get prayer videos from Firestore
  static Future<QuerySnapshot<Map<String, dynamic>>> getPrayerVideos(String prayerName) async {
    return await _firestore
        .collection('prayers')
        .doc(prayerName)
        .collection('videos')
        .orderBy('order')
        .get();
  }

  // Get ablution videos from Firestore
  static Future<QuerySnapshot<Map<String, dynamic>>> getAblutionVideos() async {
    return await _firestore
        .collection('ablution')
        .doc('videos')
        .collection('tutorial')
        .orderBy('order')
        .get();
  }

  // Get stories from Firestore
  static Future<QuerySnapshot<Map<String, dynamic>>> getStories() async {
    return await _firestore
        .collection('stories')
        .orderBy('order')
        .get();
  }

  // Save prayer tracking data
  static Future<void> savePrayerTrackingData(String prayerName, Map<String, dynamic> trackingData) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    
    await _firestore.collection('users').doc(userId).collection('prayerTracking').add({
      'prayerName': prayerName,
      'trackingData': trackingData,
      'timestamp': FieldValue.serverTimestamp(),
      'feedbackProvided': false,
    });
  }

  // Save ablution tracking data
  static Future<void> saveAblutionTrackingData(Map<String, dynamic> trackingData) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    
    await _firestore.collection('users').doc(userId).collection('ablutionTracking').add({
      'trackingData': trackingData,
      'timestamp': FieldValue.serverTimestamp(),
      'feedbackProvided': false,
    });
  }
}