#!/usr/bin/env perl6

use v6;
use Inline::Perl5;

%*ENV<CATALYST_SCRIPT_GEN> = 40;

my $p5 = Inline::Perl5.new;

class Perl6ObjectCreator {
    method create($package, $parent) {
        warn $package;
        warn $parent;
        warn $p5;
        warn XStats::Controller::Root.new(perl5 => $p5, parent => $parent);
    }
}

$p5.run('use lib qw(lib)');
$p5.run('
    sub init_perl6_object_creator {
        $Perl6::ObjectCreator = shift;
    }
');
$p5.call('init_perl6_object_creator', Perl6ObjectCreator.new);
$p5.use('Catalyst::ScriptRunner');
$p5.invoke('Catalyst::ScriptRunner', 'run', 'XStats', 'Server');
