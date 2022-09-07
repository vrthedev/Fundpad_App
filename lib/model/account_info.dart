import 'package:fundpad/model/payout.dart';
import 'package:fundpad/model/pledge.dart';

class AccountInfo {
  double pledgesSum;
  List<Pledge> pledges;

  double investorSum;
  List<Payout> investorPayouts;

  double referralSum;
  List<Payout> referralPayouts;

  AccountInfo({
    required this.pledgesSum,
    required this.pledges,
    required this.investorSum,
    required this.referralSum,
    required this.referralPayouts,
    required this.investorPayouts,
  });

  Map<String, dynamic> toJson() {
    return {
      'pledges_sum': pledgesSum,
      'investor_payout_sum': investorSum,
      'referral_payout_sum': referralSum,
      'pledges': pledges.map((e) => e.toJson()).toList(),
      'referral_payouts': referralPayouts.map((e) => e.toJson()).toList(),
      'investor_payouts': investorPayouts.map((e) => e.toJson()).toList(),
    };
  }

  factory AccountInfo.fromJson(Map<String, dynamic> map) {
    return AccountInfo(
      pledgesSum:
          (map['pledges_sum'] == null) ? 0 : map['pledges_sum'].toDouble(),
      investorSum: (map['investor_payout_sum'] == null)
          ? 0
          : map['investor_payout_sum'].toDouble(),
      referralSum: (map['referral_payout_sum'] == null)
          ? 0
          : map['referral_payout_sum'].toDouble(),
      pledges: (map['pledges'] == null)
          ? []
          : (map['pledges'] as List).map((e) => Pledge.fromJson(e)).toList(),
      referralPayouts: (map['referral_payouts'] == null)
          ? []
          : (map['referral_payouts'] as List)
              .map((e) => Payout.fromJson(e))
              .toList(),
      investorPayouts: (map['investor_payouts'] == null)
          ? []
          : (map['investor_payouts'] as List)
              .map((e) => Payout.fromJson(e))
              .toList(),
    );
  }

  static List<AccountInfo> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map<AccountInfo>((obj) => AccountInfo.fromJson(obj))
        .toList();
  }
}
