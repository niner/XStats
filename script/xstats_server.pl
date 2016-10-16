#!/usr/bin/env perl

use Inline::Perl6 0.08;

$ENV{CATALYST_SCRIPT_GEN} = 40;

use lib 'lib';

use Catalyst::ScriptRunner;
Catalyst::ScriptRunner->run('XStats', 'Server');
