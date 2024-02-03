#include <tree_sitter/parser.h>

#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wmissing-field-initializers"
#endif

#define LANGUAGE_VERSION 14
#define STATE_COUNT 21
#define LARGE_STATE_COUNT 5
#define SYMBOL_COUNT 18
#define ALIAS_COUNT 0
#define TOKEN_COUNT 7
#define EXTERNAL_TOKEN_COUNT 0
#define FIELD_COUNT 0
#define MAX_ALIAS_SEQUENCE_LENGTH 3
#define PRODUCTION_ID_COUNT 1

enum {
  anon_sym_POUND = 1,
  anon_sym_POUND_POUND = 2,
  anon_sym_POUND_POUND_POUND = 3,
  anon_sym_PLUS = 4,
  anon_sym_PLUS_PLUS = 5,
  sym_text = 6,
  sym_source_file = 7,
  sym_project = 8,
  sym_child_project = 9,
  sym_grandchild_project = 10,
  sym_project_children = 11,
  sym_project_grandchildren = 12,
  sym_comment = 13,
  sym_child_comment = 14,
  aux_sym_source_file_repeat1 = 15,
  aux_sym_project_repeat1 = 16,
  aux_sym_child_project_repeat1 = 17,
};

static const char * const ts_symbol_names[] = {
  [ts_builtin_sym_end] = "end",
  [anon_sym_POUND] = "#",
  [anon_sym_POUND_POUND] = "##",
  [anon_sym_POUND_POUND_POUND] = "###",
  [anon_sym_PLUS] = "+",
  [anon_sym_PLUS_PLUS] = "++",
  [sym_text] = "text",
  [sym_source_file] = "source_file",
  [sym_project] = "project",
  [sym_child_project] = "child_project",
  [sym_grandchild_project] = "grandchild_project",
  [sym_project_children] = "project_children",
  [sym_project_grandchildren] = "project_grandchildren",
  [sym_comment] = "comment",
  [sym_child_comment] = "child_comment",
  [aux_sym_source_file_repeat1] = "source_file_repeat1",
  [aux_sym_project_repeat1] = "project_repeat1",
  [aux_sym_child_project_repeat1] = "child_project_repeat1",
};

static const TSSymbol ts_symbol_map[] = {
  [ts_builtin_sym_end] = ts_builtin_sym_end,
  [anon_sym_POUND] = anon_sym_POUND,
  [anon_sym_POUND_POUND] = anon_sym_POUND_POUND,
  [anon_sym_POUND_POUND_POUND] = anon_sym_POUND_POUND_POUND,
  [anon_sym_PLUS] = anon_sym_PLUS,
  [anon_sym_PLUS_PLUS] = anon_sym_PLUS_PLUS,
  [sym_text] = sym_text,
  [sym_source_file] = sym_source_file,
  [sym_project] = sym_project,
  [sym_child_project] = sym_child_project,
  [sym_grandchild_project] = sym_grandchild_project,
  [sym_project_children] = sym_project_children,
  [sym_project_grandchildren] = sym_project_grandchildren,
  [sym_comment] = sym_comment,
  [sym_child_comment] = sym_child_comment,
  [aux_sym_source_file_repeat1] = aux_sym_source_file_repeat1,
  [aux_sym_project_repeat1] = aux_sym_project_repeat1,
  [aux_sym_child_project_repeat1] = aux_sym_child_project_repeat1,
};

