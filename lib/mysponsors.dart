import 'dart:convert';
import 'package:http/http.dart' as http;

export 'package:http/http.dart';

Future<(http.Response, SponsorsData?)> fetchSponsorsData({
  String sponsorsUrl = 'https://alexrintt.io/sponsors/all.json',
}) async {
  final response = await http.get(Uri.parse(sponsorsUrl));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return (response, SponsorsData.fromJson(jsonData));
  } else {
    return (response, null);
  }
}

class SponsorsData {
  final int privateSponsorsCount;
  final List<SponsorInfo> publicSponsors;

  const SponsorsData({
    required this.privateSponsorsCount,
    required this.publicSponsors,
  });

  factory SponsorsData.fromJson(Map<String, dynamic> json) {
    return SponsorsData(
      privateSponsorsCount: json['privateSponsorsCount'],
      publicSponsors: List<SponsorInfo>.from(
        json['publicSponsors'].map(
          (sponsor) => SponsorInfo.fromJson(sponsor),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'privateSponsorsCount': privateSponsorsCount,
      'publicSponsors': List<dynamic>.from(
        publicSponsors.map(
          (sponsor) => sponsor.toJson(),
        ),
      ),
    };
  }
}

class SponsorInfo {
  final String privacyLevel;
  final DateTime createdAt;
  final bool isActive;
  final SponsorEntity sponsorEntity;
  final String? websiteUrl;

  const SponsorInfo({
    required this.privacyLevel,
    required this.createdAt,
    required this.isActive,
    required this.sponsorEntity,
    this.websiteUrl,
  });

  factory SponsorInfo.fromJson(Map<String, dynamic> json) {
    return SponsorInfo(
      privacyLevel: json['privacyLevel'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'],
      sponsorEntity: SponsorEntity.fromJson(json['sponsorEntity']),
      websiteUrl: json['websiteUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'privacyLevel': privacyLevel,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
      'sponsorEntity': sponsorEntity.toJson(),
      'websiteUrl': websiteUrl,
    };
  }
}

class SponsorEntity {
  final String avatarUrl;
  final String url;
  final String name;
  final String login;

  const SponsorEntity({
    required this.avatarUrl,
    required this.url,
    required this.name,
    required this.login,
  });

  factory SponsorEntity.fromJson(Map<String, dynamic> json) {
    return SponsorEntity(
      avatarUrl: json['avatarUrl'],
      url: json['url'],
      name: json['name'],
      login: json['login'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'url': url,
      'name': name,
      'login': login,
    };
  }
}
