package XStats::Model::Awstats;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';
with 'CatalystX::Perl6::Component';

__PACKAGE__->init_metaclass;
__PACKAGE__->meta->make_immutable;

use v6-inline;

also does Inline::Perl5::Perl5Parent['XStats::Model::Awstats'];
also does CatalystX::Perl6::Component;

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
        BEGIN_(<name>) <.ws>*? \d* \n
        <line>*?
        END_$0 \n?
    }
    token name {
        \w+
    }
    token line {
        ^^ <name> (\N*) $$ \n?
    }
}

method parse($c) {
    return Awstats.parsefile('awstats.txt');
}