static const TSSymbolMetadata ts_symbol_metadata[] = {
  [ts_builtin_sym_end] = {
    .visible = false,
    .named = true,
  },
  [anon_sym_POUND] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_POUND_POUND] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_POUND_POUND_POUND] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_PLUS] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_PLUS_PLUS] = {
    .visible = true,
    .named = false,
  },
  [sym_text] = {
    .visible = true,
    .named = true,
  },
  [sym_source_file] = {
    .visible = true,
    .named = true,
  },
  [sym_project] = {
    .visible = true,
    .named = true,
  },
  [sym_child_project] = {
    .visible = true,
    .named = true,
  },
  [sym_grandchild_project] = {
    .visible = true,
    .named = true,
  },
  [sym_project_children] = {
    .visible = true,
    .named = true,
  },
  [sym_project_grandchildren] = {
    .visible = true,
    .named = true,
  },
  [sym_comment] = {
    .visible = true,
    .named = true,
  },
  [sym_child_comment] = {
    .visible = true,
    .named = true,
  },
  [aux_sym_source_file_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_project_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_child_project_repeat1] = {
    .visible = false,
    .named = false,
  },
};

static const TSSymbol ts_alias_sequences[PRODUCTION_ID_COUNT][MAX_ALIAS_SEQUENCE_LENGTH] = {
  [0] = {0},
};

static const uint16_t ts_non_terminal_alias_map[] = {
  0,
};

static const TSStateId ts_primary_state_ids[STATE_COUNT] = {
  [0] = 0,
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16,
  [17] = 17,
  [18] = 18,
  [19] = 19,
  [20] = 20,
};

