module.exports = grammar({
  name: 'projects',

  rules: {
    source_file: $ => repeat($.root_project),

    root_project: $ => seq(
      optional($.root_collapsed_icon),
      '#',
      $.text,
      optional(repeat($.project_children))
    ),

    child_project: $ => seq(
      optional($.child_collapsed_icon),
      '##',
      $.text,
      optional(repeat($.project_grandchildren))
    ),

    grandchild_project: $ => seq(
      optional($.grandchild_collapsed_icon),
      '###',
      $.text,
      optional(repeat($.project_great_grandchildren))
    ),

    great_grandchild_project: $ => seq(
      optional($.great_grandchild_collapsed_icon),
      '####',
      $.text,
      optional(repeat($.leaf_children))
    ),

    leaf_project: $ => seq(
      optional($.leaf_collapsed_icon),
      '#####',
      $.text,
      optional(repeat($.leaf_comment))
    ),

    project_children: $ => choice(
        $.child_project,
        $.root_comment
      ),

    project_grandchildren: $ => choice(
      $.grandchild_project,
      $.child_comment
    ),

    project_great_grandchildren: $ => choice(
      $.great_grandchild_project,
      $.grandchild_comment
    ),

    leaf_children: $ => choice(
      $.leaf_project,
      $.great_grandchild_comment
    ),

    root_comment: $ => seq(
      '+',
      $.text
    ),

    child_comment: $ => seq(
      '++',
      $.text
    ),

    grandchild_comment: $ => seq(
      '+++',
      $.text
    ),

    great_grandchild_comment: $ => seq(
      '++++',
      $.text
    ),

    leaf_comment: $ => seq(
      '+++++',
      $.text
    ),

    text: $ => /[a-zA-Z0-9_ ]+/,

    root_collapsed_icon: $ => choice(
      $.root_collapsed,
      $.root_not_collapsed
    ),

    child_collapsed_icon: $ => choice(
      $.child_collapsed,
      $.child_not_collapsed
    ),

    grandchild_collapsed_icon: $ => choice(
      $.grandchild_collapsed,
      $.grandchild_not_collapsed
    ),

    great_grandchild_collapsed_icon: $ => choice(
      $.great_grandchild_collapsed,
      $.great_grandchild_not_collapsed
    ),
    leaf_collapsed_icon: $ => choice(
      $.leaf_collapsed,
      $.leaf_not_collapsed
    ),
    root_collapsed: $ => '> ',
    root_not_collapsed: $ => 'v ',

    child_collapsed: $ => '>> ',
    child_not_collapsed: $ => 'vv ',

    grandchild_collapsed: $ => '>>> ',
    grandchild_not_collapsed: $ => 'vvv ',

    great_grandchild_collapsed: $ => '>>>> ',
    great_grandchild_not_collapsed: $ => 'vvvv ',

    leaf_collapsed: $ => '>>>>> ',
    leaf_not_collapsed: $ => 'vvvvv ',

  }
});

