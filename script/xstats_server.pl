#!/usr/bin/env perl

use Inline::Perl6;
BEGIN { Inline::Perl6::initialize; }

$ENV{CATALYST_SCRIPT_GEN} = 40;

use lib 'lib';

use Catalyst::ScriptRunner;
Catalyst::ScriptRunner->run('XStats', 'Server');
