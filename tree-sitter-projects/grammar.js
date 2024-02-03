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
      $.text
    ),

    project_children: $ => choice(
        $.child_project,
        $.comment
      ),

    project_grandchildren: $ => choice(
      $.grandchild_project,
      $.child_comment
    ),

    comment: $ => seq(
      '+',
      $.text
    ),

    child_comment: $ => seq(
      '++',
      $.text
    ),

    text: $ => /[a-zA-Z0-9_ ]+/,

  }
});

