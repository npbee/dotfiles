// Netable differences vs. the default firmware for the ErgoDox EZ:
// 1. The Cmd key is now on the right side, making Cmd+Space easier.
// 2. The media keys work on OSX (But not on Windows).
#include QMK_KEYBOARD_H
#include "debug.h"
#include "action_layer.h"

#define BASE 0 // default layer
#define SYMB 1 // symbols
#define MDIA 2 // media keys

enum {
    CT_CLN,
    CT_TMUX,
    CT_VIM_TAG,
    CT_SYMB,
    CT_BASE
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* Keymap 0: Basic layer
 *
 * ,--------------------------------------------------.           ,--------------------------------------------------.
 * |  Esc   |   1  |   2  |   3  |   4  |   5  | PgDn |           | PgUp |   6  |   7  |   8  |   9  |   0  |   -    |
 * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
 * |  Tab   |   Q  |   W  |   E  |   R  |   T  |  [   |           |   ]  |   Y  |   U  |   I  |   O  |   P  |   [    |
 * |--------+------+------+------+------+------|      |           | vtag |------+------+------+------+------+--------|
 * | LCtrl  |   A  |   S  |   D  |   F  |   G  |------|           |------|   H  |   J  |   K  |   L  |; :   |   '    |
 * |--------+------+------+------+------+------|  {   |           |   }  |------+------+------+------+------+--------|
 * | LShift |  L1  |   X  |   C  |   V  |   B  | tmux |           |      |   N  |   M  |   ,  |   .  |//L2 | RShift |
 * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
 *   |  `   |  ,   | ~L1  | Left | Right|                                       |  Up  | Down |   [  |   ]  | ~L2  |
 *   `----------------------------------'                                       `----------------------------------'
 *                                        ,-------------.       ,---------------.
 *                                        | App  | LGui |       | Alt  |Ctrl/Esc|
 *                                 ,------|------|------|       |------+--------+------.
 *                                 | Back |      | Home |       |   +  |        |      |
 *                                 | Spc/ | Tab/ |------|       |------| Enter/ |Space |
 *                                 | Cmd  | Alt  | End  |       |   -  | Alt    |      |
 *                                 `--------------------'       `----------------------'
 */
// If it accepts an argument (i.e, is a function), it doesn't need KC_.
// Otherwise, it needs KC_*
[BASE] = LAYOUT_ergodox(  // layer 0 : default
        // left hand
        KC_ESC,         KC_1,         KC_2,    KC_3,   KC_4,   KC_5,   KC_PGDN,
        KC_TAB,         KC_Q,         KC_W,    KC_E,   KC_R,   KC_T,   KC_LBRACKET,
        KC_LCTRL,       KC_A,         KC_S,    KC_D,   KC_F,   KC_G,
        KC_LSFT,        TD(CT_SYMB),  KC_X,    KC_C,   KC_V,   KC_B,   TD(CT_TMUX),
        KC_GRV,         KC_COMM,      MO(SYMB),KC_LEFT,KC_RGHT,
                                              ALT_T(KC_APP),       KC_LGUI,
                                                                   KC_HOME,
                        MT(MOD_LGUI, KC_BSPC),MT(MOD_LALT, KC_TAB),KC_END,
        // right hand
        KC_PGUP,     KC_6,   KC_7,   KC_8,   KC_9,   KC_0,             KC_MINS,
        TD(CT_VIM_TAG), KC_Y,   KC_U,   KC_I,   KC_O,   KC_P,             KC_LBRACKET,
                     KC_H,   KC_J,   KC_K,   KC_L,   TD(CT_CLN),        KC_QUOTE,
        KC_RCBR,     KC_N,   KC_M,   KC_COMM,KC_DOT, LT(MDIA, KC_SLSH),   KC_RSFT,
                             KC_UP,  KC_DOWN,KC_LBRC,KC_RBRC,          MO(MDIA),
        KC_LALT, CTL_T(KC_ESC),
        KC_PPLS,
        KC_PMNS, MT(MOD_RALT, KC_ENT), KC_SPC
    ),
/* Keymap 1: Symbol Layer
 *
 * ,--------------------------------------------------.           ,--------------------------------------------------.
 * |        |  F1  |  F2  |  F3  |  F4  |  F5  |      |           |      |  F6  |  F7  |  F8  |  F9  |  F10 |   F11  |
 * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
 * |        |      |   _  |      |      |   +  |      |           |      |   _  |   $  |   (  |   )  |   #  |   F12  |
 * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * |        |      |   '  |   <  |   >  |   -  |------|           |------|   !  |   >  |   {  |   }  |   =  |        |
 * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * |        |  L1  |   ?  |   /  |   \  |   ~  |      |           |      |   &  |   `  |   [  |   ]  |   |  |        |
 * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
 *   |      |      |      |      |      |                                       |  -   |    . |   *  |   %  |      |
 *   `----------------------------------'                                       `----------------------------------'
 *                                        ,-------------.       ,-------------.
 *                                        |      |      |       |      |      |
 *                                 ,------|------|------|       |------+------+------.
 *                                 |      |      |      |       |      |      |      |
 *                                 |      |      |------|       |------|      |      |
 *                                 |      |      |      |       |      |      |      |
 *                                 `--------------------'       `--------------------'
 */
// SYMBOLS
[SYMB] = LAYOUT_ergodox(
       // left hand
       KC_TRNS,KC_F1,  KC_F2,  KC_F3,  KC_F4,  KC_F5,  KC_TRNS,
       KC_TRNS,KC_TRNS,KC_UNDS,KC_TRNS,KC_TRNS,KC_PPLS,KC_TRNS,
       KC_TRNS,KC_TRNS,KC_QUOT,KC_LT,  KC_GT,  KC_MINS,
       KC_TRNS,TD(CT_BASE),KC_QUES,KC_SLSH,KC_BSLS,KC_TILD,KC_TRNS,
       KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,KC_TRNS,
                                       KC_TRNS,KC_TRNS,
                                               KC_TRNS,
                               KC_TRNS,KC_TRNS,KC_TRNS,
       // right hand
       KC_TRNS, KC_F6,   KC_F7,  KC_F8,   KC_F9,   KC_F10,  KC_F11,
       KC_TRNS, KC_UNDS, KC_DLR, KC_LPRN, KC_RPRN, KC_HASH, KC_F12,
                KC_EXLM, KC_GT,  KC_LCBR, KC_RCBR, KC_EQL,  KC_TRNS,
       KC_TRNS, KC_AMPR, KC_GRV, KC_LBRC, KC_RBRC, KC_PIPE, KC_TRNS,
                         KC_MINS,KC_DOT,  KC_ASTR, KC_PERC, KC_TRNS,
       KC_TRNS, KC_TRNS,
       KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS
),
/* Keymap 2: Media and mouse keys
 *
 * ,--------------------------------------------------.           ,--------------------------------------------------.
 * |        |      |      |      |      |      |      |           |      |      |      |      |      |      |        |
 * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
 * |        |      |      | MsUp |      |      |      |           |      |      |      | ACUp |      |      |        |
 * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * |        |      |MsLeft|MsDown|MsRght|      |------|           |------|      | ACLt | ACF  | ACRt |      |  Play  |
 * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * |        |      |      |      |      |      |      |           |      |      |      | ACDn |      |      |        |
 * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
 *   |      |      |      | MsWD | MsWU |                                       |VolUp |VolDn | Mute |      |      |
 *   `----------------------------------'                                       `----------------------------------'
 *                                        ,-------------.       ,-------------.
 *                                        |      |      |       |      |      |
 *                                 ,------|------|------|       |------+------+------.
 *                                 |      |      |      |       |      |      |Brwser|
 *                                 | Lclk | Rclk |------|       |------|      |Back  |
 *                                 |      |      |      |       |      |      |      |
 *                                 `--------------------'       `--------------------'
 */
// MEDIA AND MOUSE
[MDIA] = LAYOUT_ergodox(
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_MS_U, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_R, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_WH_U, KC_WH_D,
                                           KC_TRNS, KC_TRNS,
                                                    KC_TRNS,
                                  KC_BTN1, KC_BTN2, KC_TRNS,
    // right hand
       KC_TRNS,  KC_TRNS, KC_TRNS,              KC_TRNS,            KC_TRNS,              KC_TRNS, KC_TRNS,
       KC_TRNS,  KC_TRNS, KC_TRNS,              LALT(LGUI(KC_UP)),  KC_TRNS,              KC_TRNS, KC_TRNS,
                 KC_TRNS, LALT(LGUI(KC_LEFT)),  LALT(LGUI(KC_F)),   LALT(LGUI(KC_RIGHT)), KC_TRNS, KC_MPLY,
       KC_TRNS,  KC_TRNS, KC_TRNS,              LALT(LGUI(KC_DOWN)),KC_TRNS,              KC_TRNS, KC_TRNS,
                          KC_VOLU,              KC_VOLD,            KC_MUTE,              KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS,
       KC_TRNS,
       KC_TRNS, KC_TRNS, KC_WBAK
),
};

const uint16_t PROGMEM fn_actions[] = {
    [1] = ACTION_LAYER_TAP_TOGGLE(SYMB)                // FN1 - Momentary Layer 1 (Symbols)
};

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
  // MACRODOWN only works in this function
  switch(id) {
    case 0:
      if (record->event.pressed) {
        register_code(KC_RSFT);
      } else {
        unregister_code(KC_RSFT);
      }
      break;
  }
  return MACRO_NONE;
};

