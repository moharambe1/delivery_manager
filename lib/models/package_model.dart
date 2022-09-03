// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum StatePackageEnum {
  RECEIVING,
  RECEIVED,
  DELIVERING,
  DELEVERED,
  STORED,
  RETURNING,
  RETURN,
  PAYED,
  DONE,
  ALL
}

const mapStateArb = [
  [StatePackageEnum.ALL, "الكـل"],
  [StatePackageEnum.RECEIVING, "يجب الاستـلام"],
  [StatePackageEnum.RECEIVED, "تـم الاستـلام"],
  [StatePackageEnum.DELIVERING, "جـاري التـوصيـل"],
  [StatePackageEnum.DELEVERED, "تـم التـوصيـل"],
  [StatePackageEnum.STORED, "المستـودع"],
  [StatePackageEnum.RETURNING, "فشـل التـوصيـل"],
  [StatePackageEnum.RETURN, "تـم الارجـاع"],
  [StatePackageEnum.PAYED, "تـم الدفـع"],
];

enum StatsMoneyEnum { MANAGER, DELIVER, RECIVER, CLIENT, PAYED }

enum StatsMoneyDeliveringEnum { CLIENT, RECIVER, DElIVER, PAYED }

enum WilayaEnum { BISKRA, BATNA, OuledDjellal, AUTHER }

final wilayaList = [
  [WilayaEnum.BISKRA, "بســكـرة"],
  [WilayaEnum.BATNA, "بـاتـنة"],
  [WilayaEnum.OuledDjellal, "ولاد جـلال"],
];

enum CityEnum {
  BISKRA,
  BATNA,
  OuledDjellal,
  Okba,
  Lhajbe,
  Bouchagroun,
  Lichana,
  Tolga,
  BordjBenAzzouz,
  Foughala,
  Ourlala,
  Mlili,
  Oumache,
  ElGhrous,
  Lioua,
  Doucen,
  AinNaga,
  ZeribetElOued,
  ElFeidh,
  ElHaouch,
  ElOutaya,
  Branis,
  Djemorah,
  ElKantara,
  Arris,
  Ichemoul,
  SidiKhaled,
  AUTHER
}

final bladiaList = [
  [CityEnum.values[0], "بســكـرة"],
  [CityEnum.values[1], "سيــدي عقــبة"],
  [CityEnum.values[2], "الحاجـب"],
  [CityEnum.values[3], "ليشانة"],
  [CityEnum.values[4], "طولقة"],
  [CityEnum.values[5], "برج بن عزوز"],
  [CityEnum.values[6], " فوغالة"],
  [CityEnum.values[7], "أورلال"],
  [CityEnum.values[8], "مليلي"],
  [CityEnum.values[9], "أوماش"],
  [CityEnum.values[10], "الغروس"],
  [CityEnum.values[11], "ليوة"],
  [CityEnum.values[13], "عين الناقة"],
  [CityEnum.values[14], "زريبة الوادي"],
  [CityEnum.values[15], "الفيض"],
  [CityEnum.values[16], "الحوش"],
  [CityEnum.values[17], "لوطاية"],
  [CityEnum.values[18], "البرانس"],
  [CityEnum.values[19], "جمورة"],
  [CityEnum.values[20], "القنطرة"],
  [CityEnum.AUTHER, "......"],
];
final bladiaBatnaList = [
  [CityEnum.BATNA, "بـاتـنة"],
  [CityEnum.values[21], "آريس"],
  [CityEnum.values[22], "ايشمول"],
  [CityEnum.AUTHER, "......"],
];
final bladiaOuladJilal = [
  [CityEnum.OuledDjellal, "ولاد جلال"],
  [CityEnum.Doucen, "الدوسن"],
  [CityEnum.SidiKhaled, "سيدي خالد"],
  [CityEnum.AUTHER, "......"],
];

class PackageModel extends Equatable {
  final int? id;

  final String? fullName;
  final String phoneNumber;

  final int moneyPackage;
  final int moneyDelivring;

