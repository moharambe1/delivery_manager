// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

enum StatePackageEnum {
  RECEIVING,
  RECEIVED,
  DELIVERING,
  DELEVERED,
  RETURN,
}

enum StatsMoneyEnum { MANAGER, DELIVER, RECIVER, CLIENT, PAYED }

enum StatsMoneyDeliveringEnum { CLIENT, RECIVER, PAYED }

enum WilayaEnum { BISKRA }

enum CityEnum { BISKRA, okba }

class PackageModel extends Equatable {
  final int id;

  final String? fullName;
  final String phoneNumber;

  final int moneyPackage;
  final int moneyDelivring;

  final StatePackageEnum statePackage;
  final StatsMoneyEnum stateMoney;
  final StatsMoneyDeliveringEnum stateMoneyDelivring;

  final WilayaEnum wilaya = WilayaEnum.BISKRA;
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
    this.city = CityEnum.BISKRA,
  });

  String _cityText() {
    const cityText = ["بــسكرة"];

    return cityText[city.index];
  }

  String getCityText() {
    return _cityText();
  }

  @override
  List<Object> get props {
    return [
      id,
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
      'city': city.toString()
    };
  }

  String toJson() => json.encode(toMap());
}
