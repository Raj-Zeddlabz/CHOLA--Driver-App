import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/BankDetails.dart';
// import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:flutter/material.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({Key? key}) : super(key: key);

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> filteredBanks = [];

  @override
  void initState() {
    super.initState();
    filteredBanks = Constants.allBanksWithWebsite.toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
    /// Applies a search query to the list of banks and updates the filteredBanks list.
  ///
  /// The [query] parameter is the search query to apply. It is converted to lowercase
  /// and trimmed before being used to filter the list of banks.
  ///
  /// This function does not return anything. Instead, it updates the state of the
  /// widget by calling `setState()`. The filteredBanks list is updated with the
  /// results of the search query.
  void applySearch(String query) {
    setState(() {
      filteredBanks = Constants.allBanksWithWebsite
          .where((bank) =>
              bank['Name']!.toLowerCase().contains(query.trim().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: "Bank Account",
          preferredHeight: size.height * 0.08,
        ),
        body: Column(
          children: [
            Container(
              width: size.width,
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select Your Bank',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: size.shortestSide * 0.0533,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Field(
                      labelText: "",
                      hintText: "Search Your Bank",
                      vertical: 0.03,
                      horizontal: 0.04,
                      keyboardType: TextInputType.text,
                      prefixWidget: Icon(
                        Icons.search,
                      ),
                      onChanged: applySearch,
                      fieldController: _searchController,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.02,
                ),
                child: ListView.separated(
                  itemCount: filteredBanks.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: size.height * 0.02,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredBanks[index]['Name']!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.shortestSide * 0.045,
                          color: Colors.black,
                        ),
                      ),
                      splashColor: Colors.black26,
                      tileColor: Colors.white,
                      isThreeLine: true,
                      onTap: () {
                        // int originalIndex = Constants.allBanks.indexOf(filteredBanks[index]['Name']!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankDetails(
                              bankName: filteredBanks[index]['Name']!,
                              bankSite: filteredBanks[index]['Site']!,
                            ),
                          ),
                        );
                      },
                      subtitle: Text(
                        filteredBanks[index]['Site']!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: size.shortestSide * 0.035,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      minVerticalPadding: size.height * 0.02,
                      horizontalTitleGap: size.width * 0.02,
                      // visualDensity: VisualDensity.compact,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
