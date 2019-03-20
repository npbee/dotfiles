// Netable differences vs. the default firmware for the ErgoDox EZ:
// 1. The Cmd key is now on the right side, making Cmd+Space easier.
// 2. The media keys work on OSX (But not on Windows).
#include QMK_KEYBOARD_H
#include "debug.h"
#include "action_layer.h"

#define BASE 0 // default layer
#define SYMB 1 // symbols
#define MDIA 2 // media keys

typedef struct {
  bool is_press_action;
  int state;
} tap;

enum {
  SINGLE_TAP = 1,
  SINGLE_HOLD = 2,
  DOUBLE_TAP = 3,
  DOUBLE_HOLD = 4,
  DOUBLE_SINGLE_TAP = 5, //send two single taps
  TRIPLE_TAP = 6,
  TRIPLE_HOLD = 7
};

enum {
    CT_CLN,
    CT_BASE,
    Z_CTL
};

int cur_dance (qk_tap_dance_state_t *state);

//for the z tap dance. Put it here so it can be used in any keymap
void z_finished (qk_tap_dance_state_t *state, void *user_data);
void z_reset (qk_tap_dance_state_t *state, void *user_data);

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* Keymap 0: Basic layer
 *
 * ,--------------------------------------------------.           ,--------------------------------------------------.
 * |  Esc   |   1  |   2  |   3  |   4  |   5  | PgDn |           | PgUp |   6  |   7  |   8  |   9  |   0  |   -    |
 * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
 * |  Tab   |   q  |   w  |   e  |   r  |   t  |  [   |           |   ]  |   y  |   u  |   i  |   o  |   p  |   [    |
 * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * | LCtrl  |   a  |   s  |   e  |   f  |   g  |------|           |------|   h  |   j  |   k  |   l  | ;/:  |   '    |
 * |--------+------+------+------+------+------|  {   |           |   }  |------+------+------+------+------+--------|
 * | LShift |   z  |   x  |   c  |   v  |   b  |      |           |      |   n  |   m  |   ,  |   .  |//L2 | RShift |
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
        KC_LSFT,        TD(Z_CTL),  KC_X,    KC_C,   KC_V,   KC_B,   KC_LCBR,
        KC_GRV,         KC_COMM,      MO(SYMB),KC_LEFT,KC_RGHT,
                                              ALT_T(KC_APP),       KC_LGUI,
                                                                   KC_HOME,
                        MT(MOD_LGUI, KC_BSPC),MT(MOD_LALT, KC_TAB),KC_END,
        // right hand
        KC_PGUP,     KC_6,   KC_7,   KC_8,   KC_9,   KC_0,             KC_MINS,
        KC_RBRACKET, KC_Y,   KC_U,   KC_I,   KC_O,   KC_P,             KC_LBRACKET,
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

/* Return an integer that corresponds to what kind of tap dance should be executed.
 *
 * How to figure out tap dance state: interrupted and pressed.
 *
 * Interrupted: If the state of a dance dance is "interrupted", that means that another key has been hit
 *  under the tapping term. This is typically indicitive that you are trying to "tap" the key.
 *
 * Pressed: Whether or not the key is still being pressed. If this value is true, that means the tapping term
 *  has ended, but the key is still being pressed down. This generally means the key is being "held".
 *
 * One thing that is currenlty not possible with qmk software in regards to tap dance is to mimic the "permissive hold"
 *  feature. In general, advanced tap dances do not work well if they are used with commonly typed letters.
 *  For example "A". Tap dances are best used on non-letter keys that are not hit while typing letters.
 *
 * Good places to put an advanced tap dance:
 *  z,q,x,j,k,v,b, any function key, home/end, comma, semi-colon
 *
 * Criteria for "good placement" of a tap dance key:
 *  Not a key that is hit frequently in a sentence
 *  Not a key that is used frequently to double tap, for example 'tab' is often double tapped in a terminal, or
 *    in a web form. So 'tab' would be a poor choice for a tap dance.
 *  Letters used in common words as a double. For example 'p' in 'pepper'. If a tap dance function existed on the
 *    letter 'p', the word 'pepper' would be quite frustating to type.
 *
 * For the third point, there does exist the 'DOUBLE_SINGLE_TAP', however this is not fully tested
 *
 */
// To activate SINGLE_HOLD, you will need to hold for 200ms first.
// This tap dance favors keys that are used frequently in typing like 'f'
int cur_dance (qk_tap_dance_state_t *state) {
  if (state->count == 1) {
    //If count = 1, and it has been interrupted - it doesn't matter if it is pressed or not: Send SINGLE_TAP
    if (state->interrupted) {
      //     if (!state->pressed) return SINGLE_TAP;
      //need "permissive hold" here.
      //     else return SINsGLE_HOLD;
      //If the interrupting key is released before the tap-dance key, then it is a single HOLD
      //However, if the tap-dance key is released first, then it is a single TAP
      //But how to get access to the state of the interrupting key????
      return SINGLE_TAP;
    }
    else {
      if (!state->pressed) return SINGLE_TAP;
      else return SINGLE_HOLD;
    }
  }
  //If count = 2, and it has been interrupted - assume that user is trying to type the letter associated
  //with single tap.
  else if (state->count == 2) {
    if (state->interrupted) return DOUBLE_SINGLE_TAP;
    else if (state->pressed) return DOUBLE_HOLD;
    else return DOUBLE_TAP;
  }
  else if ((state->count == 3) && ((state->interrupted) || (!state->pressed))) return TRIPLE_TAP;
  else if (state->count == 3) return TRIPLE_HOLD;
  else return 8; //magic number. At some point this method will expand to work for more presses
}

//This works well if you want this key to work as a "fast modifier". It favors being held over being tapped.
int hold_cur_dance (qk_tap_dance_state_t *state) {
  if (state->count == 1) {
    if (state->interrupted) {
      if (!state->pressed) return SINGLE_TAP;
      else return SINGLE_HOLD;
    }
    else {
      if (!state->pressed) return SINGLE_TAP;
      else return SINGLE_HOLD;
    }
  }
  //If count = 2, and it has been interrupted - assume that user is trying to type the letter associated
  //with single tap.
  else if (state->count == 2) {
    if (state->pressed) return DOUBLE_HOLD;
    else return DOUBLE_TAP;
  }
  else if (state->count == 3) {
    if (!state->pressed) return TRIPLE_TAP;
    else return TRIPLE_HOLD;
  }
  else return 8; //magic number. At some point this method will expand to work for more presses
}

//*************** SUPER Z *******************//
// Assumption: we don't care about trying to hit zz quickly
//*************** SUPER Z *******************//

//instanalize an instance of 'tap' for the 'z' tap dance.
static tap ztap_state = {
  .is_press_action = true,
  .state = 0
};

void z_finished (qk_tap_dance_state_t *state, void *user_data) {
  ztap_state.state = hold_cur_dance(state); //Use the dance that favors being held
  switch (ztap_state.state) {
    case SINGLE_TAP: register_code(KC_Z); break;
    case SINGLE_HOLD: layer_on(SYMB); break; //turn on symbols layer
  }
}

void z_reset (qk_tap_dance_state_t *state, void *user_data) {
  switch (ztap_state.state) {
    case SINGLE_TAP: unregister_code(KC_Z); break; //unregister z
    case SINGLE_HOLD: layer_off(SYMB); break;
  }
  ztap_state.state = 0;
}


qk_tap_dance_action_t tap_dance_actions[] = {
    // semicolon on single tap, colon on double tap
    [CT_CLN] = ACTION_TAP_DANCE_DOUBLE (KC_SCLN, KC_COLN),

    [CT_BASE] = ACTION_TAP_DANCE_DUAL_ROLE (KC_TRNS, BASE),

    [Z_CTL] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, z_finished, z_reset),

};