static bool ts_lex(TSLexer *lexer, TSStateId state) {
  START_LEXER();
  eof = lexer->eof(lexer);
  switch (state) {
    case 0:
      if (eof) ADVANCE(2);
      if (lookahead == '#') ADVANCE(3);
      if (lookahead == '+') ADVANCE(6);
      if (lookahead == '\t' ||
          lookahead == '\n' ||
          lookahead == '\r' ||
          lookahead == ' ') SKIP(0)
      END_STATE();
    case 1:
      if (lookahead == ' ') ADVANCE(8);
      if (lookahead == '\t' ||
          lookahead == '\n' ||
          lookahead == '\r') SKIP(1)
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(9);
      END_STATE();
    case 2:
      ACCEPT_TOKEN(ts_builtin_sym_end);
      END_STATE();
    case 3:
      ACCEPT_TOKEN(anon_sym_POUND);
      if (lookahead == '#') ADVANCE(4);
      END_STATE();
    case 4:
      ACCEPT_TOKEN(anon_sym_POUND_POUND);
      if (lookahead == '#') ADVANCE(5);
      END_STATE();
    case 5:
      ACCEPT_TOKEN(anon_sym_POUND_POUND_POUND);
      END_STATE();
    case 6:
      ACCEPT_TOKEN(anon_sym_PLUS);
      if (lookahead == '+') ADVANCE(7);
      END_STATE();
    case 7:
      ACCEPT_TOKEN(anon_sym_PLUS_PLUS);
      END_STATE();
    case 8:
      ACCEPT_TOKEN(sym_text);
      if (lookahead == ' ') ADVANCE(8);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(9);
      END_STATE();
    case 9:
      ACCEPT_TOKEN(sym_text);
      if (lookahead == ' ' ||
          ('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(9);
      END_STATE();
    default:
      return false;
  }
}

static const TSLexMode ts_lex_modes[STATE_COUNT] = {
  [0] = {.lex_state = 0},
  [1] = {.lex_state = 0},
  [2] = {.lex_state = 0},
  [3] = {.lex_state = 0},
  [4] = {.lex_state = 0},
  [5] = {.lex_state = 0},
  [6] = {.lex_state = 0},
  [7] = {.lex_state = 0},
  [8] = {.lex_state = 0},
  [9] = {.lex_state = 0},
  [10] = {.lex_state = 0},
  [11] = {.lex_state = 0},
  [12] = {.lex_state = 0},
  [13] = {.lex_state = 0},
  [14] = {.lex_state = 0},
  [15] = {.lex_state = 1},
  [16] = {.lex_state = 1},
  [17] = {.lex_state = 1},
  [18] = {.lex_state = 1},
  [19] = {.lex_state = 1},
  [20] = {.lex_state = 0},
};

static const uint16_t ts_parse_table[LARGE_STATE_COUNT][SYMBOL_COUNT] = {
  [0] = {
    [ts_builtin_sym_end] = ACTIONS(1),
    [anon_sym_POUND] = ACTIONS(1),
    [anon_sym_POUND_POUND] = ACTIONS(1),
    [anon_sym_POUND_POUND_POUND] = ACTIONS(1),
    [anon_sym_PLUS] = ACTIONS(1),
    [anon_sym_PLUS_PLUS] = ACTIONS(1),
  },
  [1] = {
    [sym_source_file] = STATE(20),
    [sym_project] = STATE(14),
    [aux_sym_source_file_repeat1] = STATE(14),
    [ts_builtin_sym_end] = ACTIONS(3),
    [anon_sym_POUND] = ACTIONS(5),
  },
  [2] = {
    [sym_grandchild_project] = STATE(8),
    [sym_project_grandchildren] = STATE(2),
    [sym_child_comment] = STATE(8),
    [aux_sym_child_project_repeat1] = STATE(2),
    [ts_builtin_sym_end] = ACTIONS(7),
    [anon_sym_POUND] = ACTIONS(9),
    [anon_sym_POUND_POUND] = ACTIONS(9),
    [anon_sym_POUND_POUND_POUND] = ACTIONS(11),
    [anon_sym_PLUS] = ACTIONS(9),
    [anon_sym_PLUS_PLUS] = ACTIONS(14),
  },
  [3] = {
    [sym_grandchild_project] = STATE(8),
    [sym_project_grandchildren] = STATE(2),
    [sym_child_comment] = STATE(8),
    [aux_sym_child_project_repeat1] = STATE(2),
    [ts_builtin_sym_end] = ACTIONS(17),
    [anon_sym_POUND] = ACTIONS(19),
    [anon_sym_POUND_POUND] = ACTIONS(19),
    [anon_sym_POUND_POUND_POUND] = ACTIONS(21),
    [anon_sym_PLUS] = ACTIONS(19),
    [anon_sym_PLUS_PLUS] = ACTIONS(23),
  },
  [4] = {
    [sym_grandchild_project] = STATE(8),
    [sym_project_grandchildren] = STATE(3),
    [sym_child_comment] = STATE(8),
    [aux_sym_child_project_repeat1] = STATE(3),
    [ts_builtin_sym_end] = ACTIONS(25),
    [anon_sym_POUND] = ACTIONS(27),
    [anon_sym_POUND_POUND] = ACTIONS(27),
    [anon_sym_POUND_POUND_POUND] = ACTIONS(21),
    [anon_sym_PLUS] = ACTIONS(27),
    [anon_sym_PLUS_PLUS] = ACTIONS(23),
  },
};

static const uint16_t ts_small_parse_table[] = {
  [0] = 6,
    ACTIONS(29), 1,
      ts_builtin_sym_end,
    ACTIONS(31), 1,
      anon_sym_POUND,
    ACTIONS(33), 1,
      anon_sym_POUND_POUND,
    ACTIONS(35), 1,
      anon_sym_PLUS,
    STATE(7), 2,
      sym_project_children,
      aux_sym_project_repeat1,
    STATE(12), 2,
      sym_child_project,
      sym_comment,
  [21] = 6,
    ACTIONS(33), 1,
      anon_sym_POUND_POUND,
    ACTIONS(35), 1,
      anon_sym_PLUS,
    ACTIONS(37), 1,
      ts_builtin_sym_end,
    ACTIONS(39), 1,
      anon_sym_POUND,
    STATE(5), 2,
      sym_project_children,
      aux_sym_project_repeat1,
    STATE(12), 2,
      sym_child_project,
      sym_comment,
  [42] = 6,
    ACTIONS(41), 1,
      ts_builtin_sym_end,
    ACTIONS(43), 1,
      anon_sym_POUND,
    ACTIONS(45), 1,
      anon_sym_POUND_POUND,
    ACTIONS(48), 1,
      anon_sym_PLUS,
    STATE(7), 2,
      sym_project_children,
      aux_sym_project_repeat1,
    STATE(12), 2,
      sym_child_project,
      sym_comment,
  [63] = 2,
    ACTIONS(51), 3,
      ts_builtin_sym_end,
      anon_sym_POUND_POUND_POUND,
      anon_sym_PLUS_PLUS,
    ACTIONS(53), 3,
      anon_sym_POUND,
      anon_sym_POUND_POUND,
      anon_sym_PLUS,
  [74] = 2,
    ACTIONS(55), 3,
      ts_builtin_sym_end,
      anon_sym_POUND_POUND_POUND,
      anon_sym_PLUS_PLUS,
    ACTIONS(57), 3,
      anon_sym_POUND,
      anon_sym_POUND_POUND,
      anon_sym_PLUS,
  [85] = 2,
    ACTIONS(59), 3,
      ts_builtin_sym_end,
      anon_sym_POUND_POUND_POUND,
      anon_sym_PLUS_PLUS,
    ACTIONS(61), 3,
      anon_sym_POUND,
      anon_sym_POUND_POUND,
      anon_sym_PLUS,
  [96] = 3,
    ACTIONS(63), 1,
      ts_builtin_sym_end,
    ACTIONS(65), 1,
      anon_sym_POUND,
    STATE(11), 2,
      sym_project,
      aux_sym_source_file_repeat1,
  [107] = 2,
    ACTIONS(70), 1,
      anon_sym_POUND,
    ACTIONS(68), 3,
      ts_builtin_sym_end,
      anon_sym_POUND_POUND,
      anon_sym_PLUS,
  [116] = 2,
    ACTIONS(74), 1,
      anon_sym_POUND,
    ACTIONS(72), 3,
      ts_builtin_sym_end,
      anon_sym_POUND_POUND,
      anon_sym_PLUS,
  [125] = 3,
    ACTIONS(5), 1,
      anon_sym_POUND,
    ACTIONS(76), 1,
      ts_builtin_sym_end,
    STATE(11), 2,
      sym_project,
      aux_sym_source_file_repeat1,
  [136] = 1,
    ACTIONS(78), 1,
      sym_text,
  [140] = 1,
    ACTIONS(80), 1,
      sym_text,
  [144] = 1,
    ACTIONS(82), 1,
      sym_text,
  [148] = 1,
    ACTIONS(84), 1,
      sym_text,
  [152] = 1,
    ACTIONS(86), 1,
      sym_text,
  [156] = 1,
    ACTIONS(88), 1,
      ts_builtin_sym_end,
};

static const uint32_t ts_small_parse_table_map[] = {
  [SMALL_STATE(5)] = 0,
  [SMALL_STATE(6)] = 21,
  [SMALL_STATE(7)] = 42,
  [SMALL_STATE(8)] = 63,
  [SMALL_STATE(9)] = 74,
  [SMALL_STATE(10)] = 85,
  [SMALL_STATE(11)] = 96,
  [SMALL_STATE(12)] = 107,
  [SMALL_STATE(13)] = 116,
  [SMALL_STATE(14)] = 125,
  [SMALL_STATE(15)] = 136,
  [SMALL_STATE(16)] = 140,
  [SMALL_STATE(17)] = 144,
  [SMALL_STATE(18)] = 148,
  [SMALL_STATE(19)] = 152,
  [SMALL_STATE(20)] = 156,
};

static const TSParseActionEntry ts_parse_actions[] = {
  [0] = {.entry = {.count = 0, .reusable = false}},
  [1] = {.entry = {.count = 1, .reusable = false}}, RECOVER(),
  [3] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_source_file, 0),
  [5] = {.entry = {.count = 1, .reusable = true}}, SHIFT(17),
  [7] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_child_project_repeat1, 2),
  [9] = {.entry = {.count = 1, .reusable = false}}, REDUCE(aux_sym_child_project_repeat1, 2),
  [11] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_child_project_repeat1, 2), SHIFT_REPEAT(18),
  [14] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_child_project_repeat1, 2), SHIFT_REPEAT(19),
  [17] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_child_project, 3),
  [19] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_child_project, 3),
  [21] = {.entry = {.count = 1, .reusable = true}}, SHIFT(18),
  [23] = {.entry = {.count = 1, .reusable = true}}, SHIFT(19),
  [25] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_child_project, 2),
  [27] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_child_project, 2),
  [29] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_project, 3),
  [31] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_project, 3),
  [33] = {.entry = {.count = 1, .reusable = true}}, SHIFT(15),
  [35] = {.entry = {.count = 1, .reusable = true}}, SHIFT(16),
  [37] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_project, 2),
  [39] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_project, 2),
  [41] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_project_repeat1, 2),
  [43] = {.entry = {.count = 1, .reusable = false}}, REDUCE(aux_sym_project_repeat1, 2),
  [45] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_project_repeat1, 2), SHIFT_REPEAT(15),
  [48] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_project_repeat1, 2), SHIFT_REPEAT(16),
  [51] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_project_grandchildren, 1),
  [53] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_project_grandchildren, 1),
  [55] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_grandchild_project, 2),
  [57] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_grandchild_project, 2),
  [59] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_child_comment, 2),
  [61] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_child_comment, 2),
  [63] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_source_file_repeat1, 2),
  [65] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_source_file_repeat1, 2), SHIFT_REPEAT(17),
  [68] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_project_children, 1),
  [70] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_project_children, 1),
  [72] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_comment, 2),
  [74] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_comment, 2),
  [76] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_source_file, 1),
  [78] = {.entry = {.count = 1, .reusable = true}}, SHIFT(4),
  [80] = {.entry = {.count = 1, .reusable = true}}, SHIFT(13),
  [82] = {.entry = {.count = 1, .reusable = true}}, SHIFT(6),
  [84] = {.entry = {.count = 1, .reusable = true}}, SHIFT(9),
  [86] = {.entry = {.count = 1, .reusable = true}}, SHIFT(10),
  [88] = {.entry = {.count = 1, .reusable = true}},  ACCEPT_INPUT(),
};

