use strict;
use warnings;
use FindBin qw($Bin);

use lib "$Bin/lib";
use Inline::Perl6;
BEGIN { Inline::Perl6::initialize; }
use XStats;

my $app = XStats->apply_default_middlewares(XStats->psgi_app);
$app;
