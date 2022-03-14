import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
class ContactModel {
// Name
  String? displayName, givenName, middleName, prefix, suffix, familyName;

// Company
  String? company, jobTitle;

// Email addresses
  List<Item> emails = [];

// Phone numbers
  List<Item> phones = [];

// Post addresses
  List<PostalAddress> postalAddresses = [];

// Contact avatar/thumbnail
  Uint8List? avatar;

}