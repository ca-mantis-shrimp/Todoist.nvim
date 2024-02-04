module.exports = grammar({
  name: 'projects',

  rules: {
    source_file: $ => repeat($.root_project),

    root_project: $ => seq(
      '#',
      optional($.collapsed_icon),
      $.text,
      optional(repeat($.project_children))
    ),

    child_project: $ => seq(
      '##',
      optional($.collapsed_icon),
      $.text,
      optional(repeat($.project_grandchildren))
    ),

    grandchild_project: $ => seq(
      '###',
      optional($.collapsed_icon),
      $.text,
      optional(repeat($.project_great_grandchildren))
    ),

    great_grandchild_project: $ => seq(
      '####',
      optional($.collapsed_icon),
      $.text,
      optional(repeat($.leaf_children))
    ),

    leaf_project: $ => seq(
      '#####',
      optional($.collapsed_icon),
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
      '++',
      $.text
    ),

    child_comment: $ => seq(
      '+++',
      $.text
    ),

    grandchild_comment: $ => seq(
      '++++',
      $.text
    ),

    great_grandchild_comment: $ => seq(
      '+++++',
      $.text
    ),

    leaf_comment: $ => seq(
      '++++++',
      $.text
    ),

    text: $ => /[a-zA-Z0-9_ ]+/,

    collapsed_icon: $ => choice(
      $.collapsed,
      $.not_collapsed,
      $.no_children
    ),

    collapsed: $ => '> ',
    not_collapsed: $ => 'v ',
    no_children: $ => ' '
  }
});

