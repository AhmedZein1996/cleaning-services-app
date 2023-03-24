import 'package:clean_services_app/components/coustom_bottom_nav_bar.dart';
import 'package:clean_services_app/model/service.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:clean_services_app/utilities/enums.dart';
import 'package:clean_services_app/utilities/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../server/databases/sevices_helper.dart';
import 'grid_item.dart';

class Body extends StatelessWidget {
  List services = [].cast<ServiceModel>();
  // List<ServiceModel> services = [];

  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SafeArea(
              child: Text(
                localLanguageStrings(context).appName,
                //     "SERVICE WE OFFER",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                height: size.height - 169,
                width: size.width,
                child: Query(
                    options: QueryOptions(
                      document: gql(getServicesQuery),
                      fetchPolicy: FetchPolicy.noCache,
                      // pollInterval: Duration(seconds: 10)
                    ),
                    builder: (QueryResult result,
                        {VoidCallback? refetch, FetchMore? fetchMore}) {
                      if (result.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (result.isNotLoading) {
                        if (result.hasException) {
                          return const Center(child: Text("Error"));
                        } else {
                          services = ServiceHelper.getServices(result.data);
                        }
                      }

                      //   ServicesRepo.fromJSON(result.data);
                      return GridView.builder(
                        itemCount: services.length,
                        itemBuilder: (ctx, index) => GridItem(
                          assetLink: services[index].serviceImageUrl,
                          title: services[index].serviceTitle,
                          description: services[index].serviceDescription,
                          serviceId: services[index].serviceId,
                          regulations: services[index].regulations,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .9,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

//  "SERVICE WE OFFER Text" => .07 screen height (56.254)
//  "free space" =>            .08 screen height  (64.29)
//  "Sized box" =>        .03 screen height   (24)
// screen height =>        803.636
// screen width =>         392.72
//  "another Sized box" =>        .03 screen height   (24)
// "custom nav bar" =>            .07 screen height (56)
