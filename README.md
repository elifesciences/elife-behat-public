Behat - elifesciences.org
=========================

* check out this repo
* cd into the project folder
* run 'curl http://getcomposer.org/installer | php'
* run php composer.phar install
* run './bin/behat'


## Setting up Javascript testing with Sahi and phantomjs ##

### Prerequisites ###
If you haven't already got them on the machine, you'll need to install sahi and phantomjs for testing javascript behaviours.

#### Sahi ####
* [Download it from Sourceforge](http://sourceforge.net/projects/sahi/files/sahi-v35/20110719/install_sahi_v35_20110719.jar/download).
* Install it

#### phantomjs ####
* On OSX, it's easy: 'brew update && brew install phantomjs'.
* For other OSs, see [http://phantomjs.org/download.html](http://phantomjs.org/download.html).

### Setup ###
Be sure Behat knows to use sahi and phantomjs, ```behat.yml``` should look like this:

    default:
      paths:
        bootstrap:  '%behat.paths.features%/bootstrap'
      extensions:
        Behat\MinkExtension\Extension:
          base_url: URL_UNDER_TEST
     >>>  javascript_session: sahi
     >>>  browser_name: phantomjs
          goutte: ~
          sahi: ~

Additionally, Sahi needs to know where phantomjs is, and how to handle it. Tell it by adding the following to ```[sahi_location]/userdata/config/brower_types.xml```. Ensure that the ```<path>``` to phantomjs is correct for your environment, and edit ```<options>``` to provide the full path to ```phantom-sahi.js```.

    <browserType>
        <name>phantomjs</name>
        <displayName>PhantomJS</displayName>
        <icon>chrome.png</icon>
    >>> <path>/usr/local/bin/phantomjs</path>
    >>> <options>--proxy=localhost:9999 $userDir/config/phantom-sahi.js</options>
        <processName>phantomjs</processName>
        <capacity>100</capacity>
            <force>true</force>
    </browserType>

#### What's phantom-sahi.js? ####
It bridges between sahi and phantom. Copy the following, save it to the path specified in ```<options>``` above, and there you go:

    if (phantom.args.length === 0) {
    console.log('Usage: sahi.js <Sahi Playback Start URL>');
        phantom.exit();
    } else {
        var address = phantom.args[0];
            console.log('Loading ' + address);
        var page = new WebPage();
            page.open(address, function(status) {
            if (status === 'success') {
                var title = page.evaluate(function() {
                        return document.title;
        });
                console.log('Page title is ' + title);
            } else {
                console.log('FAIL to load the address');
                }
        });
    }


(Sahi and phantomjs info abstracted from [http://shaneauckland.co.uk/2012/11/headless-behatmink-testing-with-sahi-and-phantomjs/](http://shaneauckland.co.uk/2012/11/headless-behatmink-testing-with-sahi-and-phantomjs/)

### Running ###
* Start Sahi:
    * ```cd [sahi_location]/bin/```
    * ```./sahi.sh```
    * This should tell you that Sahi is running on port 9999, and that it's reading the browser_types.xml file from the location you edited above.

* Run the tests:
    * ```cd [root of this repo]```
    * All tests: ```./bin/behat```
    * All except JavsScript tests: ```./bin/behat --tags '~@javascript'```
    * Only JavaScript tests: ```./bin/behat --tags '@javascript'```


### Troubleshooting ###
#### Sahi doesn't start, or starts, but not on port 9999 ####
Check ```browser_types.xml``` contains a definintion (```<browserType>``` element), for phantomjs, its path is correct, and that a proxy is defined for it on port 9999 (within ```<options>```).

#### Behat times out when running JavaScript tests ####
One reason this happens is that Sahi can't find ```phantom-sahi.js```. Ensure that its path is correct in the definition of phanotomjs in ```browser_types.xml```.
