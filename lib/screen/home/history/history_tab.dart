import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:mobile_top_up/model/transaction_history/transaction_history_model.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager_provider.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    final topUpManager = TopUpManagerProvider.of(context);

    return FutureBuilder(
      future: topUpManager.getTransactionHistory(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TransactionHistoryModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final beneficiaries = snapshot.data;
        if (beneficiaries == null) {
          return const Center(
              child: Text('Error Fetching Transaction History'));
        }

        if (beneficiaries.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(40.0),
            child: Center(child: Text('No Transactions so far.')),
          );
        }

        return HistoryListView(beneficiaries);
      },
    );
  }
}

class HistoryListView extends StatelessWidget {
  final List<TransactionHistoryModel> models;
  const HistoryListView(this.models, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: models.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext context, int index) {
          final transactionHistory = models[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              tileColor: AppTheme.whiteColor,
              style: ListTileStyle.list,
              title: Text(
                transactionHistory.beneficiary.nickname,
                style: context.titleMedium!.bold,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionHistory.dateTime.toString(),
                    style: context.labelSmall,
                  ),
                  Text(
                    transactionHistory.beneficiary.phoneNumber,
                    style: context.labelSmall,
                  )
                ],
              ),
              trailing: Text(
                'AED ${transactionHistory.amountSent}',
                style: context.titleLarge,
              ),
            ),
          );
        });
  }
}
