/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "audio_hw_primary"
/*#define LOG_NDEBUG 0*/
/*#define LOG_NDEBUG_FUNCTION*/
#ifndef LOG_NDEBUG_FUNCTION
#define LOGFUNC(...) ((void)0)
#else
#define LOGFUNC(...) (LOGV(__VA_ARGS__))
#endif

#include <dlfcn.h>
#include <stdlib.h>

#include <utils/Log.h>
#include <cutils/properties.h>

#include "ril_interface.h"

#define VOLUME_STEPS_DEFAULT  "5"
#define VOLUME_STEPS_PROPERTY "ro.config.vc_call_vol_steps"

/* Function pointers */
void *(*_ril_open_client)(int, char **);
int (*_ril_close_client)(void *);
int (*_ril_connect)(void *);
int (*_ril_is_connected)(void *);
int (*_ril_disconnect)(void *);
int (*_ril_set_call_volume)(void *, enum ril_sound_type, int);
int (*_ril_set_call_audio_path)(void *, enum ril_audio_path);
int (*_ril_set_call_clock_sync)(void *, enum ril_clock_state);
int (*_ril_register_unsolicited_handler)(void *, int, void *);

/* Audio WB AMR callback */
void (*_audio_set_wb_amr_callback)(void *, int);
void *callback_data = NULL;

void ril_register_set_wb_amr_callback(void *function, void *data)
{
    _audio_set_wb_amr_callback = function;
    callback_data = data;
}

/* This is the callback function that the RIL uses to
set the wideband AMR state */
static int ril_set_wb_amr_callback(void *ril_client,
                                   const void *data,
                                   size_t datalen)
{
    int enable = ((int *)data)[0];

    if (!callback_data || !_audio_set_wb_amr_callback)
        return -1;

    _audio_set_wb_amr_callback(callback_data, enable);

    return 0;
}

static int make_argv(char * args, char ** argv)
{
    int count = 0;
    char *tok;
    char *s = args;

    while ((tok = strtok(s, " \0"))) {
        argv[count] = tok;
        s = NULL;
        count++;
    }
    return count;
}

static int ril_connect_if_required(struct ril_handle *ril)
{
    LOGFUNC("%s(%p)", __FUNCTION__, ril);

    if (_ril_is_connected(ril->client))
        return 0;

    if (_ril_connect(ril->client) != RIL_CLIENT_ERR_SUCCESS) {
        LOGE("ril_connect() failed");
        return -1;
    }
    return 0;
}

int ril_open(struct ril_handle *ril)
{
    char property[PROPERTY_VALUE_MAX];
    char **ril_client_argv;
    int ril_client_argc;
    static char *new_argv[RIL_CLIENT_MAX_LIB_ARGS];

    LOGFUNC("%s(%p)", __FUNCTION__, ril);

    if (!ril)
        return -1;

    if (!property_get(RIL_CLIENT_PATH_PROPERTY, property, NULL)) {
        LOGE("Cannot find '%s' property", RIL_CLIENT_PATH_PROPERTY);
        goto none;
    }

    ril->handle = dlopen(property, RTLD_NOW);

    if (!ril->handle) {
        LOGE("Cannot open '%s'", property);
        goto none;
    }

    _ril_open_client = dlsym(ril->handle, "OpenClient_RILD");
    _ril_close_client = dlsym(ril->handle, "CloseClient_RILD");
    _ril_connect = dlsym(ril->handle, "Connect_RILD");
    _ril_is_connected = dlsym(ril->handle, "isConnected_RILD");
    _ril_disconnect = dlsym(ril->handle, "Disconnect_RILD");
    _ril_set_call_volume = dlsym(ril->handle, "SetCallVolume");
    _ril_set_call_audio_path = dlsym(ril->handle, "SetCallAudioPath");
    _ril_set_call_clock_sync = dlsym(ril->handle, "SetCallClockSync");
    _ril_register_unsolicited_handler = dlsym(ril->handle,
                                              "RegisterUnsolicitedHandler");

    if (!_ril_open_client || !_ril_close_client || !_ril_connect ||
        !_ril_is_connected || !_ril_disconnect || !_ril_set_call_volume ||
        !_ril_set_call_audio_path || !_ril_set_call_clock_sync ||
        !_ril_register_unsolicited_handler) {
        LOGE("Cannot get symbols from '%s'", property);
        dlclose(ril->handle);
        goto none;
    }

    ril_client_argv = new_argv;
    property_get(RIL_CLIENT_ARGS_PROPERTY, property, "");
    ril_client_argc = make_argv(property, ril_client_argv);

    ril->client = _ril_open_client(ril_client_argc, ril_client_argv);
    if (!ril->client) {
        LOGE("ril_open_client() failed");
        dlclose(ril->handle);
        goto none;
    }

    /* register the wideband AMR callback */
    _ril_register_unsolicited_handler(ril->client, RIL_UNSOL_WB_AMR_STATE,
                                      ril_set_wb_amr_callback);

    property_get(VOLUME_STEPS_PROPERTY, property, VOLUME_STEPS_DEFAULT);
    ril->volume_steps_max = atoi(property);
    /* this catches the case where VOLUME_STEPS_PROPERTY does not contain
    an integer */
    if (ril->volume_steps_max == 0)
        ril->volume_steps_max = atoi(VOLUME_STEPS_DEFAULT);

    return 0;

none:
    while(1) {
        LOGE("ril_open failed");
        sleep(10);
    }
}

int ril_close(struct ril_handle *ril)
{
    LOGFUNC("%s(%p)", __FUNCTION__, ril);

    if (!ril || !ril->handle || !ril->client)
        return -1;

    if ((_ril_disconnect(ril->client) != RIL_CLIENT_ERR_SUCCESS) ||
        (_ril_close_client(ril->client) != RIL_CLIENT_ERR_SUCCESS)) {
        LOGE("ril_disconnect() or ril_close_client() failed");
        return -1;
    }

    dlclose(ril->handle);
    return 0;
}

int ril_set_call_volume(struct ril_handle *ril, enum ril_sound_type sound_type,
                        float volume)
{
    LOGFUNC("%s(%p, %d, %f)", __FUNCTION__, ril, sound_type, volume);

    if (ril_connect_if_required(ril))
        return 0;

    return _ril_set_call_volume(ril->client, sound_type,
                                (int)(volume * ril->volume_steps_max));
}

int ril_set_call_audio_path(struct ril_handle *ril, enum ril_audio_path path)
{
    LOGFUNC("%s(%p, %d)", __FUNCTION__, ril, path);

    if (ril_connect_if_required(ril))
        return 0;

    return _ril_set_call_audio_path(ril->client, path);
}

int ril_set_call_clock_sync(struct ril_handle *ril, enum ril_clock_state state)
{
    LOGFUNC("%s(%p, %d)", __FUNCTION__, ril, state);

    if (ril_connect_if_required(ril))
        return 0;

    return _ril_set_call_clock_sync(ril->client, state);
}
