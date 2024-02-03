module.exports = grammar({
  name: 'projects',

  rules: {
    source_file: $ => repeat($.project),

    project: $ => seq(
      '#',
      $.text,
      optional(repeat($.project_children))
    ),

    child_project: $ => seq(
      '##',
      $.text,
      optional(repeat($.project_grandchildren))
    ),

    grandchild_project: $ => seq(
      '###',
      $.text,
      optional(repeat($.project_great_grandchildren))
    ),

    great_grandchild_project: $ => seq(
      '####',
      $.text,
      optional(repeat($.leaf_children))
    ),

    leaf_project: $ => seq(
      '#####',
      $.text,
      optional(repeat($.leaf_comment))
    ),

    project_children: $ => choice(
        $.child_project,
        $.comment
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

    comment: $ => seq(
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

  }
});

