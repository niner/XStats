package XStats::Model::Awstats;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

__PACKAGE__->meta->make_immutable;

use v6-inline;

grammar Awstats {
    token TOP {
        <header>
        <body>
    }
    token header {
        ^AWSTATS .*? $$ \n?
    }
    token body {
        [
            <.comment>
            | <.empty>
            | <block>
        ]+
    }
    token comment {
            [
            ^^
            '#'
            \N*
            $$
            \n?
            ]+
    }
    token empty {
        ^^ $$ \n?
    }
    token block {
        <block_day>
        | <.generic_block>
    }
    token block_day {
        BEGIN_DAY ' ' \d+ \n
        <line_day>*?
        END_DAY \n?
    }
    token line_day {
        <date> ' ' \d+ ' ' \d+ ' ' \d+ ' ' <visits> \n
    }
    token date {
        <year> <month> <day>
    }
    token year {
        \d**4
    }
    token month {
        \d\d
    }
    token day {
        \d\d
    }
    token visits {
        \d+
    }
    token generic_block {
        BEGIN_ <!before DAY>(<name>) ' ' \d+ \n
        <line>*?
        END_$0 \n?
    }
    token name {
        \w+
    }
    token line {
        ^^ (\N*) $$ \n?
    }
}

class AwstatsActions {
    has $.days is rw;
    method block_day($match) {
        $.days = $match;
    }
}

method parse($c) {
    my $actions = AwstatsActions.new;
    Awstats.parsefile('awstats.txt', :actions($actions));
    return $actions;
}
