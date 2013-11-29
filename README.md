Behat - elifesciences.org
=========================

* check out this repo
* cd into the project folder
* run 'curl http://getcomposer.org/installer | php'
* run php composer.phar install
* run './bin/behat'

To setup sahi for running javascript browsers goto and follow the steps to install sahi and phantomjs:

* http://shaneauckland.co.uk/2012/11/headless-behatmink-testing-with-sahi-and-phantomjs/

Until you have the ability to run a javascript browser then use the behat command:

* ./bin/behat --tags '~@javascript'

That will run all but the javascript scenarios
