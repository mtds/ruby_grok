A Ruby script to test Grok patterns against log files
=====================================================

The idea of this script came from the [Ruby implementation of Grok](https://github.com/jordansissel/ruby-grok) made by Jordan Sissel.

Usage
-----

Simple test from the command line:
~~~
grok_test.rb logfile.log mypatterns
~~~

A pattern file example, containing just the most basic one:
~~~
%{SYSLOGBASE}
~~~

A simple log file is provided under the examples directory. Once the script is
executed it will produce the following output:

~~~
-----------
Match found:
-----------
{"SYSLOGBASE"=>["Oct 16 21:43:08 lxi077 sshd[15188]:"],
 "timestamp"=>["Oct 16 21:43:08"],
 "MONTH"=>["Oct"],
 "MONTHDAY"=>["16"],
 "TIME"=>["21:43:08"],
 "HOUR"=>["21"],
 "MINUTE"=>["43"],
 "SECOND"=>["08"],
 "SYSLOGFACILITY"=>[nil],
 "facility"=>[nil],
 "priority"=>[nil],
 "logsource"=>["lxi077"],
 "IPORHOST"=>["lxi077"],
 "IP"=>[nil],
 "IPV6"=>[nil],
 "IPV4"=>[nil],
 "HOSTNAME"=>["lxi077"],
 "SYSLOGPROG"=>["sshd[15188]"],
 "program"=>["sshd"],
 "pid"=>["15188"]}
~~~
