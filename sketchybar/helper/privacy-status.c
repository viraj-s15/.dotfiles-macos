#include <CoreAudio/CoreAudio.h>
#include <CoreMediaIO/CMIOHardware.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

static bool microphone_active(void) {
  AudioObjectPropertyAddress devices = {
    kAudioHardwarePropertyDevices,
    kAudioObjectPropertyScopeGlobal,
    kAudioObjectPropertyElementMain
  };
  UInt32 size = 0;
  if (AudioObjectGetPropertyDataSize(kAudioObjectSystemObject, &devices, 0, NULL, &size) != noErr) return false;
  AudioDeviceID *ids = malloc(size);
  if (!ids || AudioObjectGetPropertyData(kAudioObjectSystemObject, &devices, 0, NULL, &size, ids) != noErr) {
    free(ids);
    return false;
  }
  bool active = false;
  for (UInt32 i = 0; i < size / sizeof(AudioDeviceID); i++) {
    AudioObjectPropertyAddress streams = {
      kAudioDevicePropertyStreams,
      kAudioDevicePropertyScopeInput,
      kAudioObjectPropertyElementMain
    };
    UInt32 stream_size = 0;
    if (AudioObjectGetPropertyDataSize(ids[i], &streams, 0, NULL, &stream_size) != noErr || stream_size == 0) continue;
    AudioObjectPropertyAddress running = {
      kAudioDevicePropertyDeviceIsRunningSomewhere,
      kAudioObjectPropertyScopeGlobal,
      kAudioObjectPropertyElementMain
    };
    UInt32 value = 0;
    UInt32 value_size = sizeof(value);
    if (AudioObjectGetPropertyData(ids[i], &running, 0, NULL, &value_size, &value) == noErr && value) {
      active = true;
      break;
    }
  }
  free(ids);
  return active;
}

static bool camera_active(void) {
  CMIOObjectPropertyAddress devices = {
    kCMIOHardwarePropertyDevices,
    kCMIOObjectPropertyScopeGlobal,
    kCMIOObjectPropertyElementMain
  };
  UInt32 size = 0;
  if (CMIOObjectGetPropertyDataSize(kCMIOObjectSystemObject, &devices, 0, NULL, &size) != noErr) return false;
  CMIODeviceID *ids = malloc(size);
  UInt32 used = 0;
  if (!ids || CMIOObjectGetPropertyData(kCMIOObjectSystemObject, &devices, 0, NULL, size, &used, ids) != noErr) {
    free(ids);
    return false;
  }
  bool active = false;
  for (UInt32 i = 0; i < size / sizeof(CMIODeviceID); i++) {
    CMIOObjectPropertyAddress running = {
      kCMIODevicePropertyDeviceIsRunningSomewhere,
      kCMIOObjectPropertyScopeGlobal,
      kCMIOObjectPropertyElementMain
    };
    UInt32 value = 0;
    UInt32 value_size = sizeof(value);
    if (CMIOObjectGetPropertyData(ids[i], &running, 0, NULL, value_size, &used, &value) == noErr && value) {
      active = true;
      break;
    }
  }
  free(ids);
  return active;
}

int main(void) {
  printf("{\"microphone\":%s,\"camera\":%s}\n",
         microphone_active() ? "true" : "false",
         camera_active() ? "true" : "false");
  return 0;
}
