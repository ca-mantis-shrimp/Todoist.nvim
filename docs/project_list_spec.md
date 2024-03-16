This Specification is intended to provide a light overview of the simple project list filetype, known hereafter as "projects" or used on a file as <file_name>.projects

This filetype is intended to largely cover the functionality covered within the normal side-bar within todoist so that users can have a similar visual experience to the native todoist app while facilitating increased functionality and control over the project list

# Why Make This Filetype?
creating a dedicated filetype for this view will allow us to define and implement the structure of the filetype separately from the implementation, allowing users to reason about the filetype before they look at it or extend it with their own functionality

We are also looking to create a more robust and powerful project list view than the native todoist app, allowing users to have more control over their project list control the entire todoist project process from a single file

## Use-Case
The primary use-case for this filetype will be a visual layer on Neovim. While this filetype will have the ability to represent a list of projects in various states, the todoist application is a centralized, server-based application so the functionality will be defined through the REST api instead.

Rather, this filetype will facilitate proper handling of the buffer to allow things like syntax highlighting and automatic management of the buffer according to the standards set out in this document

If you are wanting to add to the functionality of the filetype, please refer here first for filetype guidelines before diving into the implementation code to ensure any changes you add will conform to the spec laid out here.

This also give community members the opportunity to propose changes to the spec without involving production code changes. 
Users can post changes to this document first if they intend to change the filetype logic, and can give the community the chance to evaluate the philosphy behind a change without needing to read any implementation code

Specifically (pun intended), we want users to be able to easily show the list of projects as a split on either side of their monitor to mirror the experience of something like a file explorer where users can see their list of projects and the underlying string comments at a glance

## Specification Philosophy
This is intended to be an open specification, meaning that it can:
- Handle changes that add potential functionality or structure without breaking existing functionality
- While avoiding any breaking changes to the spec to ensure users can rely on current code for upcoming years

This means we can start small with the spec and gradually add functionality, without an explicit version flag
- However, this also means we will not be able to accommodate any breaking changes within the current spec

For example, while I currently have no plans to accomodate tasks within this filetype, this functionality could be added due to popular demand with a non-breaking change to the specification later down the line.

### Verbage
To that point, since Todoist only allows 5 levels of nesting when it comes to projects, meaning that we can easily distinguish between the 5 levels:
- Root
- Child
- Grandchild
- Great Grandchild
- Leaf

The first and last levels are calling back to the fact that this is infact a tree structure and we can use these words to distinguish between the different levels of nesting for:
- Projects
- Comments
- Tasks(?)

###  White Space
A note on the usage of whitespace before we continue. 
Users will notice a distinct lack of meaning placed on the whitespace for the specification. Specifically, while white space can be used during the implementation phase to increase visual clarity for the reader based on these rules, this specification will largely ignore the need for whitespace for the sake of specification compliance

White space based files like Markdown result in complex parsers that can be difficult to implement and reason about.

The lack of empnasis on whitespace should reduce the ambiguity around parsers and make creating formatted files easier for users
- This also give design space to developers to work out what visual language to express to the user as long as all other specifications are met

### Breaking Change Edge Case
Should a breaking change be required, we will need to create a new filetype with a new extension, and will need to create a migration tool to migrate the old filetype to the new filetype

This tracks with the philosophy of growth over time while giving teams the ability to experiment with new filetypes should the need for a new, breaking change arise within the spec

A good example of this would be if Todoist ever started supporting multiple parents to a single project since this would require a complete re-design of the buffer to accomodate this theoretical functionality, and would be better off being implemented as a new filetype rather than a breaking change to this one

# Syntax
The project list is a simple list of projects, with each project being denoted by a `#` character, followed by the `<SPC>`(Space) and the description of the project
- This character was chosen to mirror the format of the web application which as of 1/30/2024 uses the pound character to represent the project

The list must always start with the inbox project since it is garunteed to exist per with GTD methodology and is the beginning project from which all tasks and projects emerge

Meaning the beginning of each file will start with the following line:
`# Inbox`

More importantly, when we think about the lack of whitespace, we will see this throughout the various notation levels to distinguish between the various nesting levels for various concepts
Meaning, instead of relying on whitespace to tell if a comment is under a project or the child project, we will use the recurring notation instead so a comment for a root project is `+` while the comment for a child project is `++` and so on.

## Hierarchy
One of the primary features given by todoist is the ability to define a nested hierarchy of projects, giving users the ability to nest several projects under a single project

We will be using increasing orders of the `#` character to denote that a `##` project represents a child of the next highest `#` project
- While Todoist stops at supporting 4 levels of nesting, there is no reason the specification cant support arbitrary amounts of nesting

This was chosen because the projects are often going to be shown as a small split on either side of the screen, so taking an approach that utilized primarily white space would be harder to parse and would waste precious screen real-estate

### Comments
Todoist Projects can have 0 or more comments attached to them after creation
- While a buffer is unable to represent pictures and voice recordings (as of this writing), it should be able to represent string comments with ease

comments are represented by atleast two instances of the `+` character, followed by the comment string, and should mirror the hierarchy level of the parent project to ensure visual consistency

So a single level project with a single comment might look like:
`# Project`
`++ This is a comment`

While a comment for a child project might look like :
`# Project`
`## Child Project`
`+++ This is a comment`
`## Project with Hidden Comment`

Like projects, comments should be shown hidden using the collapsed character of the parent project when relevant so that users can see if a parent has either a child project or comment attached to it

### An explanation for the multiple collapsed icons
In order to support an optional collapsed icon, we must then allow for the possibility of a project with no children and this ambiguity can leading to parsing errors

To counter this, a collapsed icon must match the level of repition of the project icon in order to make it dis-ambiguous as to what level the comment represents
## Archived and Deleted Projects
Deleted Projects can be preserved in the project list for historical purposes, and are denoted by the `x` character before the project icon

Therefore, a deleted project would look like:
`x# Deleted Project`

While an archived project would look like:
`a# Archived Project`

## Markdown In Project Descriptions and Comments
Todoist supports a subset of the markdown specification in both the project description as well as the comments themselves, and therefore, these fields should keep in lock-step with the list of [https://www.markdownguide.org/tools/todoist/](The list of supported Markdown)

Anything New?

