import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jamguh_triva/Models/moneyModel.dart';
import 'package:jamguh_triva/Models/productsModel.dart';
import 'package:jamguh_triva/Statemanagement/cubit/store_page_cubit.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentContext = context.read<StorePageCubit>();
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        margin: EdgeInsets.all(15),
        child: Text(
          "Store",
          style: TextStyle(fontSize: 25),
        ),
      ),
      Container(
        margin: EdgeInsets.all(15),
        child: Text(
          "Monthly Pass",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(style: BorderStyle.solid)),
        width: MediaQuery.sizeOf(context).width,
        height: 200,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(25),
        child: Stack(
          children: [
            Image.network(
              'https://gaming-cdn.com/images/products/15220/616x353/xbox-game-pass-ultimate-1-month-non-stackable-1-month-ultimate-pc-xbox-one-xbox-series-x-s-game-microsoft-store-united-states-cover.jpg?v=1697805894',
              width: double.infinity,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 5, bottom: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                
                      },
                      child: BlocBuilder<StorePageCubit, StorePageState>(
                          builder: (context, state) {
                        if (state is StorePageSubscriptionSuccess) {
                          return currentContext.subscriptionPass
                              ? Text(
                                  'Purchased',
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    currentContext.purchaseGold(2000);
                                    _purchaseSubscription(context);
                                    currentContext.Subscribe();
                                  },
                                  child: Text(
                                    'Purchase Pass',
                                    style: const TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ));
                        }
                        return currentContext.subscriptionPass
                            ? Text(
                                'Purchased',
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : InkWell(
                                  onTap: () {
                                    currentContext.purchaseGold(2000);
                                    _purchaseSubscription(context);
                                    currentContext.Subscribe();
                                  },
                                  child: Text(
                                    'Purchase Pass',
                                    style: const TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ));
                      }),
                    )))
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.all(15),
        child: Text(
          "Icons",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
          height: MediaQuery.sizeOf(context).height / 2,
          child: FutureBuilder<List<productsModel>>(
            future: currentContext.getitems(),
            builder: (context, snapped) {
              if (snapped.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapped.hasError) {
                return Text('Error found - ${snapped.error}');
              }
              return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  itemCount: snapped.data!.length,
                  itemBuilder: (context, index) {
                    productsModel item = productsModel(
                        Name: snapped.data![index].Name,
                        ImageURL: snapped.data![index].ImageURL,
                        Cost: snapped.data![index].Cost,
                        UID: snapped.data![index].UID,
                        haspurchased: snapped.data![index].haspurchased);
                    return _buildProductCard(item, context);
                  });
            },
          )),
      Container(
        margin: EdgeInsets.all(15),
        child: Text(
          "Points",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: FutureBuilder<List<moneyModel>>(
            future: currentContext.getGold(),
            builder: (context, snapped) {
              if (snapped.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapped.hasError) {
                return Text('Error found - ${snapped.error}');
              }
              return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  itemCount: snapped.data!.length,
                  itemBuilder: (context, index) {
                    moneyModel item = moneyModel(
                        Name: snapped.data![index].Name,
                        Cost: snapped.data![index].Cost,
                        UID: snapped.data![index].UID,
                        point: snapped.data![index].point);
                    return _buildGoldCard(item, context);
                  });
            },
          ))
    ])));
  }

  Widget _buildProductCard(productsModel Data, BuildContext context) {
    var currentContext = context.read<StorePageCubit>();
    return Card(
      elevation: 3.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(Data.Name),
        leading: Image.network(
          Data.ImageURL,
          width: 50.0,
          height: 50.0,
        ),
        trailing: Data.haspurchased!
            ? ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {},
                child: Text(
                  'Purchased',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  currentContext.purchase(Data.UID);
                  _purchaseProduct(context, Data.Name, Data.Cost);
                },
                child: Text('Buy \$${Data.Cost.toStringAsFixed(2)}'),
              ),
      ),
    );
  }

  Widget _buildGoldCard(moneyModel Data, BuildContext context) {
    var currentContext = context.read<StorePageCubit>();
    return Card(
      elevation: 3.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text('${Data.Name} (${Data.point})'),
        trailing: ElevatedButton(
          onPressed: () {
            currentContext.purchaseGold(Data.point);
            _purchaseGold(context, Data);
          },
          child: Text('Buy \$${Data.Cost.toStringAsFixed(2)}'),
        ),
      ),
    );
  }

  void _purchaseGold(BuildContext context, moneyModel Data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Successful'),
          content: Text(
              'You have successfully purchased ${Data.Name} (${Data.point}) for \n${Data.Cost.toStringAsFixed(2)}.\nCheck your points balance'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _purchaseSubscription(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Purchase Successful'),
            content: Text(
                'You have successfully purchase the Subscription\nBenefits:\nGolden Name on the leaderboards\n2000 Trivia Points.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  void _purchaseProduct(BuildContext context, String productName, num price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Successful'),
          content: Text(
              'You have successfully purchased $productName for \$${price.toStringAsFixed(2)}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