#ifdef __cplusplus
extern "C" {
#endif
#ifdef _WIN32
#define extern __declspec(dllexport)
#endif

extern const TSLanguage *tree_sitter_projects(void) {
  static const TSLanguage language = {
    .version = LANGUAGE_VERSION,
    .symbol_count = SYMBOL_COUNT,
    .alias_count = ALIAS_COUNT,
    .token_count = TOKEN_COUNT,
    .external_token_count = EXTERNAL_TOKEN_COUNT,
    .state_count = STATE_COUNT,
    .large_state_count = LARGE_STATE_COUNT,
    .production_id_count = PRODUCTION_ID_COUNT,
    .field_count = FIELD_COUNT,
    .max_alias_sequence_length = MAX_ALIAS_SEQUENCE_LENGTH,
    .parse_table = &ts_parse_table[0][0],
    .small_parse_table = ts_small_parse_table,
    .small_parse_table_map = ts_small_parse_table_map,
    .parse_actions = ts_parse_actions,
    .symbol_names = ts_symbol_names,
    .symbol_metadata = ts_symbol_metadata,
    .public_symbol_map = ts_symbol_map,
    .alias_map = ts_non_terminal_alias_map,
    .alias_sequences = &ts_alias_sequences[0][0],
    .lex_modes = ts_lex_modes,
    .lex_fn = ts_lex,
    .primary_state_ids = ts_primary_state_ids,
  };
  return &language;
}
#ifdef __cplusplus
}
#endif
