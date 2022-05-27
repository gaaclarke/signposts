# signposts

A flutter plugin for Apple's os_signpost API.

## Usage

```dart
import 'package:signposts/signposts.dart' as signposts;

void main() {
  signposts.emitEvent('hello');
  signposts.beginInterval(1, 'hi');
  print('hi');
  signposts.endInterval(1, 'bye');
}
```
