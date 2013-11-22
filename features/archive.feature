Feature: Archive
  In order to review previous articles posted in the journal
  As a website user
  I need to be able to access a monthly archive of articles

  Scenario: Access a yearly overview
    Given I am on "/archive/2012"
    Then the response status code should be 200
