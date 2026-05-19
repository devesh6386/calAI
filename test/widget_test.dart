import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:cal_ai/main.dart';

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return FakeHttpClient();
  }
}

class FakeHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return Future.value(FakeHttpClientRequest());
  }
}

class FakeHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = FakeHttpHeaders();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return Future.value(FakeHttpClientResponse());
  }
}

class FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

class FakeHttpClientResponse implements HttpClientResponse {
  final List<int> transparentPng = [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
  ];

  @override
  final HttpHeaders headers = FakeHttpHeaders();

  @override
  int get statusCode => 200;

  @override
  int get contentLength => transparentPng.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #listen) {
      final listener = invocation.positionalArguments[0] as void Function(List<int>);
      final onDone = invocation.namedArguments[#onDone] as void Function()?;
      final onError = invocation.namedArguments[#onError] as Function?;
      final cancelOnError = invocation.namedArguments[#cancelOnError] as bool?;
      return Stream<List<int>>.fromIterable([transparentPng]).listen(
        listener,
        onDone: onDone,
        onError: onError,
        cancelOnError: cancelOnError,
      );
    }
    return null;
  }
}

void main() {
  testWidgets('SnapMacro App onboarding smoke test', (WidgetTester tester) async {
    HttpOverrides.global = MockHttpOverrides();

    await tester.pumpWidget(const SnapMacroApp());
    await tester.pumpAndSettle();

    expect(find.text('Track meals\nwith AI'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
