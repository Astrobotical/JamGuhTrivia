import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jamguh_triva/Models/moneyModel.dart';
import 'package:jamguh_triva/Models/productsModel.dart';
import 'package:meta/meta.dart';

part 'store_page_state.dart';

class StorePageCubit extends Cubit<StorePageState> {
  StorePageCubit() : super(StorePageInitial());
  List<productsModel> Data = [];
  bool subscriptionPass = false;
  void Subscribe() async {
    await FirebaseFirestore.instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var document in value.docs) {
        Map<Object, Object?> data = {'issubscribed': true};
        FirebaseFirestore.instance
            .collection('UserProfiles')
            .doc(document.id)
            .update(data)
            .then((value) {
          subscriptionPass = true;
          emit(StorePageSubscriptionSuccess());
          print('Updated Successfully');
          // emit(CompletesignupSuccess());
        }).catchError((error) {
          print('Error while updating');
          //  emit(CompletesignupError());
        });
      }
    });
  }

  Future<List<productsModel>> getitems() async {
    List<productsModel> LocalData = [];
    List<String> previouslypurchasedicons = [];

    QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var document in user.docs) {
      for (var items in document.data()['icons']) {
        previouslypurchasedicons.add(items);
      }
    }
    await FirebaseFirestore.instance
        .collection("icons")
        .get()
        .then((value) async {
      for (var document in value.docs) {
        if (document.id == "hVAOPXqfgvndhSMn5Q4E") {
        } else if (await idchecker(
            previouslypurchasedicons, document.data()['UID'])) {
          productsModel item = productsModel(
              Name: document.data()['Name'],
              ImageURL: document.data()['ImageURL'],
              Cost: document.data()['Cost'],
              UID: document.data()['UID'],
              haspurchased: true);
          LocalData.add(item);
          Data.add(item);
        } else {
          productsModel item = productsModel(
              Name: document.data()['Name'],
              ImageURL: document.data()['ImageURL'],
              Cost: document.data()['Cost'],
              UID: document.data()['UID'],
              haspurchased: false);
          LocalData.add(item);
          Data.add(item);
        }
      }
    });
    return LocalData;
  }

  Future<List<moneyModel>> getGold() async {
    List<moneyModel> money = [];
    await FirebaseFirestore.instance
        .collection("Gold")
        .get()
        .then((value) async {
      for (var document in value.docs) {
        moneyModel item = moneyModel(
            UID: document.data()['UID'],
            Cost: document.data()['Cost'],
            point: document.data()['points'],
            Name: document.data()['Name']);
        money.add(item);
      }
    });
    return money;
  }

  Future<bool> idchecker(List<String> DataPool, String ID) async {
    for (String value in DataPool) {
      if (value == ID) {
        return true;
      }
    }
    return false;
  }

  void purchase(String ID) async {
    await FirebaseFirestore.instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var document in value.docs) {
        List<dynamic> previousarray = document.data()['icons'];
        previousarray.add(ID);
        Map<Object, Object?> data = {'icons': previousarray};
        FirebaseFirestore.instance
            .collection('UserProfiles')
            .doc(document.id)
            .update(data)
            .then((value) {
          print('Updated Successfully');
          // emit(CompletesignupSuccess());
        }).catchError((error) {
          print('Error while updating');
          //  emit(CompletesignupError());
        });
      }
    });
  }

  void purchaseGold(num points) async {
    await FirebaseFirestore.instance
        .collection('UserProfiles')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var document in value.docs) {
        num Previouspoints = document.data()['jamcoins'];
        Previouspoints += points;
        Map<Object, Object?> data = {'jamcoins': Previouspoints};
        FirebaseFirestore.instance
            .collection('UserProfiles')
            .doc(document.id)
            .update(data)
            .then((value) {
          print('Updated Successfully');
          // emit(CompletesignupSuccess());
        }).catchError((error) {
          print('Error while updating');
          //  emit(CompletesignupError());
        });
      }
    });
  }
}
