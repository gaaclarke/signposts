#include "signposts.h"
#include <os/signpost.h>

static os_log_t points_of_interest_logger = NULL;

int32_t flt_signposts_emit(const char* str) {
  if (__builtin_available(macOS 10.14, iOS 12.0, *)) {
    if (!points_of_interest_logger) {
      points_of_interest_logger = os_log_create("dev.flutter", OS_LOG_CATEGORY_POINTS_OF_INTEREST);
    }
    os_signpost_event_emit(points_of_interest_logger, OS_SIGNPOST_ID_EXCLUSIVE, "flutter", "%s", str);
    return 0;
  }
  return 1;
}
