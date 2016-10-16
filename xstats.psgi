use strict;
use warnings;
use FindBin qw($Bin);

use lib "$Bin/lib";
use Inline::Perl6 0.08;
use XStats;

my $app = XStats->apply_default_middlewares(XStats->psgi_app);
$app;
