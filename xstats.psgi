use strict;
use warnings;

use XStats;

my $app = XStats->apply_default_middlewares(XStats->psgi_app);
$app;

