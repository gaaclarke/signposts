#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

int32_t flt_signposts_emit(const char* str);

int32_t flt_signposts_begin_interval(uint64_t identifier, const char* str);

int32_t flt_signposts_end_interval(uint64_t identifier, const char* str);