// Runs just one time when the keyboard initializes.
void matrix_init_user(void) {

};

// Runs constantly in the background, in a loop.
void matrix_scan_user(void) {

  uint8_t layer = biton32(layer_state);

  ergodox_board_led_off();
  ergodox_right_led_1_off();
  ergodox_right_led_2_off();
  ergodox_right_led_3_off();
  switch (layer) {
    // TODO: Make this relevant to the ErgoDox EZ.
    case SYMB:
      ergodox_right_led_1_on();
      break;
    case MDIA:
      ergodox_right_led_2_on();
      break;
    default:
      // none
      break;
  }

};

qk_tap_dance_action_t tap_dance_actions[] = {
    // semicolon on single tap, colon on double tap
    [CT_CLN] = ACTION_TAP_DANCE_DOUBLE (KC_SCLN, KC_COLN),

    // Left curly on single tap, tmux keys on double tap
    [CT_TMUX] = ACTION_TAP_DANCE_DOUBLE (KC_LCBR, LCTL(KC_SPC)),

    // Single tap is Z, double tap moves to symbol layer
    [CT_SYMB] = ACTION_TAP_DANCE_DUAL_ROLE (KC_Z, SYMB),
    [CT_BASE] = ACTION_TAP_DANCE_DUAL_ROLE (KC_TRNS, BASE),

    [CT_VIM_TAG] = ACTION_TAP_DANCE_DOUBLE(KC_RBRACKET, LCTL(KC_RBRACKET))

};