  final StatePackageEnum statePackage;
  final StatsMoneyEnum stateMoney;
  final StatsMoneyDeliveringEnum stateMoneyDelivring;

  final WilayaEnum wilaya;
  final CityEnum city;
  final String? address;

  const PackageModel({
    required this.id,
    this.fullName,
    required this.phoneNumber,
    required this.statePackage,
    required this.stateMoney,
    required this.stateMoneyDelivring,
    this.address,
    required this.moneyDelivring,
    this.moneyPackage = 0,
    this.wilaya = WilayaEnum.BISKRA,
    this.city = CityEnum.BISKRA,
  });
  static List<Object> _mapWilayaNameToArbText(WilayaEnum wilaya) {
    switch (wilaya) {
      case WilayaEnum.BISKRA:
        return bladiaList
            .firstWhere((element) => element[0] == CityEnum.BISKRA);
      case WilayaEnum.BATNA:
        return bladiaBatnaList
            .firstWhere((element) => element[0] == CityEnum.BATNA);
      case WilayaEnum.OuledDjellal:
        return bladiaOuladJilal
            .firstWhere((element) => element[0] == CityEnum.OuledDjellal);
      default:
        return [WilayaEnum.AUTHER, "....."];
    }
  }

  String getWilayaText() {
    return _mapWilayaNameToArbText(wilaya)[1] as String;
  }

  static List<Object> _mapCityNameToArbText(WilayaEnum wilaya, CityEnum city) {
    switch (wilaya) {
      case WilayaEnum.BISKRA:
        return bladiaList.firstWhere((element) => element[0] == city);
      case WilayaEnum.BATNA:
        return bladiaBatnaList.firstWhere((element) => element[0] == city);
      case WilayaEnum.OuledDjellal:
        return bladiaOuladJilal.firstWhere((element) => element[0] == city);
      default:
        return [CityEnum.AUTHER, "....."];
    }
  }

/*
  String _cityText() {
    if (wilaya == WilayaEnum.BISKRA) {
      return bladiaList.firstWhere((element) => element[0] == city)[1]
          as String;
    } else {
      return "......";
    }
  }
*/

  String getCityText() {
    return _mapCityNameToArbText(wilaya, city)[1] as String;
  }

  @override
  List<Object> get props {
    return [
      id ?? 0,
      fullName ?? "",
      phoneNumber,
      moneyPackage,
      moneyDelivring,
      statePackage,
      stateMoney,
      stateMoneyDelivring,
      wilaya,
      city,
      address ?? "",
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'moneyPackage': moneyPackage,
      'moneyDelivring': moneyDelivring,
      'statePackage': statePackage.name,
      'stateMoney': stateMoney.name,
      'stateMoneyDelivring': stateMoneyDelivring.name,
      'address': address,
      'wilaya': wilaya.name,
      'city': city.name
    };
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'],
      fullName: map['fullname'],
      phoneNumber: map['phonenumber'],
      moneyPackage: map['packagemoney'],
      moneyDelivring: map['delivringmoney'],
      statePackage: StatePackageEnum.values.byName(map['statepackage']),
      stateMoney: StatsMoneyEnum.values.byName(map['statemoney']),
      stateMoneyDelivring:
          StatsMoneyDeliveringEnum.values.byName(map['statemoneydelivering']),
      city: CityEnum.values.byName(map['city']),
      wilaya: WilayaEnum.values.byName(map['wilaya']),
      address: map['addrass'], //TODO : fix missing spelling Address
    );
  }

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source));

  String get cityArb {
    //return bladiaList.firstWhere((element) => element[0] == city)[1];
    return _mapCityNameToArbText(wilaya, city)[1] as String;
  }

  int get packageMonyDontPayed {
    return stateMoney == StatsMoneyEnum.MANAGER ? 0 : moneyPackage;
  }

  int get delivringMonyDontPayed {
    return stateMoneyDelivring == StatsMoneyDeliveringEnum.PAYED
        ? 0
        : moneyDelivring;
  }

  Widget btnChangePackageState(BuildContext context) {
    return Container();
  }
}
