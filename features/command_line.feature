Feature: Command Line
  In order to manage my stylesheets
  As a user on the command line
  I want to create a new project

  Scenario: Install a project without a framework
    When I create a project using: compass create my_project
    Then a directory my_project/ is created
    And a configuration file my_project/config.rb is created
    And a sass file my_project/sass/screen.scss is created
    And a sass file my_project/sass/print.scss is created
    And a sass file my_project/sass/ie.scss is created
    And a css file my_project/stylesheets/screen.css is created
    And a css file my_project/stylesheets/print.css is created
    And a css file my_project/stylesheets/ie.css is created
    And I am told how to link to /stylesheets/screen.css for media "screen, projection"
    And I am told how to link to /stylesheets/print.css for media "print"
    And I am told how to conditionally link "IE" to /stylesheets/ie.css for media "screen, projection"

  Scenario: Install a project without a framework and separate output-dir
    Given I should clean up the directory: my_project_output
    When I create a project using: compass create my_project --output-dir my_project_output
    Then a directory my_project/ is created
    And a directory my_project_output/ is created
    And a configuration file my_project/config.rb is created
    And a sass file my_project/sass/screen.scss is created
    And a sass file my_project/sass/print.scss is created
    And a sass file my_project/sass/ie.scss is created
    And a css file my_project_output/screen.css is created
    And a css file my_project_output/print.css is created
    And a css file my_project_output/ie.css is created
    And I am told how to link to /stylesheets/screen.css for media "screen, projection"
    And I am told how to link to /stylesheets/print.css for media "print"
    And I am told how to conditionally link "IE" to /stylesheets/ie.css for media "screen, projection"

  Scenario: Install a project with specific directories
    When I create a project using: compass create custom_project --using compass --sass-dir sass --css-dir css --images-dir assets/imgs
    Then a directory custom_project/ is created
    And a directory custom_project/sass/ is created
    And a directory custom_project/css/ is created
    And a sass file custom_project/sass/screen.scss is created
    And a css file custom_project/css/screen.css is created

  Scenario: Install a project with specific directories and separate output dir
    Given I should clean up the directory: custom_project_css
    When I create a project using: compass create custom_project --using compass --sass-dir sass --css-dir css --images-dir assets/imgs --output-dir custom_project_css
    Then a directory custom_project/ is created
    And a directory custom_project_css/ is created
    And a directory custom_project/sass/ is created
    And a directory custom_project/css/ is created
    And a sass file custom_project/sass/screen.scss is created
    And a css file custom_project_css/screen.css is created

  Scenario: Perform a dry run of creating a project
    When I create a project using: compass create my_project --dry-run
    Then a directory my_project/ is not created
    But a configuration file my_project/config.rb is reported created
    And a sass file my_project/sass/screen.scss is reported created
    And a sass file my_project/sass/print.scss is reported created
    And a sass file my_project/sass/ie.scss is reported created
    And I am told how to link to /stylesheets/screen.css for media "screen, projection"
    And I am told how to link to /stylesheets/print.css for media "print"
    And I am told how to conditionally link "IE" to /stylesheets/ie.css for media "screen, projection"

  Scenario: Perform a dry run of creating a project with separate output dir
    When I create a project using: compass create my_project --output-dir my_project_dir --dry-run
    Then a directory my_project/ is not created
    And a directory my_project_dir/ is not created
    But a configuration file my_project/config.rb is reported created
    And a sass file my_project/sass/screen.scss is reported created
    And a sass file my_project/sass/print.scss is reported created
    And a sass file my_project/sass/ie.scss is reported created
    And I am told how to link to /stylesheets/screen.css for media "screen, projection"
    And I am told how to link to /stylesheets/print.css for media "print"
    And I am told how to conditionally link "IE" to /stylesheets/ie.css for media "screen, projection"

  Scenario: Creating a bare project
    When I create a project using: compass create bare_project --bare
    Then a directory bare_project/ is created
    And a configuration file bare_project/config.rb is created
    And a directory bare_project/sass/ is created
    And a directory bare_project/stylesheets/ is not created
    And I am congratulated
    And I am told that I can place stylesheets in the sass subdirectory
    And I am told how to compile my sass stylesheets

  Scenario: Creating a bare project with separate output dir
    When I create a project using: compass create bare_project --bare --output-dir bare_output
    Then a directory bare_project/ is created
    And a directory bare_output/ is not created
    And a configuration file bare_project/config.rb is created
    And a directory bare_project/sass/ is created
    And a directory bare_project/stylesheets/ is not created
    And I am congratulated
    And I am told that I can place stylesheets in the sass subdirectory
    And I am told how to compile my sass stylesheets

  Scenario: Compiling a project with errors
    Given I am using the existing project in test/fixtures/stylesheets/compass
    And the project has a file named "sass/error.scss" containing:
      """
        .broken {
      """
    When I run: compass compile
    Then the command exits with a non-zero error code

  Scenario: Creating a bare project with a framework
    When I create a project using: compass create bare_project --using blueprint --bare
    Then an error message is printed out: A bare project cannot be created when a framework is specified.
    And the command exits with a non-zero error code

  Scenario: Compiling an existing project.
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    Then a directory tmp/ is created
    And a css file tmp/layout.css is created
    And a css file tmp/print.css is created
    And a css file tmp/reset.css is created
    And a css file tmp/utilities.css is created

  Scenario: Compiling an existing project with a separate output-dir
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    Then a directory tmp/ is created
    And a css file tmp/layout.css is created
    And a css file tmp/print.css is created
    And a css file tmp/reset.css is created
    And a css file tmp/utilities.css is created
    When I run: compass compile --output-dir tmp-css 
    Then a directory tmp-css/ is created
    And a css file tmp-css/layout.css is created
    And tmp-css/layout.css and tmp/layout.css are the same
    And a css file tmp-css/print.css is created
    And tmp-css/print.css and tmp/print.css are the same
    And a css file tmp-css/reset.css is created
    And tmp-css/reset.css and tmp/reset.css are the same
    And a css file tmp-css/utilities.css is created
    And tmp-css/utilities.css and tmp/utilities.css are the same

  Scenario: Compiling an existing project with a separate output-dir and relative-assets
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --relative-assets
    Then a directory tmp/ is created
    And a css file tmp/layout.css is created
    And a css file tmp/print.css is created
    And a css file tmp/reset.css is created
    And a css file tmp/utilities.css is created
    And a css file tmp/sprites.css is created
    When I run: compass compile --output-dir tmp-output/css/ --relative-assets
    And a css file tmp-output/css/sprites.css is created
    And tmp-output/css/sprites.css and tmp/sprites.css are the same
    When I run: compass compile --css-dir tmp-css/css/ --relative-assets
    Then a directory tmp-css/css/ is created
    And a css file tmp-output/css/sprites.css is created
    But tmp-css/css/sprites.css and tmp/sprites.css are not the same
    And tmp-css/css/sprites.css and tmp-output/css/sprites.css are not the same

  Scenario: Compiling an existing project with a specified project
    Given I am using the existing project in test/fixtures/stylesheets/compass
    And I am in the parent directory
    When I run: compass compile tmp_compass
    Then a directory tmp_compass/tmp/ is created
    And a css file tmp_compass/tmp/layout.css is created
    And a css file tmp_compass/tmp/print.css is created
    And a css file tmp_compass/tmp/reset.css is created
    And a css file tmp_compass/tmp/utilities.css is created

  Scenario: Compiling an existing project with a specified project with an output-dir
    Given I am using the existing project in test/fixtures/stylesheets/compass
    And I am in the parent directory
    And I should clean up the directory: tmp_compass_tmp
    When I run: compass compile tmp_compass --output-dir tmp_compass_tmp
    Then a directory tmp_compass_tmp/ is created
    But a directory tmp_compass/tmp is not created
    And a css file tmp_compass_tmp/layout.css is created
    And a css file tmp_compass_tmp/print.css is created
    And a css file tmp_compass_tmp/reset.css is created
    And a css file tmp_compass_tmp/utilities.css is created

  Scenario: Dry Run of Compiling an existing project.
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --dry-run
    Then a directory tmp/ is not created
    And a css file tmp/layout.css is not created
    And a css file tmp/print.css is not created
    And a css file tmp/reset.css is not created
    And a css file tmp/utilities.css is not created
    And a css file tmp/layout.css is reported created
    And a css file tmp/print.css is reported created
    And a css file tmp/reset.css is reported created
    And a css file tmp/utilities.css is reported created

  Scenario: Recompiling a project with no changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I run: compass compile

  Scenario: compiling a specific file in a project
    Given I am using the existing project in test/fixtures/stylesheets/compass
    And I run: compass compile sass/utilities.scss
    Then a sass file sass/layout.sass is not mentioned
    And a sass file sass/print.sass is not mentioned
    And a sass file sass/reset.sass is not mentioned
    And a css file tmp/utilities.css is reported created
    And a css file tmp/utilities.css is created

  Scenario: compiling a specific file in a project with output-dir
    Given I am using the existing project in test/fixtures/stylesheets/compass
    And I run: compass compile sass/utilities.scss --output-dir css_tmp
    Then a sass file sass/layout.sass is not mentioned
    And a sass file sass/print.sass is not mentioned
    And a sass file sass/reset.sass is not mentioned
    And a css file css_tmp/utilities.css is reported created
    And a css file css_tmp/utilities.css is created

  Scenario: Re-compiling a specific file in a project with no changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I run: compass compile sass/utilities.scss --force
    Then a sass file sass/layout.sass is not mentioned
    And a sass file sass/print.sass is not mentioned
    And a sass file sass/reset.sass is not mentioned
    And a css file tmp/utilities.css is reported identical

  Scenario: Re-compiling a specific file in a project with output-dir but no changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --output-dir tmp-css
    And I run: compass compile sass/utilities.scss --output-dir tmp-css --force
    Then a sass file sass/layout.sass is not mentioned
    And a sass file sass/print.sass is not mentioned
    And a sass file sass/reset.sass is not mentioned
    And a css file tmp-css/utilities.css is reported identical

  Scenario: Re-compiling a specific file in a project with no changes but a new output-dir
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I run: compass compile sass/utilities.scss --output-dir css_tmp
    Then a sass file sass/layout.sass is not mentioned
    And a sass file sass/print.sass is not mentioned
    And a sass file sass/reset.sass is not mentioned
    And a css file tmp/utilities.css is created

  Scenario: Installing a pattern into a project
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass install compass/pie
    Then a sass file sass/pie.scss is created

  Scenario: Basic help
    When I run: compass help
    Then I should see the following "primary" commands:
      | clean   |
      | compile |
      | create  |
      | init    |
      | watch   |
    And I should see the following "other" commands:
      | config      |
      | extension   |
      | frameworks  |
      | help        |
      | imports     |
      | install     |
      | interactive |
      | sprite      |
      | stats       |
      | unpack      |
      | validate    |
      | version     |

  Scenario: Recompiling a project with no material changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I wait 1 second
    And I touch sass/layout.sass
    And I run: compass compile
    Then a css file tmp/layout.css is reported identical

  Scenario: Recompiling a project with changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I wait 1 second
    And I add some sass to sass/layout.sass
    And I run: compass compile
    And a css file tmp/layout.css is reported overwritten

  Scenario: Recompiling a project with output-dir and no material changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --output-dir test-css
    And I wait 1 second
    And I touch sass/layout.sass
    And I run: compass compile --output-dir test-css
    Then a css file test-css/layout.css is reported identical

  Scenario: Recompiling a project with output-dir and changes
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --output-dir test-css
    And I wait 1 second
    And I add some sass to sass/layout.sass
    And I run: compass compile --output-dir test-css
    And a css file test-css/layout.css is reported overwritten

  Scenario: Cleaning a project
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I run: compass clean
    Then the following files are reported removed:
      | .sass-cache/                |
      | tmp/border_radius.css       |
      | tmp/box.css                 |
      | tmp/box_shadow.css          |
      | tmp/columns.css             |
      | tmp/fonts.css               |
      | images/flag-s5b4f509715.png |
    And the following files are removed:
      | .sass-cache/                |
      | tmp/border_radius.css       |
      | tmp/box.css                 |
      | tmp/box_shadow.css          |
      | tmp/columns.css             |
      | tmp/fonts.css               |
      | images/flag-s5b4f509715.png |

  Scenario: Cleaning a project with output-dir 
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --output-dir output-dir
    And I run: compass clean --output-dir output-dir
    Then the following files are reported removed:
      | .sass-cache/                 |
      | output-dir/border_radius.css |
      | output-dir/box.css           |
      | output-dir/box_shadow.css    |
      | output-dir/columns.css       |
      | output-dir/fonts.css         |
      | images/flag-s5b4f509715.png  |
    And the following files are removed:
      | .sass-cache/                 |
      | output-dir/border_radius.css |
      | output-dir/box.css           |
      | output-dir/box_shadow.css    |
      | output-dir/columns.css       |
      | output-dir/fonts.css         |
      | images/flag-s5b4f509715.png  |

  Scenario: Watching a project for changes
    Given ruby supports fork
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile
    And I run in a separate process: compass watch 
    And I wait 3 seconds
    And I touch sass/layout.sass
    And I wait 2 seconds
    And I shutdown the other process
    Then a css file tmp/layout.css is reported identical

  Scenario: Watching a project with output-dir for changes
    Given ruby supports fork
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass compile --output-dir output-dir
    And I run in a separate process: compass watch --output-dir output-dir
    And I wait 3 seconds
    And I touch sass/layout.sass
    And I wait 2 seconds
    And I shutdown the other process
    Then a css file output-dir/layout.css is reported identical

  Scenario: Generate a compass configuration file
    Given I should clean up the directory: config
    When I run: compass config config/compass.rb --sass-dir sass --css-dir assets/css
    Then a configuration file config/compass.rb is created
    And the following configuration properties are set in config/compass.rb:
      | property | value      |
      | sass_dir | sass       |
      | css_dir  | assets/css |

  Scenario Outline: Print out a configuration value
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: compass config -p <property>
    Then I should see the following output: <value>
    And the command exits <exit>
  
    Examples:
      | property        | value                    | exit     |
      | extensions_dir  | extensions               | normally |
      | extensions_path | $PROJECT_PATH/extensions | normally |
      | css_dir         | tmp                      | normally |
      | css_path        | $PROJECT_PATH/tmp        | normally |
      | sass_dir        | sass                     | normally |
      | sass_path       | $PROJECT_PATH/sass       | normally |
      | foobar          | ERROR: configuration property 'foobar' does not exist | with a non-zero error code | 

  @validator
  Scenario: Validate the generated CSS
    Given I am using the existing project in test/fixtures/stylesheets/valid
    When I run: compass validate
    Then my css is validated
    And I am informed that my css is valid.

  @stats
  Scenario: Get stats for my project
    Given I am using the existing project in test/fixtures/stylesheets/compass
    When I run: bundle exec compass stats
    Then I am told statistics for each file:
      | Filename                  | Rules | Properties |    Mixins Defs | Mixins Used | Filesize | CSS Selectors | CSS Properties | CSS Filesize |
      | sass/border_radius.scss   |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/box.sass             |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/fonts.sass           |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/gradients.sass       |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/image_size.sass      |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/images.scss          |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/layout.sass          |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/legacy_clearfix.scss |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/lists.scss           |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/print.sass           |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/reset.sass           |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | sass/utilities.scss       |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |
      | Total.*                   |   \d+ |        \d+ |            \d+ |         \d+ |  \d+ K?B |           \d+ |            \d+ |      \d+ K?B |

  @listframeworks
  Scenario: List frameworks registered with compass
    When I run: compass frameworks
    Then I should see the following lines of output:
      | compass    |

