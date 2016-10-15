#!/usr/bin/env perl6

use v6;
use Inline::Perl5;

%*ENV<CATALYST_SCRIPT_GEN> = 40;

use lib:from<Perl5> 'lib';

use Catalyst::ScriptRunner:from<Perl5>;
Catalyst::ScriptRunner.run('XStats', 'Server');
