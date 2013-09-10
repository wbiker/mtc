use strict;
use warnings;

use mtc;

my $app = mtc->apply_default_middlewares(mtc->psgi_app);
$app;

