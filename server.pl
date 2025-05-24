#!/usr/bin/env perl

use strict;
use warnings;

use FCGI;
use DateTime;

my $price = 10.85;

my $start_time = DateTime->new(
    year => 2025,
    month => 5,
    day => 23,
    hour => 17,
    minute => 25,
    second => 0,
    time_zone => 'America/Chicago');

my $end_time = DateTime->new(
    year => 2025,
    month => 7,
    day => 4,
    hour => 23,
    minute => 59,
    second => 59,
    time_zone => 'America/Chicago');

my $request = FCGI::Request();
while($request->Accept() >= 0) {
    my $seconds_since_start = DateTime->now(time_zone => 'America/Chicago')->epoch - $start_time->epoch;
    my $total_seconds = $end_time->epoch - $start_time->epoch;
    my $fraction_remaining = 1 - ($seconds_since_start / $total_seconds);

    my $header = do {
        if ($fraction_remaining > 0) {
            sprintf('Balance Remaining: $%.2f (%.3f%%)', $fraction_remaining * $price, 100 * $fraction_remaining);
        } else {
            "Paid Off!";
        }
    };

    print("Content-type: text/html\r\n\r\n");
    print <<"HTML";
<html>
  <head>
    <title>Erysichthon</title>
    <link rel="stylesheet" type="text/css" href="/static/styles.css"/>
  </head>
  <body>
    <h2>${header}</h2>
    <hr>
    <img src="/static/burrito.jpg" class="center-img"/>
    <p>I purchased this burrito using a buy now pay later service. It took me approximately 15 minutes to eat. But how long will it take to pay off?</p>
    <img src="/static/schedule.png" class="center-img"/>
    <p>Neat! The wonders of modern micro-credit infrastructure make it possible for me to defer payment on this asset for <em>6 weeks</em>. So the financial aftershocks of this momentuous purchase won't be resolved until at least July 4th. Quite possibly longer as that's a holiday and my bank probably won't process a payment until the next Monday. Surely the fact that <a href="https://web.archive.org/web/20250515080232/https://www.cnbc.com/2025/04/26/americans-groceries-buy-now-pay-later-loans.html">millions of people</a> are using loans to buy goods with a shorter shelf life than the loan terms is a sign of a healthy financial market.</p>
    <p>I've calculated an approximation of the balance remaining by assuming that the loan is paid off at a constant rate second-by-second for its whole lifetime. This of course isn't true (you can see the repayment schedule above), but it's not a bad approximation given that the loan is interest free (which begs the question <a href="https://web.archive.org/web/20250409123846/https://www.npr.org/2022/06/12/1104460692/who-actually-pays-with-buy-now-pay-later-companies-like-klarna-and-affirm">how do they make money?</a>). I'm definitely looking forward to the <a href="https://www.tandfonline.com/doi/full/10.1080/17530350.2024.2346210">sense of accomplishment</a> I get when it hits zero though!</p>
    <hr>
    <blockquote><p>In the end when the evil had consumed everything they had, and his grave disease needed ever more food, <a href="https://en.wikipedia.org/wiki/Erysichthon_of_Thessaly">Erysichthon</a> began to tear at his limbs and gnaw them with his teeth, and the unhappy man fed, little by little, on his own body.</p></blockquote>
    <p> - Ovid: <em>The Metamorphoses</em></p>
    <hr>
    <a href="https://erysichthon.packrat386.com/">Erysichthon</a> Copyright 2025 by <a href="https://packrat386.com">packrat386</a> is licensed under <a href="https://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a><img src="https://mirrors.creativecommons.org/presskit/icons/cc.svg" style="max-width: 1em;max-height:1em;margin-left: .2em;"><img src="https://mirrors.creativecommons.org/presskit/icons/by.svg" style="max-width: 1em;max-height:1em;margin-left: .2em;"><img src="https://mirrors.creativecommons.org/presskit/icons/sa.svg" style="max-width: 1em;max-height:1em;margin-left: .2em;">
  </body>
</html>
HTML
}
