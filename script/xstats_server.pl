#!/usr/bin/env perl6

use v6;
use Inline::Perl5;

%*ENV<CATALYST_SCRIPT_GEN> = 40;

class Perl6ObjectCreator {
    method create($package, $parent) {
        ::($package).WHAT.new(parent => $parent);
    }
}

use lib:from<Perl5> 'lib';
BEGIN EVAL '
    sub init_perl6_object_creator {
        $Perl6::ObjectCreator = shift;
    }
', :lang<Perl5>;
Inline::Perl5.default_perl5.call('init_perl6_object_creator', Perl6ObjectCreator.new);

use Catalyst::ScriptRunner:from<Perl5>;
Catalyst::ScriptRunner.run('XStats', 'Server');
