@develop
Feature: Archive
  In order to review previous articles posted in the journal
  As a website user
  I need an archive section

  Scenario: Display general archive listing
    Given I am on "/archive"
    Then the response status code should be 200
    And I should see "Article archive" in the "h1" element

  Scenario Outline: Access a yearly overview
    Given I am on "/archive/<year>"
    Then the response status code should be <status_code>

    Examples:
    | year | status_code |
    | 2012 | 200 |
    | 2013 | 200 |
    | 1979 | 404 |
    | 2011 | 404 |
    | 2014 | 404 |
    | 2032 | 404 |

  Scenario: Click on month from yearly archive
    Given I am on "/archive/2012"
    And I follow "October 2012"
    Then the response status code should be 200
    And the url should match "/archive/2012/10"
    And I should see text matching "Published on October *"

  Scenario Outline: Appropriate heading set for archive listing
    Given I am on "/archive/<url>"
    Then I should see "Article archive, <date>" in the "h1" element

    Examples:
      | url | date |
      | 2012 | 2012 |
      | 2012/10 | October 2012 |
      | 2013/05 | May 2013 |

  Scenario Outline: Use the archive jump to dropdown
    Given I am on "/archive/2013"
    When I select "<option>" from "elife_archive_month"
    And I press "Go"
    Then the url should match "/archive/<url>"

    Examples:
    | option | url |
    | February 2013 | 2013/02 |
    | November 2012 | 2012/11 |

  @javascript
  Scenario Outline: Use the archive jump to dropdown (javascript)
    Given I am on "/archive/2013"
    When I select "<option>" from "elife_archive_month"
    Then the url should match "/archive/<url>"

    Examples:
    | option | url |
    | February 2013 | 2013/02 |
    | November 2012 | 2012/11 |

  Scenario Outline: Correct number of articles for month
    Given I am on "/archive/<url>"
    Then I should see <num> ".highwire-article-citation" elements

    Examples:
    | url | num |
    | 2013/02 | 15 |
    | 2013/01 | 16 |
    | 2012/12 | 26 |
    | 2012/11 | 7 |
    | 2012/10 | 13 |

  Scenario Outline: Redirect if month does not have leading zero in url
    Given I am on "/archive/<url>"
    Then the url should match "/archive/<new_url>"

    Examples:
      | url | new_url |
      | 2013/9 | 2013/09 |
      | 2013/1 | 2013/01 |
      | 2012/10 | 2012/10 |
