import 'package:mysponsors/mysponsors.dart';
import 'package:test/test.dart';

void main() {
  test('Test if the sponsor API is up', () async {
    expect(await fetchSponsorsData(), isA<(Response, SponsorsData)>());
  });
}
