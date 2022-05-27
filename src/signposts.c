#include "signposts.h"
#include <os/signpost.h>

static os_log_t points_of_interest_logger = NULL;

static os_log_t GetPointsOfInterestLogger() {
  if (!points_of_interest_logger) {
    points_of_interest_logger =
        os_log_create("dev.flutter", OS_LOG_CATEGORY_POINTS_OF_INTEREST);
  }
  return points_of_interest_logger;
}

int32_t flt_signposts_emit(const char* str) {
  if (__builtin_available(macOS 10.14, iOS 12.0, *)) {
    os_signpost_event_emit(GetPointsOfInterestLogger(), OS_SIGNPOST_ID_EXCLUSIVE, "flutter", "%s", str);
    return 0;
  }
  return 1;
}


int32_t flt_signposts_begin_interval(uint64_t identifier, const char* str) {
  if (__builtin_available(macOS 10.14, iOS 12.0, *)) {
    os_signpost_interval_begin(GetPointsOfInterestLogger(), identifier, "flutter", "%s", str);
    return 0;
  }
  return 1;
}

int32_t flt_signposts_end_interval(uint64_t identifier, const char* str) {
  if (__builtin_available(macOS 10.14, iOS 12.0, *)) {
    os_signpost_interval_end(GetPointsOfInterestLogger(), identifier, "flutter", "%s", str);
    return 0;
  }
  return 1;
}
